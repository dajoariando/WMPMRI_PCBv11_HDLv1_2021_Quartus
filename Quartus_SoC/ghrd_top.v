// author	: David Ariando
// date		: May 5th, 2021
// based-on	: Terasic DE1_SoC-GHRD software package

module ghrd_top(

	// ADC
	inout              ADC_CS_N,
	output             ADC_DIN,
	input              ADC_DOUT,
	output             ADC_SCLK,

	// AUDIO
	input              AUD_ADCDAT,
	inout              AUD_ADCLRCK,
	inout              AUD_BCLK,
	output             AUD_DACDAT,
	inout              AUD_DACLRCK,
	output             AUD_XCK,

	// CLOCKS
	input              CLOCK_50,
	input              CLOCK2_50,
	input              CLOCK3_50,
	input              CLOCK4_50,

	// DRAM
	output      [12:0] DRAM_ADDR,
	output      [1:0]  DRAM_BA,
	output             DRAM_CAS_N,
	output             DRAM_CKE,
	output             DRAM_CLK,
	output             DRAM_CS_N,
	inout       [15:0] DRAM_DQ,
	output             DRAM_LDQM,
	output             DRAM_RAS_N,
	output             DRAM_UDQM,
	output             DRAM_WE_N,

	// FAN
	output             FAN_CTRL,

	// FPGA I2C
	output             FPGA_I2C_SCLK,
	inout              FPGA_I2C_SDAT,

	// GPIOs
	inout     [35:0]         GPIO_0,
	inout     [35:0]         GPIO_1,

	// 7-segment LEDs
	output      [6:0]  HEX0,
	output      [6:0]  HEX1,
	output      [6:0]  HEX2,
	output      [6:0]  HEX3,
	output      [6:0]  HEX4,
	output      [6:0]  HEX5,

	// HPS
	inout              HPS_CONV_USB_N,
	output      [14:0] HPS_DDR3_ADDR,
	output      [2:0]  HPS_DDR3_BA,
	output             HPS_DDR3_CAS_N,
	output             HPS_DDR3_CKE,
	output             HPS_DDR3_CK_N,
	output             HPS_DDR3_CK_P,
	output             HPS_DDR3_CS_N,
	output      [3:0]  HPS_DDR3_DM,
	inout       [31:0] HPS_DDR3_DQ,
	inout       [3:0]  HPS_DDR3_DQS_N,
	inout       [3:0]  HPS_DDR3_DQS_P,
	output             HPS_DDR3_ODT,
	output             HPS_DDR3_RAS_N,
	output             HPS_DDR3_RESET_N,
	input              HPS_DDR3_RZQ,
	output             HPS_DDR3_WE_N,
	output             HPS_ENET_GTX_CLK,
	inout              HPS_ENET_INT_N,
	output             HPS_ENET_MDC,
	inout              HPS_ENET_MDIO,
	input              HPS_ENET_RX_CLK,
	input       [3:0]  HPS_ENET_RX_DATA,
	input              HPS_ENET_RX_DV,
	output      [3:0]  HPS_ENET_TX_DATA,
	output             HPS_ENET_TX_EN,
	inout       [3:0]  HPS_FLASH_DATA,
	output             HPS_FLASH_DCLK,
	output             HPS_FLASH_NCSO,
	inout              HPS_GSENSOR_INT,
	inout              HPS_I2C1_SCLK,
	inout              HPS_I2C1_SDAT,
	inout              HPS_I2C2_SCLK,
	inout              HPS_I2C2_SDAT,
	inout              HPS_I2C_CONTROL,
	inout              HPS_KEY,
	inout              HPS_LED,
	inout              HPS_LTC_GPIO,
	output             HPS_SD_CLK,
	inout              HPS_SD_CMD,
	inout       [3:0]  HPS_SD_DATA,
	output             HPS_SPIM_CLK,
	input              HPS_SPIM_MISO,
	output             HPS_SPIM_MOSI,
	inout              HPS_SPIM_SS,
	input              HPS_UART_RX,
	output             HPS_UART_TX,
	input              HPS_USB_CLKOUT,
	inout       [7:0]  HPS_USB_DATA,
	input              HPS_USB_DIR,
	input              HPS_USB_NXT,
	output             HPS_USB_STP,

	// IRDA
	input              IRDA_RXD,
	output             IRDA_TXD,

	// KEY
	input       [3:0]  KEY,

	// LEDS
	output      [9:0]  LEDR,

	// PS2
	inout              PS2_CLK,
	inout              PS2_CLK2,
	inout              PS2_DAT,
	inout              PS2_DAT2,

	// Switches
	input       [9:0]  SW,

	// TD
	input				TD_CLK27,
	input      [7:0]	TD_DATA,
	input				TD_HS,
	output				TD_RESET_N,
	input				TD_VS,


	// VGA
	output      [7:0]  VGA_B,
	output             VGA_BLANK_N,
	output             VGA_CLK,
	output      [7:0]  VGA_G,
	output             VGA_HS,
	output      [7:0]  VGA_R,
	output             VGA_SYNC_N,
	output             VGA_VS
	
);

	// PARAMETERS
	localparam BUS_WIDTH = 32;

	//=======================================================
	//  REG/WIRE declarations
	//=======================================================
	wire			hps_fpga_reset_n;
	wire [3:0]	fpga_debounced_buttons;
	wire [8:0]	fpga_led_internal;
	wire [2:0]	hps_reset_req;
	wire			hps_cold_reset;
	wire			hps_warm_reset;
	wire			hps_debug_reset;
	wire [27:0]	stm_hw_events;
	// connection of internal logics
	assign LEDR[9:1] = fpga_led_internal;
	assign stm_hw_events    = {{4{1'b0}}, SW, fpga_led_internal, fpga_debounced_buttons};

	wire sys_pll_lock; 												// lock signal for sys_pll
	wire bitstr_fifo_rst; 											// bitstream fifo reset signal
	wire sys_pll_clk0						/* synthesis keep */;	// system pll clock output
	wire bitstr_start;												// bitstream start signal
	wire bitstr_start_sync					/* synthesis keep */;

	wire bitstr_ready						/* synthesis keep */;	// bistream ready signal for the FIFO
	wire bitstr_fifo_valid					/* synthesis keep */;	// valid signal from the FIFO
	wire [BUS_WIDTH-1:0] bitstr_fifo_out 	/* synthesis keep */;	// bitstream out from the FIFO
	wire sys_pll_rst;												// system pll reset
	wire bitstr_rst;												// bitstream reset signal
	wire bitstr_stop;												// bitstream stop signal issued by the SoC
	wire bitstr_stop_sync					/* synthesis keep */;
	wire bitstr_end							/* synthesis keep */;	// bitstream end signal issued by the bitstream module
	
	//=======================================================
	//  Structural coding
	//=======================================================
	soc_system u0 (      
		
		// System signals
		.clk_clk                               (CLOCK_50),                             //                clk.clk
		.reset_reset_n                         (1'b1),                                 //                reset.reset_n
		
		// HPS DDR3
		.memory_mem_a                          ( HPS_DDR3_ADDR),                       //                memory.mem_a
		.memory_mem_ba                         ( HPS_DDR3_BA),                         //                .mem_ba
		.memory_mem_ck                         ( HPS_DDR3_CK_P),                       //                .mem_ck
		.memory_mem_ck_n                       ( HPS_DDR3_CK_N),                       //                .mem_ck_n
		.memory_mem_cke                        ( HPS_DDR3_CKE),                        //                .mem_cke
		.memory_mem_cs_n                       ( HPS_DDR3_CS_N),                       //                .mem_cs_n
		.memory_mem_ras_n                      ( HPS_DDR3_RAS_N),                      //                .mem_ras_n
		.memory_mem_cas_n                      ( HPS_DDR3_CAS_N),                      //                .mem_cas_n
		.memory_mem_we_n                       ( HPS_DDR3_WE_N),                       //                .mem_we_n
		.memory_mem_reset_n                    ( HPS_DDR3_RESET_N),                    //                .mem_reset_n
		.memory_mem_dq                         ( HPS_DDR3_DQ),                         //                .mem_dq
		.memory_mem_dqs                        ( HPS_DDR3_DQS_P),                      //                .mem_dqs
		.memory_mem_dqs_n                      ( HPS_DDR3_DQS_N),                      //                .mem_dqs_n
		.memory_mem_odt                        ( HPS_DDR3_ODT),                        //                .mem_odt
		.memory_mem_dm                         ( HPS_DDR3_DM),                         //                .mem_dm
		.memory_oct_rzqin                      ( HPS_DDR3_RZQ),                        //                .oct_rzqin
		
		// HPS Ethernet		
		.hps_0_hps_io_hps_io_emac1_inst_TX_CLK ( HPS_ENET_GTX_CLK),       //                             hps_0_hps_io.hps_io_emac1_inst_TX_CLK
		.hps_0_hps_io_hps_io_emac1_inst_TXD0   ( HPS_ENET_TX_DATA[0] ),   //                             .hps_io_emac1_inst_TXD0
		.hps_0_hps_io_hps_io_emac1_inst_TXD1   ( HPS_ENET_TX_DATA[1] ),   //                             .hps_io_emac1_inst_TXD1
		.hps_0_hps_io_hps_io_emac1_inst_TXD2   ( HPS_ENET_TX_DATA[2] ),   //                             .hps_io_emac1_inst_TXD2
		.hps_0_hps_io_hps_io_emac1_inst_TXD3   ( HPS_ENET_TX_DATA[3] ),   //                             .hps_io_emac1_inst_TXD3
		.hps_0_hps_io_hps_io_emac1_inst_RXD0   ( HPS_ENET_RX_DATA[0] ),   //                             .hps_io_emac1_inst_RXD0
		.hps_0_hps_io_hps_io_emac1_inst_MDIO   ( HPS_ENET_MDIO ),         //                             .hps_io_emac1_inst_MDIO
		.hps_0_hps_io_hps_io_emac1_inst_MDC    ( HPS_ENET_MDC  ),         //                             .hps_io_emac1_inst_MDC
		.hps_0_hps_io_hps_io_emac1_inst_RX_CTL ( HPS_ENET_RX_DV),         //                             .hps_io_emac1_inst_RX_CTL
		.hps_0_hps_io_hps_io_emac1_inst_TX_CTL ( HPS_ENET_TX_EN),         //                             .hps_io_emac1_inst_TX_CTL
		.hps_0_hps_io_hps_io_emac1_inst_RX_CLK ( HPS_ENET_RX_CLK),        //                             .hps_io_emac1_inst_RX_CLK
		.hps_0_hps_io_hps_io_emac1_inst_RXD1   ( HPS_ENET_RX_DATA[1] ),   //                             .hps_io_emac1_inst_RXD1
		.hps_0_hps_io_hps_io_emac1_inst_RXD2   ( HPS_ENET_RX_DATA[2] ),   //                             .hps_io_emac1_inst_RXD2
		.hps_0_hps_io_hps_io_emac1_inst_RXD3   ( HPS_ENET_RX_DATA[3] ),   //                             .hps_io_emac1_inst_RXD3
		
		// HPS QSPI  
		.hps_0_hps_io_hps_io_qspi_inst_IO0     ( HPS_FLASH_DATA[0]    ),     //                               .hps_io_qspi_inst_IO0
		.hps_0_hps_io_hps_io_qspi_inst_IO1     ( HPS_FLASH_DATA[1]    ),     //                               .hps_io_qspi_inst_IO1
		.hps_0_hps_io_hps_io_qspi_inst_IO2     ( HPS_FLASH_DATA[2]    ),     //                               .hps_io_qspi_inst_IO2
		.hps_0_hps_io_hps_io_qspi_inst_IO3     ( HPS_FLASH_DATA[3]    ),     //                               .hps_io_qspi_inst_IO3
		.hps_0_hps_io_hps_io_qspi_inst_SS0     ( HPS_FLASH_NCSO    ),        //                               .hps_io_qspi_inst_SS0
		.hps_0_hps_io_hps_io_qspi_inst_CLK     ( HPS_FLASH_DCLK    ),        //                               .hps_io_qspi_inst_CLK
		
		// HPS SD Card 
		.hps_0_hps_io_hps_io_sdio_inst_CMD     ( HPS_SD_CMD    ),           //                               .hps_io_sdio_inst_CMD
		.hps_0_hps_io_hps_io_sdio_inst_D0      ( HPS_SD_DATA[0]     ),      //                               .hps_io_sdio_inst_D0
		.hps_0_hps_io_hps_io_sdio_inst_D1      ( HPS_SD_DATA[1]     ),      //                               .hps_io_sdio_inst_D1
		.hps_0_hps_io_hps_io_sdio_inst_CLK     ( HPS_SD_CLK   ),            //                               .hps_io_sdio_inst_CLK
		.hps_0_hps_io_hps_io_sdio_inst_D2      ( HPS_SD_DATA[2]     ),      //                               .hps_io_sdio_inst_D2
		.hps_0_hps_io_hps_io_sdio_inst_D3      ( HPS_SD_DATA[3]     ),      //                               .hps_io_sdio_inst_D3
		
		// HPS USB 		  
		.hps_0_hps_io_hps_io_usb1_inst_D0      ( HPS_USB_DATA[0]    ),      //                               .hps_io_usb1_inst_D0
		.hps_0_hps_io_hps_io_usb1_inst_D1      ( HPS_USB_DATA[1]    ),      //                               .hps_io_usb1_inst_D1
		.hps_0_hps_io_hps_io_usb1_inst_D2      ( HPS_USB_DATA[2]    ),      //                               .hps_io_usb1_inst_D2
		.hps_0_hps_io_hps_io_usb1_inst_D3      ( HPS_USB_DATA[3]    ),      //                               .hps_io_usb1_inst_D3
		.hps_0_hps_io_hps_io_usb1_inst_D4      ( HPS_USB_DATA[4]    ),      //                               .hps_io_usb1_inst_D4
		.hps_0_hps_io_hps_io_usb1_inst_D5      ( HPS_USB_DATA[5]    ),      //                               .hps_io_usb1_inst_D5
		.hps_0_hps_io_hps_io_usb1_inst_D6      ( HPS_USB_DATA[6]    ),      //                               .hps_io_usb1_inst_D6
		.hps_0_hps_io_hps_io_usb1_inst_D7      ( HPS_USB_DATA[7]    ),      //                               .hps_io_usb1_inst_D7
		.hps_0_hps_io_hps_io_usb1_inst_CLK     ( HPS_USB_CLKOUT    ),       //                               .hps_io_usb1_inst_CLK
		.hps_0_hps_io_hps_io_usb1_inst_STP     ( HPS_USB_STP    ),          //                               .hps_io_usb1_inst_STP
		.hps_0_hps_io_hps_io_usb1_inst_DIR     ( HPS_USB_DIR    ),          //                               .hps_io_usb1_inst_DIR
		.hps_0_hps_io_hps_io_usb1_inst_NXT     ( HPS_USB_NXT    ),          //                               .hps_io_usb1_inst_NXT
		
		// HPS SPI 		  
		.hps_0_hps_io_hps_io_spim1_inst_CLK    ( HPS_SPIM_CLK  ),           //                               .hps_io_spim1_inst_CLK
		.hps_0_hps_io_hps_io_spim1_inst_MOSI   ( HPS_SPIM_MOSI ),           //                               .hps_io_spim1_inst_MOSI
		.hps_0_hps_io_hps_io_spim1_inst_MISO   ( HPS_SPIM_MISO ),           //                               .hps_io_spim1_inst_MISO
		.hps_0_hps_io_hps_io_spim1_inst_SS0    ( HPS_SPIM_SS ),             //                               .hps_io_spim1_inst_SS0
		
		// HPS UART		
		.hps_0_hps_io_hps_io_uart0_inst_RX     ( HPS_UART_RX    ),          //                               .hps_io_uart0_inst_RX
		.hps_0_hps_io_hps_io_uart0_inst_TX     ( HPS_UART_TX    ),          //                               .hps_io_uart0_inst_TX
		
		// HPS I2C1
		.hps_0_hps_io_hps_io_i2c0_inst_SDA     ( HPS_I2C1_SDAT    ),        //                               .hps_io_i2c0_inst_SDA
		.hps_0_hps_io_hps_io_i2c0_inst_SCL     ( HPS_I2C1_SCLK    ),        //                               .hps_io_i2c0_inst_SCL
		
		//HPS I2C2
		.hps_0_hps_io_hps_io_i2c1_inst_SDA     ( HPS_I2C2_SDAT    ),        //                               .hps_io_i2c1_inst_SDA
		.hps_0_hps_io_hps_io_i2c1_inst_SCL     ( HPS_I2C2_SCLK    ),        //                               .hps_io_i2c1_inst_SCL
		
		// HPS GPIO  
		.hps_0_hps_io_hps_io_gpio_inst_GPIO09  ( HPS_CONV_USB_N),           //                               .hps_io_gpio_inst_GPIO09
		.hps_0_hps_io_hps_io_gpio_inst_GPIO35  ( HPS_ENET_INT_N),           //                               .hps_io_gpio_inst_GPIO35
		.hps_0_hps_io_hps_io_gpio_inst_GPIO40  ( HPS_LTC_GPIO),              //                               .hps_io_gpio_inst_GPIO40
		//.hps_0_hps_io_hps_io_gpio_inst_GPIO41  ( HPS_GPIO[1]),              //                               .hps_io_gpio_inst_GPIO41
		.hps_0_hps_io_hps_io_gpio_inst_GPIO48  ( HPS_I2C_CONTROL),          //                               .hps_io_gpio_inst_GPIO48
		.hps_0_hps_io_hps_io_gpio_inst_GPIO53  ( HPS_LED),                  //                               .hps_io_gpio_inst_GPIO53
		.hps_0_hps_io_hps_io_gpio_inst_GPIO54  ( HPS_KEY),                  //                               .hps_io_gpio_inst_GPIO54
		.hps_0_hps_io_hps_io_gpio_inst_GPIO61  ( HPS_GSENSOR_INT),          //                               .hps_io_gpio_inst_GPIO61
		
		// Onboard I/Os
		.led_pio_external_connection_export    ( fpga_led_internal 	),    //    led_pio_external_connection.export
		.dipsw_pio_external_connection_export  ( SW	),						//  dipsw_pio_external_connection.export
		.button_pio_external_connection_export ( fpga_debounced_buttons	), 	// button_pio_external_connection.export
		
		// HPS Reset Output
		.hps_0_h2f_reset_reset_n               ( hps_fpga_reset_n ),                //                hps_0_h2f_reset.reset_n
		.hps_0_f2h_cold_reset_req_reset_n      (~hps_cold_reset ),      //       hps_0_f2h_cold_reset_req.reset_n
		.hps_0_f2h_debug_reset_req_reset_n     (~hps_debug_reset ),     //      hps_0_f2h_debug_reset_req.reset_n
		.hps_0_f2h_stm_hw_events_stm_hwevents  (stm_hw_events ),  //        hps_0_f2h_stm_hw_events.stm_hwevents
		.hps_0_f2h_warm_reset_req_reset_n      (~hps_warm_reset ),      //       hps_0_f2h_warm_reset_req.reset_n
		
		// Bitstream FIFO out
		.bitstr_fifo_clk_out_clk               (sys_pll_clk0),         //            bitstr_fifo_clk_out.clk
		.bitstr_fifo_reset_out_reset_n         (~bitstr_fifo_rst),         //          bitstr_fifo_reset_out.reset_n
		.bitstr_fifo_out_valid                 (bitstr_fifo_valid),         //                bitstr_fifo_out.valid
		.bitstr_fifo_out_data                  (bitstr_fifo_out),         //                               .data
		.bitstr_fifo_out_ready                 (bitstr_ready),         //                               .ready
		
		// System PLL
		.sys_pll_locked_export                 (sys_pll_lock),			//                 sys_pll_locked.export
		.sys_pll_clk0_clk                      (sys_pll_clk0),           //                   sys_pll_clk0.clk
		.sys_pll_reset_reset                   (sys_pll_rst),                    //                  sys_pll_reset.reset
		
		// control signals
		.cnt_out_export                        ({
			bitstr_adv_rst,
			bitstr_adv_start,
			sys_pll_rst,
			bitstr_stop,
			bitstr_rst,
			bitstr_start,
			bitstr_fifo_rst
		}),                        //                        cnt_out.export
		
		
		.cnt_in_export                         ({
			bitstr_adv_done,
			bitstr_end,
			sys_pll_lock
		}),                          //                         cnt_in.export
		
		.ram_tx_en_s2_address                  (SRAM_ADDR),		// .ram_tx_en_s2.address
        .ram_tx_en_s2_chipselect               (SRAM_CS),		// .chipselect
        .ram_tx_en_s2_clken                    (SRAM_CLKEN),		// .clken
        .ram_tx_en_s2_write                    (SRAM_WR),		// .write
        .ram_tx_en_s2_readdata                 (SRAM_RD_DAT),		// .readdata
        .ram_tx_en_s2_writedata                (SRAM_WR_DAT),		// .writedata
        .ram_tx_en_s2_byteenable               (SRAM_BYTEEN),		// .byteenable
        .ram_tx_en_clk2_clk                    (CLOCK_50),		// .ram_tx_en_clk2.clk
        .ram_tx_en_reset2_reset                (bitstr_adv_rst) 		// .ram_tx_en_reset2.reset
		
	);

	CDC_Input_Synchronizer
	#(
		.SYNC_REG_LEN (2)
	)
	CDC_Input_Synchronizer_bitstr_start
	(
		// Input Signal
		.ASYNC_IN (bitstr_start),
		
		// Output Signal
		.SYNC_OUT (bitstr_start_sync),
		
		// System Signals
		.CLK (CLOCK_50)
	);
	CDC_Input_Synchronizer
	#(
		.SYNC_REG_LEN (2)
	)
	CDC_Input_Synchronizer_bitstr_stop
	(
		// Input Signal
		.ASYNC_IN (bitstr_stop),
		
		// Output Signal
		.SYNC_OUT (bitstr_stop_sync),
		
		// System Signals
		.CLK (CLOCK_50)
	);


	NMR_bstrm_fifo
	# (
		.BUS_WIDTH (BUS_WIDTH)
	)
	NMR_bstrm_fifo_1
	(
		// bitstream signals
		.START (bitstr_start_sync),	// start taking ada from the FIFO
		.READY (bitstr_ready),	// ready to take data (required by the FIFO)
		.STOP (bitstr_stop_sync), // stop signal from the SoC

		// bitstream data input
		.bitstr_in (bitstr_fifo_out),
		
		// bitstream outputs
		.bitstr_out (bitstr_out),
		.D_END (bitstr_end), // the signal that marks the end of the sequence, issued to the SoC


		// control signals
		.CLK (CLOCK_50),
		.RST (bitstr_rst)
	);

	assign GPIO_0[31:0] = bitstr_out;
	assign GPIO_1[35] = bitstr_fifo_valid;



	localparam IDLY_WIDTH = 32; // the initial delay width
	localparam PLS_WIDTH = 32; // the pulse width
	localparam EDLY_WIDTH = 32; // post-pulse delay width
	localparam CNT_WIDTH = 32;	// the control signal width
	localparam CMD_WIDTH = 8;		// the command counter width
	localparam LOOP_WIDTH = 16;		// loop width for the looping parameter
	localparam SRAM_ADDR_WIDTH = 8; // the SRAM address width; find it in Platform Designer of the On-Chip Memory (RAM)
	localparam SRAM_DAT_WIDTH = 128; // the SRAM data width; find it in Platform Designer of the On-Chip Memory (RAM)
	localparam SRAM_BYTEEN_WIDTH = 16; // the byte enable width; find it in Platform Designer of the On-Chip Memory (RAM)
	
	// bitstream signals
	wire bitstr_adv_start	/* synthesis keep */;
	wire bitstr_adv_done	/* synthesis keep */;
	wire bitstr_adv_rst;
	
	// SRAM access
	wire[SRAM_ADDR_WIDTH-1:0] SRAM_ADDR	/* synthesis keep */;		// SRAM address
	wire SRAM_CS /* synthesis keep */;								// SRAM chip select
	wire SRAM_CLKEN;							// SRAM clock enable
	wire SRAM_WR;								// SRAM write
	wire [SRAM_DAT_WIDTH-1:0]	SRAM_RD_DAT	/* synthesis keep */;	// SRAM read data
	wire [SRAM_DAT_WIDTH-1:0]	SRAM_WR_DAT;	// SRAM write data
	wire [SRAM_BYTEEN_WIDTH-1:0] SRAM_BYTEEN;	// SRAM byte enable
	
	
	NMR_bstrm_pls_top
	#(
		
		.IDLY_WIDTH			(IDLY_WIDTH), 		// the initial delay width
		.PLS_WIDTH			(PLS_WIDTH), 		// the pulse width
		.EDLY_WIDTH			(EDLY_WIDTH), 		// post-pulse delay width
		.CNT_WIDTH			(CNT_WIDTH),		// the control signal width
		.CMD_WIDTH			(CMD_WIDTH),		// the command counter width
		.LOOP_WIDTH			(LOOP_WIDTH),		// loop width for the looping parameter
		.SRAM_ADDR_WIDTH	(SRAM_ADDR_WIDTH), 	// the SRAM address width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_DAT_WIDTH		(SRAM_DAT_WIDTH), 	// the SRAM data width, find it in Platform Designer of the On-Chip Memory (RAM)
		.SRAM_BYTEEN_WIDTH	(SRAM_BYTEEN_WIDTH) // the byte enable width, find it in Platform Designer of the On-Chip Memory (RAM)
		
	) bitstr_adv1
	(
		
		.START		(bitstr_adv_start),
		.DONE		(bitstr_adv_done),
		
		// SRAM access
		.SRAM_ADDR		(SRAM_ADDR),	// SRAM address
		.SRAM_CS		(SRAM_CS),		// SRAM chip select
		.SRAM_CLKEN		(SRAM_CLKEN),	// SRAM clock enable
		.SRAM_WR		(SRAM_WR),		// SRAM write
		.SRAM_RD_DAT	(SRAM_RD_DAT),	// SRAM read data
		.SRAM_WR_DAT	(SRAM_WR_DAT),	// SRAM write data
		.SRAM_BYTEEN	(SRAM_BYTEEN),	// SRAM byte enable
		
		// bitstream data output
		.OUT			(GPIO_1[0]),
		
		// control signals
		.CLK			(CLOCK_50),
		.RST			(bitstr_adv_rst)
		
	);






















// Debounce logic to clean out glitches within 1ms
debounce debounce_inst (
	.clk                                  (CLOCK_50),
	.reset_n                              (hps_fpga_reset_n),  
	.data_in                              (KEY),
	.data_out                             (fpga_debounced_buttons)
);
defparam debounce_inst.WIDTH = 4;
defparam debounce_inst.POLARITY = "LOW";
defparam debounce_inst.TIMEOUT = 50000;               // at 50Mhz this is a debounce time of 1ms
defparam debounce_inst.TIMEOUT_WIDTH = 16;            // ceil(log2(TIMEOUT))
  
// Source/Probe megawizard instance
hps_reset hps_reset_inst (
	.source_clk (CLOCK_50),
	.source     (hps_reset_req)
);

altera_edge_detector pulse_cold_reset (
	.clk       (CLOCK_50),
	.rst_n     (hps_fpga_reset_n),
	.signal_in (hps_reset_req[0]),
	.pulse_out (hps_cold_reset)
);
defparam pulse_cold_reset.PULSE_EXT = 6;
defparam pulse_cold_reset.EDGE_TYPE = 1;
defparam pulse_cold_reset.IGNORE_RST_WHILE_BUSY = 1;

altera_edge_detector pulse_warm_reset (
	.clk       (CLOCK_50),
	.rst_n     (hps_fpga_reset_n),
	.signal_in (hps_reset_req[1]),
	.pulse_out (hps_warm_reset)
);
defparam pulse_warm_reset.PULSE_EXT = 2;
defparam pulse_warm_reset.EDGE_TYPE = 1;
defparam pulse_warm_reset.IGNORE_RST_WHILE_BUSY = 1;
  
altera_edge_detector pulse_debug_reset (
	.clk       (CLOCK_50),
	.rst_n     (hps_fpga_reset_n),
	.signal_in (hps_reset_req[2]),
	.pulse_out (hps_debug_reset)
);
defparam pulse_debug_reset.PULSE_EXT = 32;
defparam pulse_debug_reset.EDGE_TYPE = 1;
defparam pulse_debug_reset.IGNORE_RST_WHILE_BUSY = 1;

endmodule

  