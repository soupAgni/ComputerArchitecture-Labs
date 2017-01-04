addi $t2,$zero,5
nop
nop
nop
nop
nop
addi $t3,$zero,4
nop
nop
nop
nop
nop
addi $t4, $zero,7
nop
nop
nop
nop
nop
add $t0, $t2, $t3
nop
nop
nop
nop
nop
mul $t0,$t1,$t2
nop
nop
nop
nop
nop
addu $t0 ,$t2 ,$t3
nop
nop
nop
nop
nop
andi $t0, $t2 ,0x000F
nop
nop
nop
nop
nop
nor $t0, $t2, $t3
nop
nop
nop
nop
nop
or $t0, $t2, $t3
nop
nop
nop
nop
nop
nop
ori $t0, $t2, 0x000F
nop
nop
nop
nop
nop
sll $t0, $t2,0x00F
nop
nop
nop
nop
nop
sllv $t0,$t2, $t3
nop
nop
nop
nop
nop
sra $t0, $t2, 12
nop
nop
nop
nop
nop
srav $t0, $t2 $t3
nop
nop
nop
nop
nop
srl $t0 ,$t2,12
nop
nop
nop
nop
nop
srlv $t0 ,$t2 ,$t3
nop
nop
nop
nop
nop
sub $t0 ,$t2 ,$t3
nop
nop
nop
nop
nop
subu $t0, $t2, $t3
nop
nop
nop
nop
nop
xor $t0 ,$t2 ,$t3
nop
nop
nop
nop
nop
slt $t0 ,$t2,$t3
nop
nop
nop
nop
nop
sltu $t0,$t2,$t3
nop
nop
nop
nop
nop
slti $t0,$t2,0x000F
nop
nop
nop
nop
nop
sltiu $t0,$t2, 0x000F
nop
nop
nop
nop
nop
beq $t0,$t2,L1
nop
nop
nop
nop
nop
bgtz $t0, L2
nop
nop
nop
nop
nop
beq $t0,$t2,L3
nop
nop
nop
nop
nop
bgez $t0, L3
nop
nop
nop
nop
nop
blez $t0,L4
nop
nop
nop
nop
nop
bne $t0, $t2 ,L5
nop
nop
nop
nop
nop
bgezal $t0,L6
nop
nop
nop
nop
nop
bltzal $t0,L7
nop
nop
nop
nop
nop
j L8
nop
nop
nop
nop
nop
jal L9
nop
nop
nop
nop
nop
jalr $t0 $t2
nop
nop
nop
nop
nop
jr $t0
nop
nop
nop
nop
nop
lb $t1 ,100
nop
nop
nop
nop
nop
lbu $t2, 100
nop
nop
nop
nop
nop
lh $t3, 100
nop
nop
nop
nop
nop
lhu $t4, -100
nop
nop
nop
nop
nop
lw $t5, -100
nop
nop
nop
nop
nop
sb $t6,100
nop
nop
nop
nop
nop
sh $t7, 100
nop
nop
nop
nop
nop
sw $t8, 100
nop
nop
nop
nop
nop
lui $t9 0x0064
nop
nop
nop
nop
nop
mul $t0,$t1,$t2
nop
nop
nop
nop
nop
L1: and $t4, $t3,$t2
nop
nop
nop
nop
nop
L2: add $t5, $t2,$t3
nop
nop
nop
nop
nop
L3: sub $t6, $t3,$t2
nop
nop
nop
nop
nop
L4: add $t7, $t3,$t2
nop
nop
nop
nop
nop
L5: mul $t8 , $t3,$t2
nop
nop
nop
nop
nop
L6: subu $t6, $t3,$t2
nop
nop
nop
nop
nop
L7: addiu $s0, $t2,100
nop
nop
nop
nop
nop
L8: addu $s1, $t2,$t3
nop
nop
nop
nop
nop
L9 : add $s4, $t2,$t4
