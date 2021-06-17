onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Constants
add wave -noupdate /NMR_bstrm_tb/SRAM_BYTEEN
add wave -noupdate /NMR_bstrm_tb/timescale_ref
add wave -noupdate /NMR_bstrm_tb/CLK_RATE_HZ
add wave -noupdate /NMR_bstrm_tb/clockticks
add wave -noupdate -divider {SRAM access}
add wave -noupdate -radix unsigned /NMR_bstrm_tb/SRAM_ADDR
add wave -noupdate /NMR_bstrm_tb/SRAM_CS
add wave -noupdate /NMR_bstrm_tb/SRAM_CLKEN
add wave -noupdate /NMR_bstrm_tb/SRAM_WR
add wave -noupdate -radix hexadecimal /NMR_bstrm_tb/SRAM_RD_DAT
add wave -noupdate -radix hexadecimal /NMR_bstrm_tb/SRAM_WR_DAT
add wave -noupdate -divider Control
add wave -noupdate /NMR_bstrm_tb/START
add wave -noupdate /NMR_bstrm_tb/DONE
add wave -noupdate /NMR_bstrm_tb/OUT
add wave -noupdate /NMR_bstrm_tb/CLK
add wave -noupdate /NMR_bstrm_tb/RST
add wave -noupdate -radix hexadecimal /NMR_bstrm_tb/DUT/cnt_str1/State
add wave -noupdate -divider {Bistreamer signal}
add wave -noupdate /NMR_bstrm_tb/DUT/BT_START
add wave -noupdate /NMR_bstrm_tb/DUT/BT_DONE
add wave -noupdate -radix hexadecimal /NMR_bstrm_tb/DUT/idly
add wave -noupdate -radix hexadecimal /NMR_bstrm_tb/DUT/pls
add wave -noupdate -radix hexadecimal /NMR_bstrm_tb/DUT/edly
add wave -noupdate -radix hexadecimal /NMR_bstrm_tb/DUT/dpath_str1/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18837766 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 221
configure wave -valuecolwidth 335
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
