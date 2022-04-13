// author: David Ariando
// date: 17th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bstrm_simp_cnt_tb ();

	localparam CMD_WIDTH = 8;		// the command counter width
	localparam LOOP_WIDTH = 24;		// loop width for the looping parameter
	localparam SRAM_ADDR_WIDTH = 8; // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
	localparam SRAM_DAT_WIDTH = 32; // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
	localparam DATA_WIDTH = 24;
	localparam MUX_WIDTH = 16;
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 4.3; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;

	// bitstream signals
	reg START;
	wire DONE;
	wire OUT;
	
	// SRAM access
	wire [SRAM_ADDR_WIDTH-1:0] SRAM_ADDR;	// SRAM address
	wire SRAM_CS;							// SRAM chip select
	reg [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT;	// SRAM read data
	
	reg CLK;
	reg RST;
	

	NMR_bstrm_simp_cnt 
	#(
		.CMD_WIDTH (CMD_WIDTH),		// the command counter width
		.LOOP_WIDTH (LOOP_WIDTH),		// loop width for the looping parameter
		.SRAM_ADDR_WIDTH (SRAM_ADDR_WIDTH), // the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_DAT_WIDTH (SRAM_DAT_WIDTH), // the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
		.DATA_WIDTH (DATA_WIDTH),
		.MUX_WIDTH (MUX_WIDTH)
	)
	DUT
	(
		// bitstream signals
		.START (START),
		.DONE (DONE),
		.OUT (OUT),
		
		// SRAM access
		.SRAM_ADDR (SRAM_ADDR),	// SRAM address
		.SRAM_CS (SRAM_CS),							// SRAM chip select
		.SRAM_RD_DAT (SRAM_RD_DAT),	// SRAM read data
		
		// control signals
		.CLK (CLK),
		.RST (RST)
	);
	
	always begin
		#clockticks CLK = ~CLK;
	end
	
	initial begin
		START = 0;
		RST = 1;
		CLK = 1;
		SRAM_RD_DAT <= 0;
		
		#(clockticks*2) RST = 0;
		
		#(clockticks*10) START = 1;
		#(clockticks*2) START = 0;
		
		// pls_pol_reg 
		// seq_end_reg	
		// loop_sta_reg
		// loop_sto_reg
		// mux_sel
		// length of pulse
		
		// program the repetition number
		wait(SRAM_CS); // #0
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd15}}; //pls_pol_reg  //seq_end_reg	 //loop_sta_reg //loop_sto_reg //mux_sel // length of pulse
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #1
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b0},{4{1'b0}},{24'd8}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #2
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd16}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #3
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b0},{4{1'b0}},{24'd8}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #4
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b1,1'b0},{4{1'b0}},{24'd5}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!SRAM_CS);
		
		wait(SRAM_CS); // #7
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b1,1'b0,1'b0},{4{1'b0}},{24'h10}};
		wait(!SRAM_CS);
		
	end


endmodule