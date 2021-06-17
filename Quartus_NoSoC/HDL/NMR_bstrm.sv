// author: David Ariando
// date: 16th June 2021
// operation details:
// this module combines the bitstream controller and bitstream FSM / datapath.

module NMR_bstrm
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
	
	input START,
	output reg DONE,
	
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

	wire BT_START;
	wire BT_DONE;
	wire [IDLY_WIDTH-1:0] idly;
	wire [PLS_WIDTH-1:0] pls;
	wire [EDLY_WIDTH-1:0] edly;
	wire BT_CNT_DONE;


	NMR_bit_streamer_cnt 
	#(

		.IDLY_WIDTH			(IDLY_WIDTH), // the initial delay width
		.PLS_WIDTH			(PLS_WIDTH), // the pulse width
		.EDLY_WIDTH			(EDLY_WIDTH), // post-pulse delay width
		.CNT_WIDTH			(CNT_WIDTH),	// the control signal width
		.CMD_WIDTH			(CMD_WIDTH),		// the command counter width
		.LOOP_WIDTH			(LOOP_WIDTH),		// loop width for the looping parameter
		.SRAM_ADDR_WIDTH 	(SRAM_ADDR_WIDTH), // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_DAT_WIDTH		(SRAM_DAT_WIDTH), // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_BYTEEN_WIDTH	(SRAM_BYTEEN_WIDTH) // the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)

	) cnt_str1
	(

		// bitstream signals
		.START 	(START),
		.DONE	(BT_CNT_DONE),
		
		// SRAM access
		.SRAM_ADDR		(SRAM_ADDR),	// SRAM address
		.SRAM_CS		(SRAM_CS),		// SRAM chip select
		.SRAM_CLKEN		(SRAM_CLKEN),		// SRAM clock enable
		.SRAM_WR		(SRAM_WR),			// SRAM write
		.SRAM_RD_DAT	(SRAM_RD_DAT),		// SRAM read data
		.SRAM_WR_DAT	(SRAM_WR_DAT),		// SRAM write data
		.SRAM_BYTEEN	(SRAM_BYTEEN),		// SRAM byte enable
		
		// bitstream control data
		.BT_START		(BT_START),
		.BT_DONE		(BT_DONE),
		.idly_reg		(idly),
		.pls_reg		(pls),
		.edly_reg		(edly), 
		
		// control signals
		.CLK			(CLK),
		.RST			(RST)
		
	);



	NMR_bit_streamer
	# (
		.IDLY_WIDTH	(IDLY_WIDTH), // the initial delay width
		.PLS_WIDTH	(PLS_WIDTH), // the pulse width
		.EDLY_WIDTH	(EDLY_WIDTH) // post-pulse delay width
	) dpath_str1
	(

		// bitstream signals
		.START	(BT_START),
		.DONE	(BT_DONE),
		
		// bitstream data input
		.idly	(idly), // should be already synchronized with CLK
		.pls	(pls),
		.edly	(edly - {{(EDLY_WIDTH-4){1'b0}},{4'd4}}),
		
		// bitstream data output
		.OUT	(OUT),
		
		// control signals
		.CLK	(CLK),
		.RST	(RST)
	);
	
	// generate the bitstream done signal
	always @(posedge CLK)
	begin
		DONE <= BT_CNT_DONE && BT_DONE;
	end	

endmodule