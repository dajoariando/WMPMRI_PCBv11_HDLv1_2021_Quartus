`timescale 1ps / 1ps

module NMR_bstrm_fifo_tb ();
	
	localparam BUS_WIDTH = 32;
	
	// parameters are referenced in MHz for calculation
	parameter timescale_ref = 1000000; // reference scale based on timescale => 1ps => 1THz => 1000000 MHz
	parameter CLK_RATE_HZ = 4.3; // in MHz
	localparam integer clockticks = (timescale_ref / CLK_RATE_HZ) / 2.0;

	// bitstream signals
	reg START;	// start taking ada from the FIFO
	reg STOP;			// stop signal from the SoC
	wire READY;	// ready to take data (required by the FIFO)

	// bitstream data input
	reg [BUS_WIDTH-1:0] bitstr_in;

	// bitstream outputs
	wire [BUS_WIDTH-1:0]	bitstr_out;
	wire D_END;	// the signal that marks the end of the pulse to the SoC


	// control signals
	reg CLK;
	reg RST;

	NMR_bstrm_fifo
	# (
		.BUS_WIDTH (32) 
	)
	DUT
	(
		// bitstream signals
		.START (START),	// start taking ada from the FIFO
		.STOP (STOP), // stop signal from the SoC
		.READY (READY),	// ready to take data (required by the FIFO)
		
		// bitstream data input
		.bitstr_in (bitstr_in),
		
		// bitstream outputs
		.bitstr_out (bitstr_out),
		.D_END (D_END),

		// control signals
		.CLK (CLK),
		.RST (RST)
	);

	initial begin
		CLK = 1'b0;
		RST = 1'b0;
		START = 1'b0;
		STOP = 1'b0;
		
		#(clockticks*1);

		#(clockticks*2) RST = 1'b1;
		#(clockticks*2) RST = 1'b0;
		
		#(clockticks*2) START = 1'b1;
		#(clockticks*2) START = 1'b0;
		
		#(clockticks*100) STOP = 1'b1;
		
	end
	
	
	initial begin
		#(clockticks*5) bitstr_in <= 1'b0;
		forever #(clockticks*2) bitstr_in <= $urandom%10 + (1<<31);
	end

	always begin
		#clockticks CLK = ~CLK;
	end

endmodule