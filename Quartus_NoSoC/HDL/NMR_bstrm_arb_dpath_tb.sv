// author: David Ariando
// date: 15th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bstrm_arb_dpath_tb ();
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 4.3; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;
	
	localparam DATA_WIDTH = 20; // the data width
	
	// bitstream signals
	reg START;
	wire DONE;
	
	// bitstream data reg
	reg [DATA_WIDTH-1:0] data;	// the data / length of the pulse
	reg pattern_mode;				// treat the data as patterns
	reg all_1_mode;				// generate all 1s at the output and treat the data as length of 1s
	reg all_0_mode;				// generate all 0s at the output and treat the data as length of 0s
	reg end_of_sequence;			// end of sequence flag
	
	// bitstream data output
	wire OUT;
	
	// control signals
	reg CLK;
	reg RST;
	
	
	NMR_bstrm_arb_dpath
	# (

		.DATA_WIDTH (DATA_WIDTH) // the data width

	) DUT
	(

		// bitstream signals
		.START (START),
		.DONE (DONE),
		
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
		
	always begin
		#clockticks CLK = ~CLK;
	end
	
	initial begin
		START = 0;
		RST = 1;
		CLK = 1;
		
		#(clockticks*2)
			RST = 0;
			data = 10;
			pattern_mode = 0;
			all_1_mode = 1;
			all_0_mode = 0;
			end_of_sequence = 0;
		
		#(clockticks*10) START = 1;
		#(clockticks*2) START = 0;
		
		@(posedge DONE);
		#(clockticks*2)
			data = 20'b10100011100011101110;
			pattern_mode = 1;
			all_1_mode = 0;
			all_0_mode = 0;
			end_of_sequence = 0;
			
		@(posedge DONE);
		#(clockticks*2)
			data = 10;
			pattern_mode = 0;
			all_1_mode = 0;
			all_0_mode = 1;
			end_of_sequence = 0;
			
		@(posedge DONE);
		#(clockticks*2)
			data = 10;
			pattern_mode = 0;
			all_1_mode = 1;
			all_0_mode = 0;
			end_of_sequence = 0;
		
		@(posedge DONE);
		#(clockticks*2)
			data = 10;
			pattern_mode = 0;
			all_1_mode = 0;
			all_0_mode = 1;
			end_of_sequence = 0;
			
		@(posedge DONE);
		#(clockticks*2)
			data = 10;
			pattern_mode = 0;
			all_1_mode = 1;
			all_0_mode = 0;
			end_of_sequence = 0;
			
		@(posedge DONE);
		#(clockticks*2)
			data = 20'b11100011100011101110;
			pattern_mode = 1;
			all_1_mode = 0;
			all_0_mode = 0;
			end_of_sequence = 0;
			
		@(posedge DONE);
		#(clockticks*2)
			data = 7;
			pattern_mode = 0;
			all_1_mode = 0;
			all_0_mode = 1;
			end_of_sequence = 0;
			
		@(posedge DONE);
		#(clockticks*2)
			data = 0;
			pattern_mode = 0;
			all_1_mode = 0;
			all_0_mode = 0;
			end_of_sequence = 1;
		
	end


endmodule