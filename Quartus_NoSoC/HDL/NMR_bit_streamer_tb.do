onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /NMR_bit_streamer_tb/RST
add wave -noupdate /NMR_bit_streamer_tb/CLK
add wave -noupdate /NMR_bit_streamer_tb/START
add wave -noupdate /NMR_bit_streamer_tb/DONE
add wave -noupdate /NMR_bit_streamer_tb/bitstr_code
add wave -noupdate /NMR_bit_streamer_tb/OUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99999273 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 279
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
WaveRestoreZoom {0 ps} {96649199 ps}
