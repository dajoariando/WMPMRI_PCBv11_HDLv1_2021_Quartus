onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /NMR_bstrm_simp_cnt_tb/RST
add wave -noupdate /NMR_bstrm_simp_cnt_tb/START
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DONE
add wave -noupdate /NMR_bstrm_simp_cnt_tb/OUT
add wave -noupdate -radix decimal /NMR_bstrm_simp_cnt_tb/SRAM_ADDR
add wave -noupdate /NMR_bstrm_simp_cnt_tb/SRAM_CS
add wave -noupdate -radix hexadecimal /NMR_bstrm_simp_cnt_tb/SRAM_RD_DAT
add wave -noupdate /NMR_bstrm_simp_cnt_tb/CLK
add wave -noupdate -radix hexadecimal /NMR_bstrm_simp_cnt_tb/DUT/State
add wave -noupdate -radix decimal /NMR_bstrm_simp_cnt_tb/DUT/cmd_ctr
add wave -noupdate -radix decimal /NMR_bstrm_simp_cnt_tb/DUT/loop_ctr
add wave -noupdate -radix decimal /NMR_bstrm_simp_cnt_tb/DUT/loop_sta_addr
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/loop_sta_reg
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/loop_sto_reg
add wave -noupdate -divider Datapath
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/START
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/DPATH_RDY
add wave -noupdate -radix decimal -childformat {{{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[23]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[22]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[21]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[20]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[19]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[18]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[17]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[16]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[15]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[14]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[13]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[12]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[11]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[10]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[9]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[8]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[7]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[6]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[5]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[4]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[3]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[2]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[1]} -radix decimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[0]} -radix decimal}} -subitemconfig {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[23]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[22]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[21]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[20]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[19]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[18]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[17]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[16]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[15]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[14]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[13]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[12]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[11]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[10]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[9]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[8]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[7]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[6]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[5]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[4]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[3]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[2]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[1]} {-height 15 -radix decimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data[0]} {-height 15 -radix decimal}} /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/data
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/PLS_POL
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/mux_sel
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/mux_in
add wave -noupdate -color Gold /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/OUT
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/CLK
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/RST
add wave -noupdate -color Violet -radix hexadecimal {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[24]}
add wave -noupdate -radix hexadecimal -childformat {{{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[24]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[23]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[22]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[21]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[20]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[19]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[18]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[17]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[16]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[15]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[14]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[13]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[12]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[11]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[10]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[9]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[8]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[7]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[6]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[5]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[4]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[3]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[2]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[1]} -radix hexadecimal} {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[0]} -radix hexadecimal}} -subitemconfig {{/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[24]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[23]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[22]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[21]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[20]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[19]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[18]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[17]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[16]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[15]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[14]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[13]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[12]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[11]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[10]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[9]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[8]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[7]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[6]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[5]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[4]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[3]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[2]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[1]} {-height 15 -radix hexadecimal} {/NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg[0]} {-height 15 -radix hexadecimal}} /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/cnt_reg
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/mux_sel_reg
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/PLS_POL_REG
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/OUTBUF
add wave -noupdate -radix hexadecimal /NMR_bstrm_simp_cnt_tb/DUT/NMR_bstrm_simp_dpath_1/State
add wave -noupdate -divider SRAM
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/sram1/START
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/sram1/SYS_RDY
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/sram1/DATA_RDY
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/sram1/SRAM_CS
add wave -noupdate -radix hexadecimal /NMR_bstrm_simp_cnt_tb/DUT/sram1/SRAM_RD_DAT
add wave -noupdate -radix hexadecimal /NMR_bstrm_simp_cnt_tb/DUT/sram1/data_reg
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/sram1/CLK
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/sram1/RST
add wave -noupdate /NMR_bstrm_simp_cnt_tb/DUT/sram1/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {27744526 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 449
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {63 us}
