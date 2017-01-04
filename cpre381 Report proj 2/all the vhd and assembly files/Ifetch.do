onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_reset
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_readData1
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_instr_25to0
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_immVal
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_clock
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_PC_Val_final
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_JumpOp
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_JR
add wave -noupdate -radix hexadecimal /tb_instructionfetch/s_BranchOp
add wave -noupdate -radix hexadecimal /tb_instructionfetch/gCLK_HPER
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {1 us}
