// author: David Ariando
// date: 17th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bstrm_arb_top_tb ();

	localparam DATA_WIDTH = 120; // the pulse width
	localparam CNT_WIDTH = 32;	// the control signal width
	localparam CMD_WIDTH = 8;		// the command counter width
	localparam LOOP_WIDTH = 16;		// loop width for the looping parameter
	localparam SRAM_ADDR_WIDTH = 8; // the SRAM address width; find it in Platform Designer of the On-Chip Memory (RAM)
	localparam SRAM_DAT_WIDTH = 128; // the SRAM data width; find it in Platform Designer of the On-Chip Memory (RAM)
	localparam SRAM_BYTEEN_WIDTH = 16; // the byte enable width; find it in Platform Designer of the On-Chip Memory (RAM)
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 4.3; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;

	// bitstream signals
	reg START;
	wire DONE;
	
	// SRAM access
	wire[SRAM_ADDR_WIDTH-1:0] SRAM_ADDR;		// SRAM address
	wire SRAM_CS;								// SRAM chip select
	wire SRAM_CLKEN;							// SRAM clock enable
	wire SRAM_WR;								// SRAM write
	wire [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT;	// SRAM read data
	wire [SRAM_DAT_WIDTH-1:0]	SRAM_WR_DAT;	// SRAM write data
	wire [SRAM_BYTEEN_WIDTH-1:0] SRAM_BYTEEN;	// SRAM byte enable
	
	// bitstream data output
	wire OUT;
	
	// control signals
	reg CLK;
	reg RST;

	NMR_bstrm_arb_top
	#(
		
		.DATA_WIDTH (DATA_WIDTH), // the pulse width
		.CNT_WIDTH (CNT_WIDTH),	// the control signal width
		.CMD_WIDTH (CMD_WIDTH),		// the command counter width
		.LOOP_WIDTH (LOOP_WIDTH),		// loop width for the looping parameter
		.SRAM_ADDR_WIDTH (SRAM_ADDR_WIDTH), // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_DAT_WIDTH (SRAM_DAT_WIDTH), // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_BYTEEN_WIDTH (SRAM_BYTEEN_WIDTH) // the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
		
	) DUT
	(
		
		.START(START),
		.DONE(DONE),
		
		// SRAM access
		.SRAM_ADDR(SRAM_ADDR),		// SRAM address
		.SRAM_CS(SRAM_CS),								// SRAM chip select
		.SRAM_CLKEN(SRAM_CLKEN),							// SRAM clock enable
		.SRAM_WR(SRAM_WR),								// SRAM write
		.SRAM_RD_DAT(SRAM_RD_DAT),	// SRAM read data
		.SRAM_WR_DAT(SRAM_WR_DAT),	// SRAM write data
		.SRAM_BYTEEN(SRAM_BYTEEN),	// SRAM byte enable
		
		// bitstream data .
		.OUT(OUT),
		
		// control signals
		.CLK(CLK),
		.RST(RST)
		
	);
	
	reg end_of_seq, loop_sta, loop_sto, pattern_mode, all_1s, all_0s;
	reg [DATA_WIDTH-1:0] data_reg;
	
	always begin
		#clockticks CLK = ~CLK;
	end
	
	initial begin
		START = 0;
		RST = 1;
		CLK = 1;
		
		#(clockticks*2) RST = 0;
		
		#(clockticks*10) START = 1;
		#(clockticks*2) START = 0;
		
		// program the repetition number
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 3;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b1;
			all_0s        <= 1'b0;
			data_reg      <= 10;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b1;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b1;
			data_reg      <= 10;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b1;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b1;
			all_0s        <= 1'b0;
			data_reg      <= 10;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b1;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b1;
			data_reg      <= 10;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b1;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b1;
			all_0s        <= 1'b0;
			data_reg      <= 10;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b1;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b1;
			data_reg      <= 10;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b1;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b1;
			all_0s        <= 1'b0;
			data_reg      <= 10;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b1;
			data_reg      <= 10;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b1;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 120'hFF00_FF00_FFFF_0000_FFFF_0000_FF00_FF;
		wait(!SRAM_CS);
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b1;
			data_reg      <= 10;
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b1;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 20;
		wait(!SRAM_CS);
		
		
	end
	
	assign SRAM_RD_DAT = {end_of_seq, loop_sta, loop_sto, pattern_mode, all_1s, all_0s, 2'b0, data_reg};


endmodule