onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_pipereg/s_instMem
add wave -noupdate -radix hexadecimal /tb_pipereg/s_o_instMem
add wave -noupdate -radix hexadecimal /tb_pipereg/s_IDEX_o_instMem
add wave -noupdate -radix hexadecimal /tb_pipereg/s_ExMem_o_instMem
add wave -noupdate -radix hexadecimal /tb_pipereg/s_MemWB_o_instMem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 315
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1985 ns}
