.data
startmem:
.word 10
.word 84
.word 85
.word 36
.word 68
.word 98
.word 53
.word 67
.word 20
.word 54
.word 15
.text
.globl main
# main:  addi $a0, $zero, 0x1001
#        sll  $a0, $a0, 16
main:  add  $a0, $zero, $zero
       lw   $t0, 0($a0)
       addi $t1, $t0, -1
outer: addi $t2, $zero , 0
inner: addi $t3, $t2 , 1
       sll  $t3, $t3, 2
       add  $t3, $t3, $a0
       lw   $t4, 0($t3)
       addi $t7, $t2, 2
       sll  $t7, $t7, 2
       add  $t7, $t7, $a0
       lw   $t5, 0($t7)
       slt  $t6, $t5, $t4 
       beq  $t6, $zero, no_sw
       sw   $t5, 0($t3)
       sw   $t4, 0($t7)
no_sw: addi $t2, $t2, 1
       bne  $t2, $t1, inner
       addi $t1, $t1, -1
       bgtz $t1, outer

lw $zero 4($a0)
lw $zero 8($a0)
lw $zero 12($a0)
lw $zero 16($a0)
lw $zero 20($a0)
lw $zero 24($a0)
lw $zero 28($a0)
lw $zero 32($a0)
lw $zero 36($a0)
lw $zero 40($a0)
