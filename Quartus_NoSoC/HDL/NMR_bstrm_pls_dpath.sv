// author: David Ariando
// date: 15th June 2021
// operation details:
// this module takes a variable of ....
// and ...

`timescale 1ps / 1ps

module NMR_bstrm_pls_dpath
# (
	parameter IDLY_WIDTH = 32, // the initial delay width
	parameter PLS_WIDTH = 32, // the pulse width
	parameter EDLY_WIDTH = 32 // post-pulse delay width
)
(

	// bitstream signals
	input START,
	output reg DONE,
	
	// bitstream data input
	input [IDLY_WIDTH-1:0] idly, // should be already synchronized with CLK
	input [PLS_WIDTH-1:0] pls,
	input [EDLY_WIDTH-1:0] edly,
	
	
	// bitstream data output
	output reg OUT,
	
	// control signals
	input CLK,
	input RST
);

	reg [IDLY_WIDTH:0] idly_cnt;
	reg [PLS_WIDTH:0] pls_cnt;
	reg [EDLY_WIDTH:0] edly_cnt;
	
	reg [4:0] State;
		localparam [4:0]
			S0 = 5'b00001,
			S1 = 5'b00010,
			S2 = 5'b00100,
			S3 = 5'b01000,
			S4 = 5'b10000;
	
	initial begin
		
		State <= S0;
		OUT <= 1'b0;
		
	end
	
	always @(posedge CLK, posedge RST)
	begin
		
		if (RST)
		begin
			State <= S0;
			OUT <= 1'b0;
			DONE <= 1'b0;
		end
		
		else
		begin
		
			case (State)
			
				S0: // capture bitstr_code
				begin
					DONE <= 1'b1;
				
					idly_cnt <= {1'b1,{(IDLY_WIDTH){1'b0}}} - idly + 1'b1;
					pls_cnt <= {1'b1,{(PLS_WIDTH){1'b0}}} - pls + 1'b1;
					edly_cnt <= {1'b1,{(EDLY_WIDTH){1'b0}}} - edly + 1'b1;
					
					if (START == 1'b1)
						State <= S1;
					
				end
				
				S1: // delay count
				begin
					idly_cnt <= idly_cnt + 1'b1;
					OUT <= 1'b0;
					DONE <= 1'b0;
					
					if (idly_cnt[IDLY_WIDTH] == 1'b1)
						State <= S2;

				end
				
				S2: // pulse generation
				begin
					pls_cnt <= pls_cnt + 1'b1;
					OUT <= 1'b1;
					
					if (pls_cnt[PLS_WIDTH] == 1'b1)
						State <= S3;
					
				end
				
				S3: // delay after pulse
				begin
					edly_cnt <= edly_cnt + 1'b1;
					OUT <= 1'b0;
					
					if (edly_cnt[EDLY_WIDTH] == 1'b1)
						State <= S4;
						
				end
				
				S4: // end
				begin
					
					DONE <= 1'b1;
					
					if (START == 1'b0)
						State <= S0;
				end
			
			endcase
		
		end
		
	end

endmodule

