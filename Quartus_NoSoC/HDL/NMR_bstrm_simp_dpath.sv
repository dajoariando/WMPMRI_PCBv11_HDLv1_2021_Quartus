// author: David Ariando
// date: 29th March 2022
// operation details:
// the datapath takes a pulse length, mux selector, and polarity and output the corresponding pulse into the OUT pin.
// the mux_in are different gated signal that can be muxed to the OUT pin, selected by mux_sel.
// the minimum clock cycles for a single pulse is 3 clock cycles.
// the DPATH_RDY is only one clock cycle and the controller of datapath should be able to capture this signal everytime it happens.
// the START signal is captured by the datapath via mailbox, so it has to be one clock cycle and can happen anytime on state-2. 
// the controller has to keep the [data, PLS_POL, and mux_sel] from signalling START until DPATH_RDY is asserted.
// the controller has to be resetted at the end of the sequence in order to reset the state to S0. Otherwise, the operation will be incorrect.
// the first state, S0, is special state where the START is captured and DPATH_RDY is always asserted. To avoid problems where controller sees multiple cycles of DPATH_RDY, it is better to use blanking pulse (output 0) for the first in the bitstream sequence, in order to make sure that the controller.
// Or, make sure that there is at least 2 clock cycles delay from when the controller expects DPATH_RDY to be asserted again. This is generally not a problem because if reading from the SRAM, it would take at least 2 clock cycles, and the FSM will take 5-6 clock cycles in order to expect for DPATH_RDY signal.
// The absolute minimum clock cycles of pulse is 3, but take into account the delay of the controller! If the controller misses to catch the DPATH_RDY that's only one clock cycle, the controller FSM will freeze when waiting for DPATH_RDY that is already passed. So the minimum clock cycles is actually limited by the controller.
// cnt_reg has to be initialized at first (and after reset) to count for 50 clock cycles, in order for the controller to have enough time to create another START pulse to really start the sequence. At first, it will count for this dummy 50 clock cycles blanking period.


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
	// output reg DONE,
	
	// bitstream data input
	input [DATA_WIDTH-1:0] data,	// the data / length of the pulse
	input PLS_POL,					// the polarity of the pulse, either high or low
	
	// selector
	input [3:0] mux_sel,		// mux selector
	input [MUX_WIDTH-2:0] mux_in,	// mux in
	
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
	reg start_reg;				// registered start signal for mailbox method
	
	
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
		
		State <= S2;
		OUTBUF <= 1'b0;
		// DONE <= 1'b1;
		cnt_reg <= {{1'b1},{DATA_WIDTH{1'b0}}} - 50; // add necessary delay of n clock cycles to account for controller FSM delay
		
	end
	
	always @(posedge CLK, posedge RST)
	begin
		
		if (RST)
		begin
			State <= S2;
			OUTBUF <= 1'b0;
			DPATH_RDY <= 1'b0;
			PLS_POL_REG <= 1'b0;
			mux_sel_reg <= 4'd0;
			start_reg <= 1'b1; // assert the initial start signal
			
			cnt_reg <= {{1'b1},{DATA_WIDTH{1'b0}}} - 50; // add necessary delay of n clock cycles to account for controller FSM delay

		end
		
		else
		begin
		
			case (State)
			
				S0: // load the counter register
				begin
					DPATH_RDY <= 1'b1; // make sure that datapath is always ready at S0
					
					if (START == 1'b1)
					begin
						start_reg <= 1'b1; // assert the initial start signal
						State <= S1;
					end

				end
					
				S1: // wait for the registered start signal
				begin
					 
					DPATH_RDY <= 1'b1;
					PLS_POL_REG <= PLS_POL;
					cnt_reg <= {{1'b1},{DATA_WIDTH{1'b0}}} - {{1'b0},{data}} + 3'd2;
					mux_sel_reg <= mux_sel;
					
					if (start_reg == 1'b1)
					begin
						start_reg <= 1'b0;
						State <= S2;
					end
				
				end
				
				S2: // generate the output
				begin
					
					if (START == 1'b1)
						start_reg <= 1'b1;
					
					DPATH_RDY <= 1'b0;
					OUTBUF <= PLS_POL_REG;
					cnt_reg <= cnt_reg + 1'b1;
					
					if (cnt_reg[DATA_WIDTH] == 1'b1 && start_reg == 1'b1)
						State <= S1;
				
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
			default : OUT <= OUTBUF;
					
		endcase
	
	end
	

endmodule

