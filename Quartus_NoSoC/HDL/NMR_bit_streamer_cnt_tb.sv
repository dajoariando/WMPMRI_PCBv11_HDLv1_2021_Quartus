// author: David Ariando
// date: 15th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bit_streamer_cnt_tb ();

	localparam IDLY_WIDTH = 32; // the initial delay width
	localparam PLS_WIDTH = 32; // the pulse width
	localparam EDLY_WIDTH = 32; // post-pulse delay width
	localparam CNT_WIDTH = 32;	// the control signal width
	localparam CMD_WIDTH = 8;		// the command counter width
	localparam LOOP_WIDTH = 16;		// loop width for the looping localparam
	localparam SRAM_ADDR_WIDTH = 8; // the SRAM address width; find it in Platform Designer of the On-Chip Memory (RAM)
	localparam SRAM_DAT_WIDTH = 128; // the SRAM data width; find it in Platform Designer of the On-Chip Memory (RAM)
	localparam SRAM_BYTEEN_WIDTH = 16;
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 4.3; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;

	// bitstream signals
	reg START;
	wire DONE;
	
	// SRAM access
	wire[SRAM_ADDR_WIDTH-1:0] SRAM_ADDR;	// SRAM address
	wire SRAM_CS;		// SRAM chip select
	wire SRAM_CLKEN;		// SRAM clock enable
	wire SRAM_WR;			// SRAM write
	reg [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT;		// SRAM read data
	wire [SRAM_DAT_WIDTH-1:0]	SRAM_WR_DAT;		// SRAM write data
	wire [SRAM_BYTEEN_WIDTH-1:0] SRAM_BYTEEN;	
	
	// bitstream control data
	wire BT_START;
	reg BT_DONE;
	wire [IDLY_WIDTH-1:0] idly_reg;
	wire [PLS_WIDTH-1:0] pls_reg;
	wire [EDLY_WIDTH-1:0] edly_reg; 
	
	// control signals
	reg CLK;
	reg RST;
	
	NMR_bit_streamer_cnt 
	#(
		.IDLY_WIDTH (IDLY_WIDTH), // the initial delay width
		.PLS_WIDTH (PLS_WIDTH), // the pulse width
		.EDLY_WIDTH (EDLY_WIDTH), // post-pulse delay width
		.CNT_WIDTH (CNT_WIDTH),	// the control signal width
		.CMD_WIDTH (CMD_WIDTH),		// the command counter width
		.LOOP_WIDTH (LOOP_WIDTH),		// loop width for the looping parameter
		.SRAM_ADDR_WIDTH (SRAM_ADDR_WIDTH), // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_DAT_WIDTH (SRAM_DAT_WIDTH), // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_BYTEEN_WIDTH (SRAM_BYTEEN_WIDTH)  // the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
	)
	DUT (
		// bitstream signals
		.START (START),
		.DONE (DONE),
		
		// SRAM access
		.SRAM_ADDR (SRAM_ADDR),	// SRAM address
		.SRAM_CS(SRAM_CS),		// SRAM chip select
		.SRAM_CLKEN(SRAM_CLKEN),		// SRAM clock enable
		.SRAM_WR(SRAM_WR),			// SRAM write
		.SRAM_RD_DAT(SRAM_RD_DAT),		// SRAM read data
		.SRAM_WR_DAT(SRAM_WR_DAT),		// SRAM write data
		.SRAM_BYTEEN(SRAM_BYTEEN),		// SRAM byte enable
		
		// bitstream control data
		.BT_START(BT_START),
		.BT_DONE(BT_DONE),
		.idly_reg(idly_reg),
		.pls_reg(pls_reg),
		.edly_reg(edly_reg), 
		
		// control signals
		.CLK(CLK),
		.RST(RST)
	);
	
	always begin
		#clockticks CLK = ~CLK;
	end
	
	initial begin
		START = 0;
		RST = 1;
		CLK = 1;
		BT_DONE = 1'b0;
		SRAM_RD_DAT = 0;
		
		#(clockticks*2) RST = 0;
		
		#(clockticks*10) START = 1;
		#(clockticks*2) START = 0;
		
		#(clockticks*2) SRAM_RD_DAT = (20<<96) | (10<<64) | (15<<32) | (3<<16) | (0<<0);
		#(clockticks*20) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (10<<96) | (5<<64) | (23<<32) | (3<<16) | (1<<1);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (15<<96) | (21<<64) | (7<<32) | (3<<16) | (1<<0);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (10<<96) | (5<<64) | (23<<32) | (3<<16) | (1<<1);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (15<<96) | (21<<64) | (7<<32) | (3<<16) | (1<<0);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (10<<96) | (5<<64) | (23<<32) | (3<<16) | (1<<1);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (15<<96) | (21<<64) | (7<<32) | (3<<16) | (1<<0);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (10<<96) | (5<<64) | (23<<32) | (3<<16) | (1<<2);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (15<<96) | (21<<64) | (7<<32) | (3<<16) | (0<<0);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (10<<96) | (5<<64) | (23<<32) | (3<<16) | (0<<0);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
		#(clockticks*4) SRAM_RD_DAT = (15<<96) | (21<<64) | (7<<32) | (3<<16) | (0<<0);
		#(clockticks*8) BT_DONE = 1'b1;
		#(clockticks*2) BT_DONE = 1'b0;
		
	end
	
	


endmodule