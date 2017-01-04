onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_32bit_p2/A
add wave -noupdate /alu_32bit_p2/Ainvert
add wave -noupdate /alu_32bit_p2/B
add wave -noupdate /alu_32bit_p2/Binvert
add wave -noupdate /alu_32bit_p2/Carry_out
add wave -noupdate /alu_32bit_p2/Cin
add wave -noupdate /alu_32bit_p2/N
add wave -noupdate /alu_32bit_p2/Op
add wave -noupdate /alu_32bit_p2/Overflow
add wave -noupdate /alu_32bit_p2/Result
add wave -noupdate -divider int
add wave -noupdate /alu_32bit_p2/Zero
add wave -noupdate /alu_32bit_p2/s_Carry_out
add wave -noupdate /alu_32bit_p2/s_Overflow
add wave -noupdate /alu_32bit_p2/s_Result
add wave -noupdate /alu_32bit_p2/s_Set
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 194
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
WaveRestoreZoom {0 ns} {926 ns}
