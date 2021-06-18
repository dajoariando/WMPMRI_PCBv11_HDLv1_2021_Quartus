onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Control
add wave -noupdate /NMR_bstrm_arb_top_tb/START
add wave -noupdate /NMR_bstrm_arb_top_tb/RST
add wave -noupdate /NMR_bstrm_arb_top_tb/DONE
add wave -noupdate -divider {SRAM access}
add wave -noupdate -radix unsigned /NMR_bstrm_arb_top_tb/SRAM_ADDR
add wave -noupdate /NMR_bstrm_arb_top_tb/SRAM_CS
add wave -noupdate /NMR_bstrm_arb_top_tb/SRAM_CLKEN
add wave -noupdate /NMR_bstrm_arb_top_tb/SRAM_WR
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/SRAM_RD_DAT
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/SRAM_WR_DAT
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/SRAM_BYTEEN
add wave -noupdate -divider Output
add wave -noupdate /NMR_bstrm_arb_top_tb/CLK
add wave -noupdate /NMR_bstrm_arb_top_tb/OUT
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/data_reg
add wave -noupdate -divider Flags
add wave -noupdate /NMR_bstrm_arb_top_tb/end_of_seq
add wave -noupdate /NMR_bstrm_arb_top_tb/loop_sta
add wave -noupdate /NMR_bstrm_arb_top_tb/loop_sto
add wave -noupdate /NMR_bstrm_arb_top_tb/pattern_mode
add wave -noupdate /NMR_bstrm_arb_top_tb/all_1s
add wave -noupdate /NMR_bstrm_arb_top_tb/all_0s
add wave -noupdate -divider CNT
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/START
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/DONE
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/CLK
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/RST
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/loop_sta_reg
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/loop_sto_reg
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/seq_end_reg
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/pattern_mode_reg
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/all_1s_mode_reg
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/all_0s_mode_reg
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/data_reg
add wave -noupdate -radix unsigned /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/cmd_ctr
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/loop_ctr
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/loop_sta_addr
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_cnt1/State
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/DPATH_BUF_RDY
add wave -noupdate -divider DPATH
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/START
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/DONE
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/data
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/pattern_mode
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/all_1_mode
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/all_0_mode
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/end_of_sequence
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/OUT
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/CLK
add wave -noupdate /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/RST
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/stream_reg
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/counter_reg
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/str_counter_reg
add wave -noupdate -radix hexadecimal /NMR_bstrm_arb_top_tb/DUT/NMR_bstrm_arb_dpath1/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {92452278 ps} 0} {{Cursor 2} {46781399 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 425
configure wave -valuecolwidth 64
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
WaveRestoreZoom {0 ps} {94500 ns}
