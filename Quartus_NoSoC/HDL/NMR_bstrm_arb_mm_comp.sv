// author: David Ariando
// date: 22nd June 2021
// operation details:
// this component interfaces Altera SRAM and bitstream module and makes it a Platform Designer component.

// Caution:
// Make sure that the SRAM address width here match the one generated by the IP generator.
// Make sure that the SRAM IP is generated with 128-bit input and byteenable. The byteenable opens access to program 128-bit SRAM with 32-bit memory-map addressing.

module NMR_bstrm_arb_mm_comp
#(
	
	parameter DATA_WIDTH 		= 120,	// the pulse width
	parameter CNT_WIDTH 		= 32,	// the control signal width
	parameter CMD_WIDTH 		= 8,	// the command counter width
	parameter LOOP_WIDTH 		= 16,	// loop width for the looping parameter
	parameter SRAM_ADDR_WIDTH 	= 8,	// the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter SRAM_DAT_WIDTH 	= 128,	// the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter MM_WIDTH			= 32,	// the memory map data width
	parameter SRAM_BYTEEN_WIDTH = 16	// the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
	
)
(
	
	input	coe_START,
	output	coe_DONE,
	
	// SRAM access
	input [SRAM_BYTEEN_WIDTH-1:0]	avs_s0_byteena_a,
	input [SRAM_ADDR_WIDTH-1:0] 	avs_s0_address,		// SRAM address
	input 							avs_s0_write,		// SRAM write
	input [SRAM_DAT_WIDTH-1:0]		avs_s0_writedata,	// SRAM write data
	
	// bitstream data output
	output coe_OUT,
	
	// control signals
	input csi_WR_CLK,
	input rsi_RST,
	input csi_RD_CLK
	
);

	// SRAM access
	wire [SRAM_ADDR_WIDTH-1:0] SRAM_RD_ADDR		/* synthesis keep */;	// SRAM address
	wire [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT		/* synthesis keep */;	// SRAM read data	
	
	
	
	bstream_ram_256	bstream_ram_256_inst (
		.byteena_a 	( avs_s0_byteena_a ),
		.data		( avs_s0_writedata ),
		.wraddress	( avs_s0_address ),
		.wrclock	( csi_WR_CLK ),
		.wren		( avs_s0_write ),
		
		.rdaddress	( SRAM_RD_ADDR ),
		.rdclock	( csi_RD_CLK ),
		.q			( SRAM_RD_DAT )
	);
	
	
	
	NMR_bstrm_arb_top
	#(
		
		.DATA_WIDTH 		(DATA_WIDTH), 		// the pulse width
		.CNT_WIDTH 			(CNT_WIDTH),		// the control signal width
		.CMD_WIDTH 			(CMD_WIDTH),		// the command counter width
		.LOOP_WIDTH 		(LOOP_WIDTH),		// loop width for the looping parameter
		.SRAM_ADDR_WIDTH 	(SRAM_ADDR_WIDTH), 	// the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_DAT_WIDTH 	(SRAM_DAT_WIDTH), 	// the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_BYTEEN_WIDTH	(SRAM_BYTEEN_WIDTH)	// the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
		
	) NMR_bstrm_arb_top1
	(
		
		.START	(coe_START),
		.DONE	(coe_DONE),
		
		// SRAM access
		.SRAM_ADDR		(SRAM_RD_ADDR),	// SRAM address
		.SRAM_CS		(),				// SRAM chip select
		.SRAM_RD_DAT	(SRAM_RD_DAT),	// SRAM read data
		
		// bitstream data output
		.OUT	(coe_OUT),
		
		// control signals
		.CLK	(csi_RD_CLK),
		.RST	(rsi_RST)
		
	);
	
	

endmodule