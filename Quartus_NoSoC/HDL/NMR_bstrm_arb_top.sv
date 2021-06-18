// author: David Ariando
// date: 16th June 2021
// operation details:
// this module combines the bitstream controller and bitstream FSM / datapath.

module NMR_bstrm_arb_top
#(
	
	parameter DATA_WIDTH = 120, // the pulse width
	parameter CNT_WIDTH = 32,	// the control signal width
	parameter CMD_WIDTH = 8,		// the command counter width
	parameter LOOP_WIDTH = 16,		// loop width for the looping parameter
	parameter SRAM_ADDR_WIDTH = 8, // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter SRAM_DAT_WIDTH = 128, // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter SRAM_BYTEEN_WIDTH = 16 // the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
	
)
(
	
	input START,
	output DONE,
	
	// SRAM access
	output [SRAM_ADDR_WIDTH-1:0] SRAM_ADDR,		// SRAM address
	output SRAM_CS,								// SRAM chip select
	output SRAM_CLKEN,							// SRAM clock enable
	output SRAM_WR,								// SRAM write
	input [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT,	// SRAM read data
	output [SRAM_DAT_WIDTH-1:0]	SRAM_WR_DAT,	// SRAM write data
	output [SRAM_BYTEEN_WIDTH-1:0] SRAM_BYTEEN,	// SRAM byte enable
	
	// bitstream data output
	output OUT,
	
	// control signals
	input CLK,
	input RST
	
);
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 4.3; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;
	
	
	// bitstream control data
	wire DPATH_START;
	wire DPATH_BUF_RDY;
	wire CNT_DONE, DPATH_DONE;
	wire [DATA_WIDTH-1:0] data;	// the data / length of the pulse
	wire pattern_mode;				// treat the data as patterns
	wire all_1_mode;				// generate all 1s at the output and treat the data as length of 1s
	wire all_0_mode;				// generate all 0s at the output and treat the data as length of 0s
	wire end_of_sequence;			// end of sequence flag
	
	NMR_bstrm_arb_cnt 
	#(
		.DATA_WIDTH 		(DATA_WIDTH), // the initial delay width
		.CNT_WIDTH			(CNT_WIDTH),	// the control signal width
		.CMD_WIDTH			(CMD_WIDTH),		// the command counter width
		.LOOP_WIDTH			(LOOP_WIDTH),		// loop width for the looping parameter
		.SRAM_ADDR_WIDTH	(SRAM_ADDR_WIDTH), // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_DAT_WIDTH		(SRAM_DAT_WIDTH), // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_BYTEEN_WIDTH	(SRAM_BYTEEN_WIDTH) // the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
	) NMR_bstrm_arb_cnt1
	(
		// bitstream signals
		.START	(START),
		.DONE	(CNT_DONE),
		
		// SRAM access
		.SRAM_ADDR		(SRAM_ADDR),	// SRAM address
		.SRAM_CS		(SRAM_CS),		// SRAM chip select
		.SRAM_CLKEN		(SRAM_CLKEN),		// SRAM clock enable
		.SRAM_WR		(SRAM_WR),			// SRAM write
		.SRAM_RD_DAT	(SRAM_RD_DAT),		// SRAM read data
		.SRAM_WR_DAT	(SRAM_WR_DAT),		// SRAM write data
		.SRAM_BYTEEN	(SRAM_BYTEEN),		// SRAM byte enable
		
		// bitstream control data
		.DPATH_START				(DPATH_START),
		.DPATH_BUF_RDY				(DPATH_BUF_RDY),
		.data_reg			(data),
		.seq_end_reg		(end_of_sequence), // the end of sequence signal
		.pattern_mode_reg	(pattern_mode),	// pattern mode signal
		.all_1s_mode_reg	(all_1_mode),	// all 1s mode signal
		.all_0s_mode_reg	(all_0_mode),	// all 0s mode signal
		
		// control signals
		.CLK	(CLK),
		.RST	(RST)
	);
	
	NMR_bstrm_arb_dpath
	# (

		.DATA_WIDTH (DATA_WIDTH) // the data width

	) NMR_bstrm_arb_dpath1
	(

		// bitstream signals
		.START (DPATH_START),
		.DPATH_BUF_RDY (DPATH_BUF_RDY),
		.DONE (DPATH_DONE),
		
		// bitstream data input
		.data (data),	// the data / length of the pulse
		.pattern_mode (pattern_mode),				// treat the data as patterns
		.all_1_mode (all_1_mode),				// generate all 1s at the output and treat the data as length of 1s
		.all_0_mode (all_0_mode),				// generate all 0s at the output and treat the data as length of 0s
		.end_of_sequence (end_of_sequence),			// end of sequence flag
		
		// bitstream data output
		.OUT (OUT),
		
		// control signals
		.CLK (CLK),
		.RST (RST)
	);
	
	assign DONE = DPATH_DONE && CNT_DONE;

endmodule