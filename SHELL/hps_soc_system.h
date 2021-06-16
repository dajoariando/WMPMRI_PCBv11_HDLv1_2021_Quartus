#ifndef _ALTERA_HPS_SOC_SYSTEM_H_
#define _ALTERA_HPS_SOC_SYSTEM_H_

/*
 * This file was automatically generated by the swinfo2header utility.
 * 
 * Created from SOPC Builder system 'soc_system' in
 * file '../Quartus_SoC/soc_system.sopcinfo'.
 */

/*
 * This file contains macros for module 'hps_0' and devices
 * connected to the following masters:
 *   h2f_axi_master
 *   h2f_lw_axi_master
 * 
 * Do not include this header file and another header file created for a
 * different module or master group at the same time.
 * Doing so may result in duplicate macro names.
 * Instead, use the system header file which has macros with unique names.
 */

/*
 * Macros for device 'onchip_memory2_0', class 'altera_avalon_onchip_memory2'
 * The macros are prefixed with 'ONCHIP_MEMORY2_0_'.
 * The prefix is the slave descriptor.
 */
#define ONCHIP_MEMORY2_0_COMPONENT_TYPE altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_0_COMPONENT_NAME onchip_memory2_0
#define ONCHIP_MEMORY2_0_BASE 0x0
#define ONCHIP_MEMORY2_0_SPAN 65536
#define ONCHIP_MEMORY2_0_END 0xffff
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE AUTO
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE soc_system_onchip_memory2_0
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_0_INSTANCE_ID NONE
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE AUTO
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE DONT_CARE
#define ONCHIP_MEMORY2_0_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_SIZE_VALUE 65536
#define ONCHIP_MEMORY2_0_WRITABLE 1
#define ONCHIP_MEMORY2_0_MEMORY_INFO_DAT_SYM_INSTALL_DIR SIM_DIR
#define ONCHIP_MEMORY2_0_MEMORY_INFO_GENERATE_DAT_SYM 1
#define ONCHIP_MEMORY2_0_MEMORY_INFO_GENERATE_HEX 1
#define ONCHIP_MEMORY2_0_MEMORY_INFO_HAS_BYTE_LANE 0
#define ONCHIP_MEMORY2_0_MEMORY_INFO_HEX_INSTALL_DIR QPF_DIR
#define ONCHIP_MEMORY2_0_MEMORY_INFO_MEM_INIT_DATA_WIDTH 64
#define ONCHIP_MEMORY2_0_MEMORY_INFO_MEM_INIT_FILENAME soc_system_onchip_memory2_0

/*
 * Macros for device 'sys_pll_reconfig', class 'altera_pll_reconfig'
 * The macros are prefixed with 'SYS_PLL_RECONFIG_'.
 * The prefix is the slave descriptor.
 */
#define SYS_PLL_RECONFIG_COMPONENT_TYPE altera_pll_reconfig
#define SYS_PLL_RECONFIG_COMPONENT_NAME sys_pll_reconfig
#define SYS_PLL_RECONFIG_BASE 0x0
#define SYS_PLL_RECONFIG_SPAN 256
#define SYS_PLL_RECONFIG_END 0xff

/*
 * Macros for device 'bitstr_fifo_in_csr', class 'altera_avalon_fifo'
 * The macros are prefixed with 'BITSTR_FIFO_IN_CSR_'.
 * The prefix is the slave descriptor.
 */
#define BITSTR_FIFO_IN_CSR_COMPONENT_TYPE altera_avalon_fifo
#define BITSTR_FIFO_IN_CSR_COMPONENT_NAME bitstr_fifo
#define BITSTR_FIFO_IN_CSR_BASE 0x100
#define BITSTR_FIFO_IN_CSR_SPAN 32
#define BITSTR_FIFO_IN_CSR_END 0x11f
#define BITSTR_FIFO_IN_CSR_AVALONMM_AVALONMM_DATA_WIDTH 32
#define BITSTR_FIFO_IN_CSR_AVALONMM_AVALONST_DATA_WIDTH 32
#define BITSTR_FIFO_IN_CSR_BITS_PER_SYMBOL 32
#define BITSTR_FIFO_IN_CSR_CHANNEL_WIDTH 0
#define BITSTR_FIFO_IN_CSR_ERROR_WIDTH 0
#define BITSTR_FIFO_IN_CSR_FIFO_DEPTH 128
#define BITSTR_FIFO_IN_CSR_SINGLE_CLOCK_MODE 0
#define BITSTR_FIFO_IN_CSR_SYMBOLS_PER_BEAT 1
#define BITSTR_FIFO_IN_CSR_USE_AVALONMM_READ_SLAVE 0
#define BITSTR_FIFO_IN_CSR_USE_AVALONMM_WRITE_SLAVE 1
#define BITSTR_FIFO_IN_CSR_USE_AVALONST_SINK 0
#define BITSTR_FIFO_IN_CSR_USE_AVALONST_SOURCE 1
#define BITSTR_FIFO_IN_CSR_USE_BACKPRESSURE 1
#define BITSTR_FIFO_IN_CSR_USE_IRQ 0
#define BITSTR_FIFO_IN_CSR_USE_PACKET 0
#define BITSTR_FIFO_IN_CSR_USE_READ_CONTROL 0
#define BITSTR_FIFO_IN_CSR_USE_REGISTER 0
#define BITSTR_FIFO_IN_CSR_USE_WRITE_CONTROL 1

/*
 * Macros for device 'cnt_in', class 'altera_avalon_pio'
 * The macros are prefixed with 'CNT_IN_'.
 * The prefix is the slave descriptor.
 */
#define CNT_IN_COMPONENT_TYPE altera_avalon_pio
#define CNT_IN_COMPONENT_NAME cnt_in
#define CNT_IN_BASE 0x120
#define CNT_IN_SPAN 16
#define CNT_IN_END 0x12f
#define CNT_IN_BIT_CLEARING_EDGE_REGISTER 0
#define CNT_IN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CNT_IN_CAPTURE 0
#define CNT_IN_DATA_WIDTH 32
#define CNT_IN_DO_TEST_BENCH_WIRING 0
#define CNT_IN_DRIVEN_SIM_VALUE 0
#define CNT_IN_EDGE_TYPE NONE
#define CNT_IN_FREQ 50000000
#define CNT_IN_HAS_IN 1
#define CNT_IN_HAS_OUT 0
#define CNT_IN_HAS_TRI 0
#define CNT_IN_IRQ_TYPE NONE
#define CNT_IN_RESET_VALUE 0

/*
 * Macros for device 'cnt_out', class 'altera_avalon_pio'
 * The macros are prefixed with 'CNT_OUT_'.
 * The prefix is the slave descriptor.
 */
#define CNT_OUT_COMPONENT_TYPE altera_avalon_pio
#define CNT_OUT_COMPONENT_NAME cnt_out
#define CNT_OUT_BASE 0x130
#define CNT_OUT_SPAN 16
#define CNT_OUT_END 0x13f
#define CNT_OUT_BIT_CLEARING_EDGE_REGISTER 0
#define CNT_OUT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CNT_OUT_CAPTURE 0
#define CNT_OUT_DATA_WIDTH 32
#define CNT_OUT_DO_TEST_BENCH_WIRING 0
#define CNT_OUT_DRIVEN_SIM_VALUE 0
#define CNT_OUT_EDGE_TYPE NONE
#define CNT_OUT_FREQ 50000000
#define CNT_OUT_HAS_IN 0
#define CNT_OUT_HAS_OUT 1
#define CNT_OUT_HAS_TRI 0
#define CNT_OUT_IRQ_TYPE NONE
#define CNT_OUT_RESET_VALUE 0

/*
 * Macros for device 'bitstr_fifo_in', class 'altera_avalon_fifo'
 * The macros are prefixed with 'BITSTR_FIFO_IN_'.
 * The prefix is the slave descriptor.
 */
#define BITSTR_FIFO_IN_COMPONENT_TYPE altera_avalon_fifo
#define BITSTR_FIFO_IN_COMPONENT_NAME bitstr_fifo
#define BITSTR_FIFO_IN_BASE 0x10000
#define BITSTR_FIFO_IN_SPAN 8
#define BITSTR_FIFO_IN_END 0x10007
#define BITSTR_FIFO_IN_AVALONMM_AVALONMM_DATA_WIDTH 32
#define BITSTR_FIFO_IN_AVALONMM_AVALONST_DATA_WIDTH 32
#define BITSTR_FIFO_IN_BITS_PER_SYMBOL 32
#define BITSTR_FIFO_IN_CHANNEL_WIDTH 0
#define BITSTR_FIFO_IN_ERROR_WIDTH 0
#define BITSTR_FIFO_IN_FIFO_DEPTH 128
#define BITSTR_FIFO_IN_SINGLE_CLOCK_MODE 0
#define BITSTR_FIFO_IN_SYMBOLS_PER_BEAT 1
#define BITSTR_FIFO_IN_USE_AVALONMM_READ_SLAVE 0
#define BITSTR_FIFO_IN_USE_AVALONMM_WRITE_SLAVE 1
#define BITSTR_FIFO_IN_USE_AVALONST_SINK 0
#define BITSTR_FIFO_IN_USE_AVALONST_SOURCE 1
#define BITSTR_FIFO_IN_USE_BACKPRESSURE 1
#define BITSTR_FIFO_IN_USE_IRQ 0
#define BITSTR_FIFO_IN_USE_PACKET 0
#define BITSTR_FIFO_IN_USE_READ_CONTROL 0
#define BITSTR_FIFO_IN_USE_REGISTER 0
#define BITSTR_FIFO_IN_USE_WRITE_CONTROL 1

/*
 * Macros for device 'sysid_qsys', class 'altera_avalon_sysid_qsys'
 * The macros are prefixed with 'SYSID_QSYS_'.
 * The prefix is the slave descriptor.
 */
#define SYSID_QSYS_COMPONENT_TYPE altera_avalon_sysid_qsys
#define SYSID_QSYS_COMPONENT_NAME sysid_qsys
#define SYSID_QSYS_BASE 0x10000
#define SYSID_QSYS_SPAN 8
#define SYSID_QSYS_END 0x10007
#define SYSID_QSYS_ID 2899645186
#define SYSID_QSYS_TIMESTAMP 1622132603

/*
 * Macros for device 'led_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'LED_PIO_'.
 * The prefix is the slave descriptor.
 */
#define LED_PIO_COMPONENT_TYPE altera_avalon_pio
#define LED_PIO_COMPONENT_NAME led_pio
#define LED_PIO_BASE 0x10040
#define LED_PIO_SPAN 16
#define LED_PIO_END 0x1004f
#define LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LED_PIO_CAPTURE 0
#define LED_PIO_DATA_WIDTH 10
#define LED_PIO_DO_TEST_BENCH_WIRING 0
#define LED_PIO_DRIVEN_SIM_VALUE 0
#define LED_PIO_EDGE_TYPE NONE
#define LED_PIO_FREQ 50000000
#define LED_PIO_HAS_IN 0
#define LED_PIO_HAS_OUT 1
#define LED_PIO_HAS_TRI 0
#define LED_PIO_IRQ_TYPE NONE
#define LED_PIO_RESET_VALUE 15

/*
 * Macros for device 'dipsw_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'DIPSW_PIO_'.
 * The prefix is the slave descriptor.
 */
#define DIPSW_PIO_COMPONENT_TYPE altera_avalon_pio
#define DIPSW_PIO_COMPONENT_NAME dipsw_pio
#define DIPSW_PIO_BASE 0x10080
#define DIPSW_PIO_SPAN 16
#define DIPSW_PIO_END 0x1008f
#define DIPSW_PIO_IRQ 0
#define DIPSW_PIO_BIT_CLEARING_EDGE_REGISTER 1
#define DIPSW_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIPSW_PIO_CAPTURE 1
#define DIPSW_PIO_DATA_WIDTH 10
#define DIPSW_PIO_DO_TEST_BENCH_WIRING 0
#define DIPSW_PIO_DRIVEN_SIM_VALUE 0
#define DIPSW_PIO_EDGE_TYPE ANY
#define DIPSW_PIO_FREQ 50000000
#define DIPSW_PIO_HAS_IN 1
#define DIPSW_PIO_HAS_OUT 0
#define DIPSW_PIO_HAS_TRI 0
#define DIPSW_PIO_IRQ_TYPE EDGE
#define DIPSW_PIO_RESET_VALUE 0

/*
 * Macros for device 'button_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'BUTTON_PIO_'.
 * The prefix is the slave descriptor.
 */
#define BUTTON_PIO_COMPONENT_TYPE altera_avalon_pio
#define BUTTON_PIO_COMPONENT_NAME button_pio
#define BUTTON_PIO_BASE 0x100c0
#define BUTTON_PIO_SPAN 16
#define BUTTON_PIO_END 0x100cf
#define BUTTON_PIO_IRQ 1
#define BUTTON_PIO_BIT_CLEARING_EDGE_REGISTER 1
#define BUTTON_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BUTTON_PIO_CAPTURE 1
#define BUTTON_PIO_DATA_WIDTH 4
#define BUTTON_PIO_DO_TEST_BENCH_WIRING 0
#define BUTTON_PIO_DRIVEN_SIM_VALUE 0
#define BUTTON_PIO_EDGE_TYPE FALLING
#define BUTTON_PIO_FREQ 50000000
#define BUTTON_PIO_HAS_IN 1
#define BUTTON_PIO_HAS_OUT 0
#define BUTTON_PIO_HAS_TRI 0
#define BUTTON_PIO_IRQ_TYPE EDGE
#define BUTTON_PIO_RESET_VALUE 0

/*
 * Macros for device 'jtag_uart', class 'altera_avalon_jtag_uart'
 * The macros are prefixed with 'JTAG_UART_'.
 * The prefix is the slave descriptor.
 */
#define JTAG_UART_COMPONENT_TYPE altera_avalon_jtag_uart
#define JTAG_UART_COMPONENT_NAME jtag_uart
#define JTAG_UART_BASE 0x20000
#define JTAG_UART_SPAN 8
#define JTAG_UART_END 0x20007
#define JTAG_UART_IRQ 2
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


#endif /* _ALTERA_HPS_SOC_SYSTEM_H_ */