addi $t2,$zero,5
addi $t3,$zero,4
addi $t4, $zero,7
add $t0, $t2, $t3
mul $t0,$t1,$t2
addu $t0 ,$t2 ,$t3
andi $t0, $t2 ,0x000F
nor $t0, $t2, $t3
or $t0, $t2, $t3
ori $t0, $t2, 0x000F
sll $t0, $t2,0x00F
sllv $t0,$t2, $t3
sra $t0, $t2, 12
srav $t0, $t2 $t3
srl $t0 ,$t2,12
srlv $t0 ,$t2 ,$t3
sub $t0 ,$t2 ,$t3
subu $t0, $t2, $t3
xor $t0 ,$t2 ,$t3
slt $t0 ,$t2,$t3
sltu $t0,$t2,$t3
slti $t0,$t2,0x000F
sltiu $t0,$t2, 0x000F
beq $t0,$t2,L1
bgtz $t0, L2
beq $t0,$t2,L3
bgez $t0, L3
blez $t0,L4
bne $t0, $t2 ,L5
bgezal $t0,L6
bltzal $t0,L7
j L8
jal L9
jalr $t0 $t2
jr $t0
lb $t1 ,100
lbu $t2, 100
lh $t3, 100
lhu $t4, -100
lw $t5, -100
sb $t6,100
sh $t7, 100
sw $t8, 100
lui $t9 0x0064
mul $t0,$t1,$t2

L1: and $t4, $t3,$t2

L2: add $t5, $t2,$t3

L3: sub $t6, $t3,$t2

L4: add $t7, $t3,$t2

L5: mul $t8 , $t3,$t2

L6: subu $t6, $t3,$t2

L7: addiu $s0, $t2,100

L8: addu $s1, $t2,$t3

L9 : add $s4, $t2,$t4
