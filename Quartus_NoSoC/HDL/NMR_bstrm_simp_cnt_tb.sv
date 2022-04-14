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
	reg [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT;	// SRAM read data
	
	// simulation aid
	wire sim_changed_sram_addr; // a register to mark changes in SRAM_ADDR to aid simulation
	
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
		.SRAM_RD_DAT (SRAM_RD_DAT),	// SRAM read data
		
		// simulation aid
		.sim_changed_sram_addr (sim_changed_sram_addr), // a register to mark changes in SRAM_ADDR to aid simulation
		
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
		
		SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd4}}; //pls_pol_reg  //seq_end_reg	 //loop_sta_reg //loop_sto_reg //mux_sel // length of pulse
		
		#(clockticks*2) RST = 0;
		
		#(clockticks*10) START = 1;
		#(clockticks*2) START = 0;
		
		// pls_pol_reg 
		// seq_end_reg	
		// loop_sta_reg
		// loop_sto_reg
		// mux_sel
		// length of pulse
		
		
		
		wait(sim_changed_sram_addr); // #1 , remember that address #0 is the one set at the beginning and is always at address #0 after RESET or INITIAL
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b0},{4{1'b0}},{24'd4}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #2
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd7}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #3
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b0},{4{1'b0}},{24'd8}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #4
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b1,1'b0},{4{1'b0}},{24'd5}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #5
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b1,1'b0,1'b0,1'b0},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #6
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b0,1'b0,1'b1},{4{1'b0}},{24'd9}};
		wait(!sim_changed_sram_addr);
		
		wait(sim_changed_sram_addr); // #7
		#(clockticks*2)
			SRAM_RD_DAT <= {{1'b0,1'b1,1'b0,1'b0},{4{1'b0}},{24'h10}};
		wait(!sim_changed_sram_addr);
		
	end


endmodule