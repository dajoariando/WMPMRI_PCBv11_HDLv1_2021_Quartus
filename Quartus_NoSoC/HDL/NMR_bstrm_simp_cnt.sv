// author: David Ariando
// date: 30th March 2021
// operation details:
// // when the DPATH_RDY one clock cycle signal is asserted, the controller needs to be ready, otherwise the signal will be lost. This sets the limit for how many clock cycles are the minimum pulse length.

module NMR_bstrm_simp_cnt 
#(
	parameter CMD_WIDTH = 8,		// the command counter width
	parameter LOOP_WIDTH = 24,		// loop width for the looping parameter
	parameter SRAM_ADDR_WIDTH = 8, // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter SRAM_DAT_WIDTH = 32, // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter DATA_WIDTH = 24,
	parameter MUX_WIDTH = 16
)
(
	// bitstream signals
	input START,
	output reg DONE,
	output OUT,
	
	// SRAM access
	output reg [SRAM_ADDR_WIDTH-1:0] SRAM_ADDR,	// SRAM address
	// output reg SRAM_CS,							// SRAM chip select
	input [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT,	// SRAM read data
	
	// control signals
	input CLK,
	input RST
);
	
	// bitstream signals
	// reg SRAM_START;
	// wire SRAM_SYS_RDY;
	// wire SRAM_DATA_RDY;

	// bitstream control data
	wire [SRAM_DAT_WIDTH-1:0] SRAM_data_reg;
	
	// datapath signals
	reg DPATH_START; // one clock cycle signal for datapath start
	wire DPATH_RDY; // when the DPATH_RDY one clock cycle signal is asserted, the controller needs to be ready, otherwise the signal will be lost.
	wire DPATH_DONE;
	
	
	reg pls_pol_reg, pls_pol_reg_reg;	// pulse polarity register
	reg loop_sta_reg;	// the loop start signal
	reg loop_sto_reg;	// the loop stop signal
	reg seq_end_reg;	// end sequence signal
	reg [3:0] mux_sel_reg, mux_sel_reg_reg; // mux selector register
	reg [SRAM_DAT_WIDTH-8:0] dataval_reg, dataval_reg_reg; // data value read from the SRAM
	
	reg [CMD_WIDTH-1:0] cmd_ctr; // the command counter
	reg [LOOP_WIDTH-1:0] loop_ctr; // the loop counter
	reg [CMD_WIDTH-1:0] loop_sta_addr; // the loop start saved address
		
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
		// SRAM_CS <= 1'b0;
		dataval_reg <= {DATA_WIDTH{1'b0}};
		SRAM_ADDR <= {SRAM_ADDR_WIDTH{1'b0}};
		DONE <= 1'b0;
		
		loop_ctr <= {(LOOP_WIDTH){1'b0}};
		
		pls_pol_reg		<= 1'b0;
		seq_end_reg		<= 1'b0;
		loop_sta_reg    <= 1'b0;
		loop_sto_reg	<= 1'b0;
		
		loop_sta_addr <= {(CMD_WIDTH){1'b0}};
		
	end

	
	always @(posedge CLK, posedge RST)
	begin
		
		if (RST)
		begin
			State <= S0;
			DPATH_START <= 1'b0;
			// SRAM_CS <= 1'b0;
			dataval_reg <= {DATA_WIDTH{1'b0}};
			SRAM_ADDR <= {SRAM_ADDR_WIDTH{1'b0}};
			DONE <= 1'b0;
			
			cmd_ctr <= {CMD_WIDTH{1'b0}};
			loop_ctr <= {(LOOP_WIDTH){1'b0}};
			
			pls_pol_reg		<= 1'b0;
			seq_end_reg		<= 1'b0;
			loop_sta_reg    <= 1'b0;
			loop_sto_reg	<= 1'b0;
			mux_sel_reg 	<= 4'd0;
			
			// default value for the first bitstream output
			mux_sel_reg_reg <= 4'd0;
			dataval_reg_reg <= 10; // set to a small number of value to account for State 0 in the NMR_bstrm_simp_dpath.sv.
			pls_pol_reg_reg <= 1'b0;
			
		end
		
		else
		begin
		
			case (State)
			
				S0:
				begin
					
					cmd_ctr <= {CMD_WIDTH{1'b0}};
					DONE <= 1'b1;
					
					if (START == 1'b1)
						State <= S1;
					
				end		
				
				S1: // check if the SRAM system is ready
				begin
					
					DPATH_START <= 1'b1; // kickstart the bitstream
					
					DONE <= 1'b0;
					
					// if (SRAM_SYS_RDY == 1'b1)
					
					State <= S2;
					
				end
				
				S2: // start reading SRAM from address 0
				begin
				
					SRAM_ADDR <= cmd_ctr;
					// SRAM_START <= 1'b1;
					
					DPATH_START <= 1'b0; // disable the bitstream
					
					State <= S3;
					
				end
				
				S3: // start reading SRAM from incremental address
				begin
					
					// SRAM_START <= 1'b0;
					
					SRAM_data_reg <= SRAM_RD_DAT;
					
					// if (SRAM_DATA_RDY == 1'b1)
					
					State <= S4;
					
				end
				
				S4: // disable start signal for SRAM, wait for data ready
				begin
					
					pls_pol_reg 	<= SRAM_data_reg[SRAM_DAT_WIDTH-1];
					seq_end_reg		<= SRAM_data_reg[SRAM_DAT_WIDTH-2];
					loop_sta_reg    <= SRAM_data_reg[SRAM_DAT_WIDTH-3];
					loop_sto_reg	<= SRAM_data_reg[SRAM_DAT_WIDTH-4];
					mux_sel_reg		<= SRAM_data_reg[SRAM_DAT_WIDTH-5:SRAM_DAT_WIDTH-8];
					dataval_reg		<= SRAM_data_reg[SRAM_DAT_WIDTH-9:0];
					
					State <= S5;
					
				end
				
				
				S5: // could be merged to S4 to reduce one clock cycle
				begin
				
					if (seq_end_reg == 1'b1)
						State <= S0;
					
					else if (loop_sta_reg == 1'b1 && loop_ctr == {(LOOP_WIDTH){1'b0}} )
						State <= S6;
						
					else if (DPATH_RDY == 1'b1)
					begin	
						DPATH_START <= 1'b1; // assert DPATH_START for one clock cycle
						mux_sel_reg_reg <= mux_sel_reg;
						dataval_reg_reg <= dataval_reg;
						pls_pol_reg_reg <= pls_pol_reg;
						
						State <= S7;
					end

				end
				
				S6: // loop start bit is enabled
				begin
				
					loop_ctr <= dataval_reg - 1'b1;
					loop_sta_addr <= cmd_ctr + 1'b1; // set the loop start address to the current address + 1
					cmd_ctr <= cmd_ctr + 1'b1;
					State <= S2;
				
				end
				
				S7: // process normal output
				begin
					
					DPATH_START <= 1'b0;
					
					if (loop_sto_reg == 1'b1 && loop_ctr > 0)
					begin
						loop_ctr <= loop_ctr - 1'b1;
						cmd_ctr <= loop_sta_addr;
					end
					else
					begin					
						cmd_ctr <= cmd_ctr + 1'b1;
					end
					
					State <= S2;
					
				end
				
				S8: // 
				begin
					

					
				end
				
				S9: // 
				begin
					
					
					
					
				end
				
				S10: // 
				begin
										
				end
				
				S11: // 
				begin
					
					
				end
				
				
				S12: // 
				begin
					
					
				end
			
			endcase
		
		end
		
	end

/*
NMR_bstrm_simp_sramrd_cnt 
#(
	.SRAM_ADDR_WIDTH (SRAM_ADDR_WIDTH),		// the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
	.SRAM_DAT_WIDTH (SRAM_DAT_WIDTH)		// the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
	// parameter SRAM_BYTEEN_WIDTH = 16	// the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
)

sram1

(
	// bitstream signals
	.START		(SRAM_START),
	.SYS_RDY	(SRAM_SYS_RDY),
	.DATA_RDY	(SRAM_DATA_RDY),
	
	// SRAM access
	// .SRAM_ADDR		(SRAM_ADDR),			// SRAM address 
	.SRAM_CS		(SRAM_CS),								// SRAM chip select
	.SRAM_RD_DAT	(SRAM_RD_DAT),		// SRAM read data
	// .SRAM_ADDR_PHY	(SRAM_ADDR_PHY),		// SRAM address physical conns
	
	// bitstream control data
	.data_reg (SRAM_data_reg),
	
	// control signals
	.CLK (CLK),
	.RST (RST)
);
*/






NMR_bstrm_simp_dpath
# (

	.DATA_WIDTH (DATA_WIDTH),		// the data width
	.MUX_WIDTH  (MUX_WIDTH)		// the mux width

)
NMR_bstrm_simp_dpath_1
(

	// bitstream signals
	.START (DPATH_START),
	.DPATH_RDY (DPATH_RDY),
	
	// bitstream data input
	.data (dataval_reg_reg),	// the data / length of the pulse
	.PLS_POL (pls_pol_reg_reg),					// the polarity of the pulse, either high or low
	
	// selector
	.mux_sel (mux_sel_reg_reg),					// mux selector
	.mux_in ({(MUX_WIDTH-1){1'b0}}),	// mux in
	
	// bitstream data output
	.OUT (OUT),
	
	// control signals
	.CLK (CLK),
	.RST (RST)
);



endmodule