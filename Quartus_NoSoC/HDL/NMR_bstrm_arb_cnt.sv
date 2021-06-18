// author: David Ariando
// date: 17th June 2021
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
// the sequence coded along with the end_of_sequence bit won't be streamed out, so make sure the last doesn't contain any streaming output.

module NMR_bstrm_arb_cnt 
#(
	parameter DATA_WIDTH = 120, // the initial delay width
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
	output reg DPATH_START,
	input DPATH_BUF_RDY, // indicates that the datapath is ready to receive data
	output reg [DATA_WIDTH-1:0] data_reg,
	output reg seq_end_reg, // the end of sequence signal
	output reg pattern_mode_reg,	// pattern mode signal
	output reg all_1s_mode_reg,	// all 1s mode signal
	output reg all_0s_mode_reg,	// all 0s mode signal
	
	// control signals
	input CLK,
	input RST
);
	
	
	reg loop_sta_reg; // the loop start signal
	reg loop_sto_reg; // the loop stop signal
	
	reg [CMD_WIDTH-1:0] cmd_ctr; // the command counter
	reg [LOOP_WIDTH-1:0] loop_ctr; // the loop counter
	reg [CMD_WIDTH-1:0] loop_sta_addr; // the loop start saved address
	
	assign SRAM_CLKEN = 1'b1;
	assign SRAM_WR = 1'b0;
	assign SRAM_BYTEEN = {SRAM_BYTEEN_WIDTH{1'b1}}; // put all to one to enable all the bytes, probably not necessary for reading the data
	assign SRAM_WR_DAT = {SRAM_DAT_WIDTH{1'b0}};
	
	reg [12:0] State;
	localparam [12:0]
		S0 = 13'b0000000000001,
		S1 = 13'b0000000000010,
		S2 = 13'b0000000000100,
		S3 = 13'b0000000001000,
		S4 = 13'b0000000010000,
		S5 = 13'b0000000100000,
		S6 = 13'b0000001000000,
		S7 = 13'b0000010000000,
		S8 = 13'b0000100000000,
		S9 = 13'b0001000000000,
		S10= 13'b0010000000000,
		S11= 13'b0100000000000,
		S12= 13'b1000000000000;

	initial begin
		State <= S0;
		DPATH_START <= 1'b0;
		SRAM_CS <= 1'b0;
		data_reg <= {DATA_WIDTH{1'b0}};
		SRAM_ADDR <= {SRAM_ADDR_WIDTH{1'b0}};
		DONE <= 1'b0;
		
		data_reg           <= {DATA_WIDTH{1'b0}};
		seq_end_reg        <= 1'b0;
		pattern_mode_reg   <= 1'b0;
		all_1s_mode_reg    <= 1'b0;
		all_0s_mode_reg    <= 1'b0;
		
	end

	
	always @(posedge CLK, posedge RST)
	begin
		
		if (RST)
		begin
			State <= S0;
			DPATH_START <= 1'b0;
			SRAM_CS <= 1'b0;
			data_reg <= {DATA_WIDTH{1'b0}};
			SRAM_ADDR <= {SRAM_ADDR_WIDTH{1'b0}};
			DONE <= 1'b0;
			
			data_reg           <= {DATA_WIDTH{1'b0}};
			seq_end_reg        <= 1'b0;
			pattern_mode_reg   <= 1'b0;
			all_1s_mode_reg    <= 1'b0;
			all_0s_mode_reg    <= 1'b0;
			
		end
		
		else
		begin
		
			case (State)
			
				S0:
				begin
					
					cmd_ctr <= {CMD_WIDTH{1'b0}};
					loop_ctr <= {LOOP_WIDTH{1'b0}};
					
					if (START == 1'b1)
						State <= S1;
					
				end		
				
				S1: // load parameter from the SRAM to the local memory
				begin
					
					SRAM_CS <= 1'b1;
					SRAM_ADDR <= cmd_ctr;

					cmd_ctr <= cmd_ctr + 1'b1; // increment counter to 1
				
					State <= S2;
					
				end
				
				S2: // delay one clock cycle to process data
				begin
										
					State <= S3;
					SRAM_CS <= 1'b0;
					
				end
				
				S3: // read the repetition parameter
				begin
					
					loop_ctr <= {1'b1,{(LOOP_WIDTH-1){1'b0}}} - SRAM_RD_DAT[LOOP_WIDTH-1:0] + 1'b1; // 16 is a fix offset bit to store the loop parameter
					
					State <= S4;
					
				end
				
				S4: // load parameter from SRAM
				begin
				
					SRAM_CS <= 1'b1;
					SRAM_ADDR <= cmd_ctr;
					
					State <= S5;
					
				end
				
				
				S5: // read the iteration parameter from the SRAM
				begin
				
					SRAM_CS <= 1'b0;
					
					State <= S6;

				end
				
				S6: // read the command
				begin
				
					DPATH_START <= 1'b1;
				
					seq_end_reg <= SRAM_RD_DAT[127];
					loop_sta_reg <= SRAM_RD_DAT[126];
					loop_sto_reg <= SRAM_RD_DAT[125];
					pattern_mode_reg <= SRAM_RD_DAT[124];
					all_1s_mode_reg <= SRAM_RD_DAT[123];
					all_0s_mode_reg <= SRAM_RD_DAT[122];
					data_reg <= SRAM_RD_DAT[DATA_WIDTH-1:0];							
					
					State <= S7;
				
				end
				
				S7: // parse the command
				begin
					
					DPATH_START <= 1'b0;
					
					if (seq_end_reg == 1'b1) State <= S12; // process end of sequence
					else if (loop_sta_reg == 1'b1) State <= S8; // process loop start
					else if (loop_sto_reg == 1'b1) State <= S9; // process loop stop
					else State <= S10; // no loop flag
					
				end
				
				S8: // process loop start command
				begin
				
					loop_sta_addr <= cmd_ctr;
					
					State <= S10;
					
				end
				
				S9: // process loop stop command
				begin
				
					loop_ctr <= loop_ctr + 1'b1;
					
					if (loop_ctr[LOOP_WIDTH-1] ==  1'b1)
						cmd_ctr <= cmd_ctr;
					else
						cmd_ctr <= loop_sta_addr - 1'b1;
					
					State <= S10;
					
				end
				
				S10: // send the data out
				begin
										
					if (DPATH_BUF_RDY == 1'b1) // wait until previous bitstream is received by datapath
					begin
					
						State <= S11;

					end
				end
				
				S11: // start the FSM
				begin
					
					cmd_ctr <= cmd_ctr + 1'b1;
					
					State <= S4;
					
				end
				
				
				S12: // the end of the sequence
				begin
					
					DONE <= 1'b1;
					
					if (START == 1'b0)
						State <= S0;
					
				end
			
			endcase
		
		end
		
	end

endmodule