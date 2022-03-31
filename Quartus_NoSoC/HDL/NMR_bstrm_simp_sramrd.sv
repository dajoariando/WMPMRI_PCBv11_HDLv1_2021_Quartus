// author: David Ariando
// date: 30 March 2022
// operation details:
// this module takes data from SRAM and make it available in the output
// the START has to be turned on only for one clock cycle and the data has to be captured when DATA_RDY is high (only one clock cycle as well).

module NMR_bstrm_simp_sramrd_cnt 
#(
	parameter SRAM_ADDR_WIDTH = 8,		// the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
	parameter SRAM_DAT_WIDTH = 32		// the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
	// parameter SRAM_BYTEEN_WIDTH = 16	// the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
)
(
	// bitstream signals
	input START,
	output reg SYS_RDY,
	output reg DATA_RDY,
	
	// SRAM access
	// input [SRAM_ADDR_WIDTH-1:0] SRAM_ADDR,			// SRAM address 
	output reg SRAM_CS,								// SRAM chip select
	input [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT,		// SRAM read data
	// output [SRAM_ADDR_WIDTH-1:0] SRAM_ADDR_PHY,		// SRAM address physical conns
	
	// bitstream control data
	output reg [SRAM_DAT_WIDTH-1:0] data_reg,
	
	// control signals
	input CLK,
	input RST
);
		
	reg [4:0] State;
	localparam [4:0]
		S0 = 5'b00001,
		S1 = 5'b00010,
		S2 = 5'b00100,
		S3 = 5'b01000,
		S4 = 5'b10000;

	initial begin
		State 		<= S0;
		SRAM_CS		<= 1'b0;
		SYS_RDY		<= 1'b0;
		data_reg 	<= {SRAM_DAT_WIDTH{1'b0}};
	end

	
	always @(posedge CLK, posedge RST)
	begin
		
		if (RST)
		begin
			State <= S0;
			SRAM_CS <= 1'b0;
			SYS_RDY <= 1'b0;
			DATA_RDY <= 1'b0;
			data_reg <= {SRAM_DAT_WIDTH{1'b0}};
		end
		
		else
		begin
		
			case (State)
			
				S0: // enable the CS
				begin
					
					SYS_RDY <= 1'b1;
					DATA_RDY <= 1'b0;
					SRAM_CS <= 1'b1;
					
					if (START == 1'b1)
						State <= S1;
					
				end		
				
				S1: // disable the CS
				begin
					
					SYS_RDY <= 1'b0;					
					SRAM_CS <= 1'b0;				
					State <= S2;
					
				end
				
				
				
				S2: // delay one clock cycle to process data
				begin
					
					data_reg <= SRAM_RD_DAT;
					DATA_RDY <= 1'b1;
					State <= S0;
					
				end
			
			endcase
		
		end
		
	end

endmodule