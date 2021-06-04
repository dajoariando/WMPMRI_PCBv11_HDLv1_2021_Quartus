`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Case Western Reserve University
// Engineer: Matt McConnell
// 
// Create Date:    00:48:00 01/25/2017 
// Project Name:   EECS301 Digital Design
// Design Name:    Lab #3 Project
// Module Name:    CDC_Input_Synchronizer
// Target Devices: Altera Cyclone V
// Tool versions:  Quartus v17.0
// Description:    Clock Domain Crossing Synchronizer
//
// Dependencies:   
//
//////////////////////////////////////////////////////////////////////////////////

module CDC_Input_Synchronizer
#(
	parameter SYNC_REG_LEN = 2
)
(
	// Input Signal
	input      ASYNC_IN,
	
	// Output Signal
	output     SYNC_OUT,
	
	// System Signals
	input CLK
);


//
// Set a SDC False Path for the async input register so Quartus
// properly reconizes the synchronizer chain and calculates MTBF.
//
(* altera_attribute = {"-name SDC_STATEMENT \"set_false_path -to [get_registers {*|CDC_Input_Synchronizer:*|async_reg}]\""} *)


	//
	// Asynchronous Input Signal Register
	//
	reg async_reg;

	initial
	begin
		async_reg = 1'b0;
	end
	
	always @(posedge CLK)
	begin
		async_reg <= ASYNC_IN;
	end

	
	//
	// Synchronous Registers
	//
	genvar i;
	
	generate
	begin
	
		if (SYNC_REG_LEN < 1)
		begin
		
			assign SYNC_OUT = async_reg;
			
		end
		else
		begin
		
			reg [SYNC_REG_LEN-1:0] sync_reg;
			
			assign SYNC_OUT = sync_reg[SYNC_REG_LEN-1];
			
			initial
			begin
				sync_reg = {SYNC_REG_LEN{1'b0}};
			end
			
			for (i=0; i < SYNC_REG_LEN; i=i+1)
			begin : sync_reg_gen
				
				if (i == 0)
				begin
				
					always @(posedge CLK)
					begin
						sync_reg[i] <= async_reg;
					end
					
				end
				else
				begin
				
					always @(posedge CLK)
					begin
						sync_reg[i] <= sync_reg[i-1];
					end
				
				end
	
			end

		end
		
	end
	endgenerate
	
endmodule
