onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /NMR_bstrm_simp_dpath_tb/data
add wave -noupdate -radix hexadecimal /NMR_bstrm_simp_dpath_tb/mux_sel
add wave -noupdate -radix hexadecimal /NMR_bstrm_simp_dpath_tb/mux_in
add wave -noupdate /NMR_bstrm_simp_dpath_tb/CLK
add wave -noupdate /NMR_bstrm_simp_dpath_tb/RST
add wave -noupdate /NMR_bstrm_simp_dpath_tb/START
add wave -noupdate /NMR_bstrm_simp_dpath_tb/DPATH_RDY
add wave -noupdate /NMR_bstrm_simp_dpath_tb/DONE
add wave -noupdate /NMR_bstrm_simp_dpath_tb/PLS_POL
add wave -noupdate /NMR_bstrm_simp_dpath_tb/OUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {814655 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
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
WaveRestoreZoom {0 ps} {4701868 ps}
