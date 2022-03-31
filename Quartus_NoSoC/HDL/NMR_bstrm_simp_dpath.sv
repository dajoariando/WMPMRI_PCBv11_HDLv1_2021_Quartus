// author: David Ariando
// date: 29th March 2022
// operation details:
// 

`timescale 1ps / 1ps

module NMR_bstrm_simp_dpath
# (

	parameter DATA_WIDTH = 24,	// the data width
	parameter MUX_WIDTH = 16		// the mux width

)
(

	// bitstream signals
	input START,
	output reg DPATH_RDY,
	output reg DONE,
	
	// bitstream data input
	input [DATA_WIDTH-1:0] data,	// the data / length of the pulse
	input PLS_POL,					// the polarity of the pulse, either high or low
	
	// selector
	input [3:0] mux_sel,			// mux selector
	input [MUX_WIDTH-2:0] mux_in,	// mux in.
	
	// bitstream data output
	output reg OUT,
	
	// control signals
	input CLK,
	input RST
);

	reg [DATA_WIDTH:0] cnt_reg; // counter for the pulse output length
	reg [3:0] mux_sel_reg;		// the registered mux selector
	reg PLS_POL_REG;			// pulse polarity reg
	reg OUTBUF;					// buffer for output after FSM
	
	
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
		OUTBUF <= 1'b0;
		DONE <= 1'b1;
		
	end
	
	always @(posedge CLK, posedge RST)
	begin
		
		if (RST)
		begin
			State <= S0;
			OUTBUF <= 1'b0;
			DPATH_RDY <= 1'b0;
			DONE <= 1'b0;
			PLS_POL_REG <= 1'b0;
			mux_sel_reg <= 4'd0;
		end
		
		else
		begin
		
			case (State)
			
				S0: // load the counter register
				begin
					
					DONE <= 1'b0;
					DPATH_RDY <= 1'b1;
					PLS_POL_REG <= PLS_POL;
					cnt_reg <= {{1'b1},{DATA_WIDTH{1'b0}}} - {{1'b0},{data}} + 4'd8;
					mux_sel_reg <= mux_sel;
					
					if (START == 1'b1)
					begin
						State <= S1;
					end
					
				end
				
				S1: // generate the output
				begin
					
					DPATH_RDY <= 1'b0;
					OUTBUF <= PLS_POL_REG;
					cnt_reg <= cnt_reg + 1'b1;
					
					if (cnt_reg[DATA_WIDTH] == 1'b1)
						State <= S2;
				
				end
				
				S2: // added numbers to cnt_reg to account for delay
				begin
				
					cnt_reg <= {{1'b1},{DATA_WIDTH{1'b0}}} - 4'd1;
					DONE <= 1'b1;
					State <= S3;
				
				end
				
				S3: // 
				begin
					
					cnt_reg <= cnt_reg + 1'b1;
					
					if (cnt_reg[DATA_WIDTH] == 1'b1)
						State <= S0;

				end
				
			endcase
		
		end
		
	end
	
	always @* // multiplexer selector
	begin
		case (mux_sel_reg)
			
			4'd00 : OUT <= OUTBUF;
			4'd01 : OUT <= mux_in[0];
			4'd02 : OUT <= mux_in[1];
			4'd03 : OUT <= mux_in[2];
			4'd04 : OUT <= mux_in[3];
			4'd05 : OUT <= mux_in[4];
			4'd06 : OUT <= mux_in[5];
			4'd07 : OUT <= mux_in[6];
			4'd08 : OUT <= mux_in[7];
			4'd09 : OUT <= mux_in[8];
			4'd10 : OUT <= mux_in[9];
			4'd11 : OUT <= mux_in[10];
			4'd12 : OUT <= mux_in[11];
			4'd13 : OUT <= mux_in[12];
			4'd14 : OUT <= mux_in[13];
			4'd15 : OUT <= mux_in[14];
			default : OUT <= 1'b0;
					
		endcase
	
	end
	

endmodule

