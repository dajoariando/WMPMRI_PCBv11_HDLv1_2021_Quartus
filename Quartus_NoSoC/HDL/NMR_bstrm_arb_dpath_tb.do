onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /NMR_bstrm_arb_cnt_tb/START
add wave -noupdate /NMR_bstrm_arb_cnt_tb/RST
add wave -noupdate /NMR_bstrm_arb_cnt_tb/DONE
add wave -noupdate -divider {SRAM access}
add wave -noupdate -radix unsigned /NMR_bstrm_arb_cnt_tb/SRAM_ADDR
add wave -noupdate /NMR_bstrm_arb_cnt_tb/SRAM_CS
add wave -noupdate /NMR_bstrm_arb_cnt_tb/SRAM_CLKEN
add wave -noupdate /NMR_bstrm_arb_cnt_tb/SRAM_WR
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_cnt_tb/SRAM_RD_DAT
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_cnt_tb/SRAM_WR_DAT
add wave -noupdate /NMR_bstrm_arb_cnt_tb/SRAM_BYTEEN
add wave -noupdate -divider {Parsed data}
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_cnt_tb/DUT/loop_ctr
add wave -noupdate /NMR_bstrm_arb_cnt_tb/end_of_seq
add wave -noupdate /NMR_bstrm_arb_cnt_tb/loop_sta
add wave -noupdate /NMR_bstrm_arb_cnt_tb/loop_sto
add wave -noupdate /NMR_bstrm_arb_cnt_tb/pattern_mode
add wave -noupdate /NMR_bstrm_arb_cnt_tb/all_1s
add wave -noupdate /NMR_bstrm_arb_cnt_tb/all_0s
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_cnt_tb/data_reg
add wave -noupdate /NMR_bstrm_arb_cnt_tb/CLK
add wave -noupdate -divider {To bitstream FSM}
add wave -noupdate /NMR_bstrm_arb_cnt_tb/BST_START
add wave -noupdate /NMR_bstrm_arb_cnt_tb/BST_DONE
add wave -noupdate /NMR_bstrm_arb_cnt_tb/out_data_reg
add wave -noupdate /NMR_bstrm_arb_cnt_tb/out_loop_sta_reg
add wave -noupdate /NMR_bstrm_arb_cnt_tb/out_loop_sto_reg
add wave -noupdate /NMR_bstrm_arb_cnt_tb/out_seq_end_reg
add wave -noupdate /NMR_bstrm_arb_cnt_tb/out_pattern_mode_reg
add wave -noupdate /NMR_bstrm_arb_cnt_tb/out_all_1s_mode_reg
add wave -noupdate /NMR_bstrm_arb_cnt_tb/out_all_0s_mode_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3175610 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 337
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
WaveRestoreZoom {0 ps} {21 us}
