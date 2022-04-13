onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Datapath
add wave -noupdate /NMR_bstrm_simp_dpath_tb/START
add wave -noupdate /NMR_bstrm_simp_dpath_tb/DPATH_RDY
add wave -noupdate -radix decimal /NMR_bstrm_simp_dpath_tb/data
add wave -noupdate /NMR_bstrm_simp_dpath_tb/PLS_POL
add wave -noupdate -radix decimal /NMR_bstrm_simp_dpath_tb/mux_sel
add wave -noupdate -radix decimal /NMR_bstrm_simp_dpath_tb/mux_in
add wave -noupdate -color Red /NMR_bstrm_simp_dpath_tb/OUT
add wave -noupdate /NMR_bstrm_simp_dpath_tb/CLK
add wave -noupdate /NMR_bstrm_simp_dpath_tb/RST
add wave -noupdate -radix hexadecimal /NMR_bstrm_simp_dpath_tb/DUT/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1907543 ps} 0}
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
WaveRestoreZoom {0 ps} {21 us}
