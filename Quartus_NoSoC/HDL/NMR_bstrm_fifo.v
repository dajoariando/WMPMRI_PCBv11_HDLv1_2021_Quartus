// author: David Ariando
// date: 28th May 2021
// operation details:
// this module takes a START signal from the SoC to start sending bitstream out from the bitstr_in FIFO to the bitstr_out (GPIO)
// the end of the sequence is marked by D_END signal that's stored inside the bitstream data itself
// the D_END signal is taken by the SoC and the SoC will issue a STOP signal in order to stop the sequence
// as there is a delay between D_END signal and issuing a STOP signal, it is very important to set the bitstream value to an idle value at the end of the sequence, as this idle value will be repeated so many times in between the delay of D_END and STOP.
// Also, as D_END signal is combinational, if the SoC is fast enough, after issuing START signal, the SoC might find D_END to be 1 before the sequence even started. This is D_END from the previous sequence. So after issuing a START signal, it's a must for the SoC to put 5-10 clock cycles of delay after START, in order to make sure the sequence is in operation before reading D_END.

module NMR_bstrm_fifo
# (
	parameter BUS_WIDTH = 32 
)
(
	// bitstream signals
	input START,		// start taking ada from the FIFO
	input STOP,			// stop signal from the SoC
	output reg READY,	// ready to take data (required by the FIFO)
	
	// bitstream data input
	input	[BUS_WIDTH-1:0] bitstr_in,
	
	// bitstream outputs
	output [BUS_WIDTH-1:0]	bitstr_out,	
	output D_END,							// the signal that marks the end of the sequence, issued to the SoC

	// control signals
	input CLK,
	input RST
);

	reg LOAD; // set load signal to be the MSB of bitstream bus
	
	reg [4:0] State;
	localparam [4:0]
		S0 = 5'b00001,
		S1 = 5'b00010,
		S2 = 5'b00100,
		S3 = 5'b01000,
		S4 = 5'b10000;
	
	initial
	begin
		LOAD <= 1'b0;
		READY <= 1'b0;
		State <= S0;
	end
			
	always @(posedge CLK, posedge RST)
	begin
		if (RST)
		begin
			LOAD <= 1'b0;
			READY <= 1'b0;
			State <= S0;
		end
		
		else
		begin
			case (State)
			
				S0:
				begin
					
					LOAD <= 1'b0;
					
					if (START == 1'b1)
						State <= S1;
						
				end
				
				S1:
				begin
					
					READY	<= 1'b1; // set ready
					LOAD	<= 1'b1; // load the first data before getting data from the FIFO
					State	<= S2;
					
				end
				
				S2:
				begin
					
					if (STOP == 1'b1)
						State <= S3;
				
				end
				
				S3:
				begin
					
					LOAD <= 1'b0;
					READY <= 1'b0;
					
					if (START == 1'b0)
						State <= S0;
					
				end
			
			endcase
				
		end
	end
	
	assign D_END = bitstr_in[BUS_WIDTH-1];
	assign bitstr_out = LOAD ? bitstr_in : {BUS_WIDTH{1'b0}};

endmodule