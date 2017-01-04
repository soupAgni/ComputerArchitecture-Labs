addi $t3,$zero,2
addi  $t6,$zero,-100
addi  $t5,$zero,35
add $t1, $t6,$t3
sw   $t1,($t2)
lw   $t1, ($t2)
addu $t6, $t3,$t5
sll  $t4, $t6,10
srl  $t3, $t4,20
bne  $t3,$zero,L1
j L2
L1:subu $t3,$t3,1
j L3

 L2:
sw $t4,($s7)


L3 : bgtz $t4, L4
srlv $t6,$t1,$t2

L4:
blez $t3, L5
add  $t2, $t5,$t3
subu $t4,$t4,$t2

L5:
sra $t6,$t5,10
