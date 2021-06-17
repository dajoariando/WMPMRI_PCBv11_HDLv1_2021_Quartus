// author: David Ariando
// date: 15th June 2021
// operation details:
// this module takes a variable of ....
// and ...
// data format: [idly, pls, edly, cnt] or [initial delay, pulse length, delay post-pulse, control signal]
// the control signal format is:
// 		bit 31:16	- number of repetition
//		bit 2		- end of sequence
//		bit 1		- start loop
//		bit 0		- end loop

// restrictions:
// the loop start and loop stop cannot be at the same data. Otherwise only loop start will be read.
// the loop number put into the SRAM is maximum 15-bit, because the first bit is used as the counter overflow bit.
// the loop start cannot be at the first bitstream, put it into the 2nd one at least

module NMR_bit_streamer_cnt 
#(
	parameter IDLY_WIDTH = 32, // the initial delay width
	parameter PLS_WIDTH = 32, // the pulse width
	parameter EDLY_WIDTH = 32, // post-pulse delay width
	parameter CNT_WIDTH = 32,	// the control signal width
	parameter CMD_WIDTH = 8,		// the command counter width
	parameter LOOP_WIDTH = 16,		// loop width for the looping parameter
	parameter SRAM_ADDR_WIDTH = 8, // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter SRAM_DAT_WIDTH = 128, // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter SRAM_BYTEEN_WIDTH = 16 // the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
)
(
	// bitstream signals
	input START,
	output reg DONE,
	
	// SRAM access
	output reg [SRAM_ADDR_WIDTH-1:0] SRAM_ADDR,	// SRAM address
	output reg SRAM_CS,		// SRAM chip select
	output SRAM_CLKEN,		// SRAM clock enable
	output SRAM_WR,			// SRAM write
	input [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT,		// SRAM read data
	output [SRAM_DAT_WIDTH-1:0]	SRAM_WR_DAT,		// SRAM write data
	output [SRAM_BYTEEN_WIDTH-1:0] SRAM_BYTEEN,		// SRAM byte enable
	
	// bitstream control data
	output reg BT_START,
	input BT_DONE,
	output reg [IDLY_WIDTH-1:0] idly_reg,
	output reg [PLS_WIDTH-1:0] pls_reg,
	output reg [EDLY_WIDTH-1:0] edly_reg, 
	
	// control signals
	input CLK,
	input RST
);
	
	
	reg loop_sta_reg; // the loop start signal
	reg loop_sto_reg; // the loop stop signal
	reg seq_end_reg; // the end of sequence signal
	
	reg [CMD_WIDTH-1:0] cmd_ctr; // the command counter
	reg [LOOP_WIDTH-1:0] loop_ctr; // the loop counter
	reg [CMD_WIDTH-1:0] loop_sta_addr; // the loop start saved address
	reg first_rd; // indicate the first reading of the SRAM to get loop parameter once every START signal
	
	assign SRAM_CLKEN = 1'b1;
	assign SRAM_WR = 1'b0;
	assign SRAM_BYTEEN = {SRAM_BYTEEN_WIDTH{1'b1}}; // put all to one to enable all the bytes, probably not necessary for reading the data
	assign SRAM_WR_DAT = {SRAM_DAT_WIDTH{1'b0}};
	
	reg [8:0] State;
	localparam [8:0]
		S0 = 9'b000000001,
		S1 = 9'b000000010,
		S2 = 9'b000000100,
		S3 = 9'b000001000,
		S4 = 9'b000010000,
		S5 = 9'b000100000,
		S6 = 9'b001000000,
		S7 = 9'b010000000,
		S8 = 9'b100000000;

	initial begin
		State <= S0;
		BT_START <= 1'b0;
		SRAM_CS <= 1'b0;
		idly_reg <= {IDLY_WIDTH{1'b0}};
		pls_reg <= {PLS_WIDTH{1'b0}};
		edly_reg <= {EDLY_WIDTH{1'b0}};
		SRAM_ADDR <= {SRAM_ADDR_WIDTH{1'b0}};
		DONE <= 1'b0;
		first_rd <= 1'b1;
	end

	
	always @(posedge CLK, posedge RST)
	begin
		
		if (RST)
		begin
			State <= S0;
			BT_START <= 1'b0;
			SRAM_CS <= 1'b0;
			idly_reg <= {IDLY_WIDTH{1'b0}};
			pls_reg <= {PLS_WIDTH{1'b0}};
			edly_reg <= {EDLY_WIDTH{1'b0}};
			SRAM_ADDR <= {SRAM_ADDR_WIDTH{1'b0}};
			DONE <= 1'b0;
			first_rd <= 1'b1;
		end
		
		else
		begin
		
			case (State)
			
				S0:
				begin
					
					cmd_ctr <= {CMD_WIDTH{1'b0}};
					loop_ctr <= {LOOP_WIDTH{1'b0}};
					first_rd <= 1'b1;
					
					if (START == 1'b1)
						State <= S1;
					
				end		
				
				S1: // load parameter from the SRAM to the local memory
				begin
					
					SRAM_CS <= 1'b1;
					SRAM_ADDR <= cmd_ctr;
					BT_START <= 1'b0;
				
					State <= S2;
					
				end
				
				S2: // read the command
				begin
					
					SRAM_CS <= 1'b0;
					
					idly_reg <= SRAM_RD_DAT[IDLY_WIDTH+PLS_WIDTH+EDLY_WIDTH+CNT_WIDTH-1 : PLS_WIDTH+EDLY_WIDTH+CNT_WIDTH];
					pls_reg <= SRAM_RD_DAT[PLS_WIDTH+EDLY_WIDTH+CNT_WIDTH-1 : EDLY_WIDTH+CNT_WIDTH];
					edly_reg <= SRAM_RD_DAT[EDLY_WIDTH+CNT_WIDTH-1 : CNT_WIDTH];
					seq_end_reg <= SRAM_RD_DAT[2];
					loop_sta_reg <= SRAM_RD_DAT[1];
					loop_sto_reg <= SRAM_RD_DAT[0];
					
					if (first_rd == 1'b1) // read the loop counter only after the START signal and only once every sequence
						loop_ctr <= {1'b1,{(LOOP_WIDTH-1){1'b0}}} - SRAM_RD_DAT[LOOP_WIDTH+16:16] + 1'b1; // 16 is a fix number to store the loop parameter
					
					State <= S3;
					
				end
				
				S3: // parse the command
				begin
					
					first_rd <= 1'b0; // disable first read flag
					
					if (seq_end_reg == 1'b1) State <= S8; // process end of sequence
					else if (loop_sta_reg == 1'b1) State <= S4; // process loop start
					else if (loop_sto_reg == 1'b1) State <= S5; // process loop stop
					else State <= S6;
					
				end
				
				S4: // process loop start command
				begin
				
					loop_sta_addr <= cmd_ctr;
					
					State <= S6;
					
				end
				
				S5: // process loop stop command
				begin
				
					loop_ctr <= loop_ctr + 1'b1;
					
					if (loop_ctr[LOOP_WIDTH-1] ==  1'b1)
						cmd_ctr <= cmd_ctr;
					else
						cmd_ctr <= loop_sta_addr - 1'b1;
					
					State <= S6;
					
				end
				
				S6:
				begin
					if (BT_DONE == 1'b1) // wait until previous bitstream is done
						State <= S7;
				end
				
				S7: // start the FSM
				begin
					
					cmd_ctr <= cmd_ctr + 1'b1;
					BT_START <= 1'b1;
					
					State <= S1;
					
				end
				
				
				S8: // the end of the sequence
				begin	
					
					DONE <= 1'b1;
					
					if (START == 1'b0)
						State <= S0;
					
				end
			
			endcase
		
		end
		
	end

endmodule