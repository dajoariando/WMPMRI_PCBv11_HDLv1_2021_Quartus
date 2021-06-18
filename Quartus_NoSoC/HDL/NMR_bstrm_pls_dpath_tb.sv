// author: David Ariando
// date: 15th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bstrm_pls_dpath_tb ();

	localparam IDLY_WIDTH = 32; // the initial delay width
	localparam PLS_WIDTH = 32; // the pulse width
	localparam EDLY_WIDTH = 32; // post-pulse delay width
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 4.3; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;

	// bitstream signals
	reg START;
	wire DONE;
	
	// bitstream data input
	reg [IDLY_WIDTH-1:0] idly; // should be already synchronized with CLK
	reg [IDLY_WIDTH-1:0] pls;
	reg [IDLY_WIDTH-1:0] edly;
	
	// bitstream data output
	wire OUT;
	
	// control signals
	reg CLK;
	reg RST;

	NMR_bstrm_pls_dpath
	# (
		.IDLY_WIDTH (32), // the initial delay width
		.PLS_WIDTH (32), // the pulse width
		.EDLY_WIDTH (32) // post-pulse delay width
	) DUT
	(
		
		// bitstream signals
		.START(START),
		.DONE(DONE),
		
		// bitstream data input
		.idly (idly), // should be already synchronized with CLK
		.pls (pls),
		.edly (edly),
		
		// bitstream data output
		.OUT(OUT),
		
		// control signals
		.CLK(CLK),
		.RST(RST)
	);

	always begin
		#clockticks CLK = ~CLK;
	end
	
	initial begin
		START = 0;
		idly = 5;
		pls = 7;
		edly = 5;
		RST = 1;
		CLK = 1;
		
		#(clockticks*2) RST = 0;
		
		#(clockticks*10) START = 1;
		#(clockticks*2) START = 0;
		
	end


endmodule