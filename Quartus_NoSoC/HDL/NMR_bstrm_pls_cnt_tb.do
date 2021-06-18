onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Constants
add wave -noupdate /NMR_bstrm_pls_cnt_tb/SRAM_BYTEEN
add wave -noupdate -radix hexadecimal /NMR_bstrm_pls_cnt_tb/SRAM_WR_DAT
add wave -noupdate /NMR_bstrm_pls_cnt_tb/DUT/START
add wave -noupdate /NMR_bstrm_pls_cnt_tb/DONE
add wave -noupdate -divider {Control Signals}
add wave -noupdate /NMR_bstrm_pls_cnt_tb/CLK
add wave -noupdate /NMR_bstrm_pls_cnt_tb/RST
add wave -noupdate -radix unsigned /NMR_bstrm_pls_cnt_tb/SRAM_ADDR
add wave -noupdate -radix hexadecimal /NMR_bstrm_pls_cnt_tb/SRAM_RD_DAT
add wave -noupdate /NMR_bstrm_pls_cnt_tb/SRAM_CS
add wave -noupdate /NMR_bstrm_pls_cnt_tb/SRAM_CLKEN
add wave -noupdate /NMR_bstrm_pls_cnt_tb/SRAM_WR
add wave -noupdate /NMR_bstrm_pls_cnt_tb/BT_START
add wave -noupdate /NMR_bstrm_pls_cnt_tb/BT_DONE
add wave -noupdate -radix hexadecimal /NMR_bstrm_pls_cnt_tb/DUT/State
add wave -noupdate -radix unsigned /NMR_bstrm_pls_cnt_tb/idly_reg
add wave -noupdate -radix unsigned /NMR_bstrm_pls_cnt_tb/pls_reg
add wave -noupdate -radix unsigned /NMR_bstrm_pls_cnt_tb/edly_reg
add wave -noupdate /NMR_bstrm_pls_cnt_tb/DUT/loop_sta_reg
add wave -noupdate /NMR_bstrm_pls_cnt_tb/DUT/loop_sto_reg
add wave -noupdate /NMR_bstrm_pls_cnt_tb/DUT/seq_end_reg
add wave -noupdate -radix hexadecimal /NMR_bstrm_pls_cnt_tb/DUT/loop_ctr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10039929 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 282
configure wave -valuecolwidth 175
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
WaveRestoreZoom {0 ps} {31500 ns}
