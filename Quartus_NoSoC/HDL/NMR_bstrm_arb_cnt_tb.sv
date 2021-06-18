// author: David Ariando
// date: 17th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bstrm_arb_cnt_tb ();

	localparam DATA_WIDTH = 120;
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
	wire [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT;		// SRAM read data
	wire [SRAM_DAT_WIDTH-1:0]	SRAM_WR_DAT;		// SRAM write data
	wire [SRAM_BYTEEN_WIDTH-1:0] SRAM_BYTEEN;
	
	reg end_of_seq, loop_sta, loop_sto, pattern_mode, all_1s, all_0s;
	reg [DATA_WIDTH-1:0] data_reg;
	
	// bitstream control data
	wire BST_START;
	reg BST_DONE;
	wire [DATA_WIDTH-1:0] out_data_reg;
	wire out_seq_end_reg; // the end of sequence signal
	wire out_pattern_mode_reg;	// pattern mode signal
	wire out_all_1s_mode_reg;	// all 1s mode signal
	wire out_all_0s_mode_reg;	// all 0s mode signal 
	
	// control signals
	reg CLK;
	reg RST;
	
	NMR_bstrm_arb_cnt 
	#(
		.DATA_WIDTH (DATA_WIDTH), // the initial delay width
		.CNT_WIDTH (CNT_WIDTH),	// the control signal width
		.CMD_WIDTH (CMD_WIDTH),		// the command counter width
		.LOOP_WIDTH (LOOP_WIDTH),		// loop width for the looping parameter
		.SRAM_ADDR_WIDTH (SRAM_ADDR_WIDTH), // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_DAT_WIDTH (SRAM_DAT_WIDTH), // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_BYTEEN_WIDTH (SRAM_BYTEEN_WIDTH) // the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
	) DUT
	(
		// bitstream signals
		.START	(START),
		.DONE	(DONE),
		
		// SRAM access
		.SRAM_ADDR		(SRAM_ADDR),	// SRAM address
		.SRAM_CS		(SRAM_CS),		// SRAM chip select
		.SRAM_CLKEN		(SRAM_CLKEN),		// SRAM clock enable
		.SRAM_WR		(SRAM_WR),			// SRAM write
		.SRAM_RD_DAT	(SRAM_RD_DAT),		// SRAM read data
		.SRAM_WR_DAT	(SRAM_WR_DAT),		// SRAM write data
		.SRAM_BYTEEN	(SRAM_BYTEEN),		// SRAM byte enable
		
		// bitstream control data
		.BST_START				(BST_START),
		.BST_DONE				(BST_DONE),
		.out_data_reg			(out_data_reg),
		.out_seq_end_reg		(out_seq_end_reg), // the end of sequence signal
		.out_pattern_mode_reg	(out_pattern_mode_reg),	// pattern mode signal
		.out_all_1s_mode_reg	(out_all_1s_mode_reg),	// all 1s mode signal
		.out_all_0s_mode_reg	(out_all_0s_mode_reg),	// all 0s mode signal
		
		// control signals
		.CLK	(CLK),
		.RST	(RST)
	);
	
	always begin
		#clockticks CLK = ~CLK;
	end
	
	initial begin
		START = 0;
		RST = 1;
		CLK = 1;
		BST_DONE = 1'b0;
		end_of_seq    <= 1'b0;
		loop_sta      <= 1'b0;
		loop_sto      <= 1'b0;
		pattern_mode  <= 1'b0;
		all_1s        <= 1'b0;
		all_0s        <= 1'b0;
		data_reg      <= 0;
		
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
		
		#(clockticks*4)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b1;
			all_0s        <= 1'b0;
			data_reg      <= 10;
		
		#(clockticks*20); BST_DONE = 1'b1;
		#(clockticks*2); BST_DONE = 1'b0;
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b1;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 10;
			
		#(clockticks*20); BST_DONE = 1'b1;
		#(clockticks*2); BST_DONE = 1'b0;
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b1;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 10;
			
		#(clockticks*20); BST_DONE = 1'b1;
		#(clockticks*2); BST_DONE = 1'b0;
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b1;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 10;
			
		#(clockticks*20); BST_DONE = 1'b1;
		#(clockticks*2); BST_DONE = 1'b0;
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b1;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 10;
			
		#(clockticks*20); BST_DONE = 1'b1;
		#(clockticks*2); BST_DONE = 1'b0;
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b1;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 10;
			
		#(clockticks*20); BST_DONE = 1'b1;
		#(clockticks*2); BST_DONE = 1'b0;
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b0;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b1;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 10;
			
		#(clockticks*20); BST_DONE = 1'b1;
		#(clockticks*2); BST_DONE = 1'b0;
		
		wait(SRAM_CS);
		#(clockticks*2)
			end_of_seq    <= 1'b1;
			loop_sta      <= 1'b0;
			loop_sto      <= 1'b0;
			pattern_mode  <= 1'b0;
			all_1s        <= 1'b0;
			all_0s        <= 1'b0;
			data_reg      <= 10;
			
		#(clockticks*20); BST_DONE = 1'b1;
		#(clockticks*2); BST_DONE = 1'b0;
		
	end
	
	assign SRAM_RD_DAT = {end_of_seq, loop_sta, loop_sto, pattern_mode, all_1s, all_0s, 2'b0, data_reg};
	

endmodule