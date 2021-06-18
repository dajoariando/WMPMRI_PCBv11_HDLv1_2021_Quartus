onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /NMR_bstrm_fifo_tb/BUS_WIDTH
add wave -noupdate /NMR_bstrm_fifo_tb/CLK
add wave -noupdate /NMR_bstrm_fifo_tb/RST
add wave -noupdate /NMR_bstrm_fifo_tb/START
add wave -noupdate /NMR_bstrm_fifo_tb/READY
add wave -noupdate -radix unsigned -childformat {{{/NMR_bstrm_fifo_tb/bitstr_in[31]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[30]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[29]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[28]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[27]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[26]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[25]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[24]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[23]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[22]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[21]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[20]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[19]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[18]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[17]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[16]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[15]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[14]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[13]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[12]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[11]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[10]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[9]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[8]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[7]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[6]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[5]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[4]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[3]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[2]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[1]} -radix unsigned} {{/NMR_bstrm_fifo_tb/bitstr_in[0]} -radix unsigned}} -subitemconfig {{/NMR_bstrm_fifo_tb/bitstr_in[31]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[30]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[29]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[28]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[27]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[26]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[25]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[24]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[23]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[22]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[21]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[20]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[19]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[18]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[17]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[16]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[15]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[14]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[13]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[12]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[11]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[10]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[9]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[8]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[7]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[6]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[5]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[4]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[3]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[2]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[1]} {-height 15 -radix unsigned} {/NMR_bstrm_fifo_tb/bitstr_in[0]} {-height 15 -radix unsigned}} /NMR_bstrm_fifo_tb/bitstr_in
add wave -noupdate -radix unsigned /NMR_bstrm_fifo_tb/bitstr_out
add wave -noupdate -radix unsigned {/NMR_bstrm_fifo_tb/bitstr_in[31]}
add wave -noupdate -radix hexadecimal /NMR_bstrm_fifo_tb/DUT/State
add wave -noupdate /NMR_bstrm_fifo_tb/DUT/LOAD
add wave -noupdate /NMR_bstrm_fifo_tb/DUT/d_end
add wave -noupdate /NMR_bstrm_fifo_tb/STOP
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2420873 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 306
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
WaveRestoreZoom {0 ps} {10500 ns}
