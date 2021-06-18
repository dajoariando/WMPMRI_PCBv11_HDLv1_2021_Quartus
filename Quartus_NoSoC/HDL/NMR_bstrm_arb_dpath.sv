// author: David Ariando
// date: 15th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bstrm_arb_dpath
# (

	parameter DATA_WIDTH = 120 // the data width

)
(

	// bitstream signals
	input START,
	output reg DPATH_BUF_RDY,
	output reg DONE,
	
	// bitstream data input
	input [DATA_WIDTH-1:0] data,	// the data / length of the pulse
	input pattern_mode,				// treat the data as patterns
	input all_1_mode,				// generate all 1s at the output and treat the data as length of 1s
	input all_0_mode,				// generate all 0s at the output and treat the data as length of 0s
	input end_of_sequence,			// end of sequence flag
	
	// bitstream data output
	output reg OUT,
	
	// control signals
	input CLK,
	input RST
);

	reg [DATA_WIDTH-1:0] stream_reg;	// the register for streaming data
	reg [7:0] str_counter_reg;			// the stream counter for shifting out pattern data (where it's maximum is basically the DATA_WIDTH parameter, or 120bits by default)
	reg [DATA_WIDTH:0] counter_reg;		// the counter for all 1s or all 0s modes
	
	reg [DATA_WIDTH-1:0] buf_data;	// the data / length of the pulse
	reg buf_pattern_mode;				// treat the data as patterns
	reg buf_all_1_mode;				// generate all 1s at the output and treat the data as length of 1s
	reg buf_all_0_mode;				// generate all 0s at the output and treat the data as length of 0s
	reg buf_end_of_sequence;			// end of sequence flag
	
	reg [6:0] State;
	localparam [6:0]
		S0 = 7'b0000001,
		S1 = 7'b0000010,
		S2 = 7'b0000100,
		S3 = 7'b0001000,
		S4 = 7'b0010000,
		S5 = 7'b0100000,
		S6 = 7'b1000000;
	
	initial begin
		
		State <= S0;
		OUT <= 1'b0;
		DONE <= 1'b1;
		
	end
	
	always @(posedge CLK, posedge RST)
	begin
		
		if (RST)
		begin
			State <= S0;
			OUT <= 1'b0;
			DPATH_BUF_RDY <= 1'b0;
			DONE <= 1'b1;
		end
		
		else
		begin
		
			case (State)
			
				S0: // capture bitstr_code
				begin
					
					DPATH_BUF_RDY <= 1'b0;
					DONE <= 1'b1;
					
					if (START == 1'b1)
						State <= S1;
					
				end
				
				S1: // buffer all the input
				begin
					
					DONE <= 1'b0;
					
					buf_data			<= data;
					buf_pattern_mode	<= pattern_mode;		
					buf_all_1_mode		<= all_1_mode;
					buf_all_0_mode		<= all_0_mode;
					buf_end_of_sequence	<= end_of_sequence;
					
					State <= S2; 
				
				end
				
				S2: // parse commands
				begin
				
					DPATH_BUF_RDY <= 1'b1; // DPATH_BUF_RDY parsing the command, tell the controller to load more data from the SRAM
					
					counter_reg <= {1'b1,{(DATA_WIDTH){1'b0}}} - buf_data + 2'b11;
					stream_reg <= buf_data;
					str_counter_reg <= {1'b1,{7{1'b0}}} - DATA_WIDTH + 2'b11;
					
					// get the output combinationally
					if (buf_all_0_mode)
					begin
						OUT <= 1'b0;
						State <= S3;
					end	
						
					else if (buf_all_1_mode)
					begin
						OUT <= 1'b1;
						State <= S4;
					end
					
					else if (buf_pattern_mode)
					begin
						OUT <= data[0];
						State <= S5;
					end
					
					else if (buf_end_of_sequence)
						State <= S0;
					else
						State <= S0;

				end
				
				S3: // all_0_mode
				begin
					
					DPATH_BUF_RDY <= 1'b0;
					OUT <= 1'b0;
					
					counter_reg <= counter_reg + 1'b1;
					if (counter_reg[DATA_WIDTH] == 1'b1)
					begin
						State <= S6;
					end
					
				end
				
				S4: // all_1_mode
				begin
					
					DPATH_BUF_RDY <= 1'b0;
					OUT <= 1'b1;
					
					counter_reg <= counter_reg + 1'b1;
					if (counter_reg[DATA_WIDTH] == 1'b1)
					begin
						State <= S6;
					end
						
				end
				
				S5: // pattern_mode
				begin
					
					DPATH_BUF_RDY <= 1'b0;
					
					// shift out the data
					OUT <= stream_reg[1]; // the first data (stream_reg[0]) is already output in S1 combinationally, so take the second data (stream_reg[1])
					stream_reg <= {1'b0,stream_reg[DATA_WIDTH-1:1]}; // shift the stream register
					
					str_counter_reg <= str_counter_reg + 1'b1;
					if (str_counter_reg[7] == 1'b1)
					begin
						State <= S6;
					end
						
				end
				
				S6: // reload data on the last output
				begin
					
					// the new values are loaded on the next clock cycle
					buf_data			<= data;
					buf_pattern_mode	<= pattern_mode;		
					buf_all_1_mode		<= all_1_mode;
					buf_all_0_mode		<= all_0_mode;
					buf_end_of_sequence	<= end_of_sequence;
					
					// these values below are still the previous values
					if (buf_all_0_mode)
					begin
						OUT <= 1'b0;
					end	
						
					else if (buf_all_1_mode)
					begin
						OUT <= 1'b1;
					end	
						
					else if (buf_pattern_mode)
					begin
						OUT <= stream_reg[1];
					end
					
					State <= S2;
				
				end
				
			endcase
		
		end
		
	end

endmodule

