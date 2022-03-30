// author: David Ariando
// date: 15th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bstrm_simp_dpath_tb ();
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 4.3; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;
		
	localparam DATA_WIDTH = 32;
	localparam MUX_WIDTH = 16;
	
	// bitstream signals
	reg START;
	wire DPATH_RDY;
	wire DONE;
	
	// bitstream data input
	reg [DATA_WIDTH-1:0] data;	// the data / length of the pulse
	reg PLS_POL;					// the polarity of the pulse, either high or low
	
	// selector
	reg [3:0] mux_sel;			// mux selector
	reg [MUX_WIDTH-2:0] mux_in;	// mux in.
	
	// bitstream data output
	wire OUT;
	
	// control signals
	reg CLK;
	reg RST;
	
	
	NMR_bstrm_simp_dpath
	# (

		.DATA_WIDTH (DATA_WIDTH),		// the data width
		.MUX_WIDTH 	(MUX_WIDTH)		// the mux width

	) DUT
	(

		// bitstream signals
		.START (START),
		.DPATH_RDY (DPATH_RDY),
		.DONE (DONE),
		
		// bitstream data input
		.data (data),	// the data / length of the pulse
		.PLS_POL (PLS_POL),					// the polarity of the pulse, either high or low
		
		// selector
		.mux_sel (mux_sel),			// mux selector
		.mux_in (mux_in),	// mux in.
		
		// bitstream data output
		.OUT (OUT),
		
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
		
		#(clockticks*2)
			RST = 0;
			data = 5;
			mux_sel = 0;
			mux_in = 0;
			PLS_POL = 1;
		
		#(clockticks*2)
			START = 1;
		
		@(posedge DONE);
			START = 0;

		
	end


endmodule