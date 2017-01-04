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
nop
nop
nop
nop
nop

       lw   $t0, 0($a0)
nop
nop
nop
nop
nop
       addi $t1, $t0, -1
nop
nop
nop
nop
nop
outer: addi $t2, $zero , 0
nop
nop
nop
nop
nop
inner: addi $t3, $t2 , 1
nop
nop
nop
nop
nop
       sll  $t3, $t3, 2
nop
nop
nop
nop
nop
       add  $t3, $t3, $a0
nop
nop
nop
nop
nop
       lw   $t4, 0($t3)
nop
nop
nop
nop
nop
       addi $t7, $t2, 2
nop
nop
nop
nop
nop
       sll  $t7, $t7, 2
nop
nop
nop
nop
nop
       add  $t7, $t7, $a0
nop
nop
nop
nop
nop
       lw   $t5, 0($t7)
nop
nop
nop
nop
nop
       slt  $t6, $t5, $t4 
nop
nop
nop
nop
nop
       beq  $t6, $zero, no_sw
nop
nop
nop
nop
nop
       sw   $t5, 0($t3)
nop
nop
nop
nop
nop
       sw   $t4, 0($t7)
nop
nop
nop
nop
nop
no_sw: addi $t2, $t2, 1
nop
nop
nop
nop
nop
       bne  $t2, $t1, inner
nop
nop
nop
nop
nop
       addi $t1, $t1, -1
nop
nop
nop
nop
nop
       bgtz $t1, outer
nop
nop
nop
nop
nop


lw $zero 4($a0)
nop
nop
nop
nop
nop
lw $zero 8($a0)
nop
nop
nop
nop
nop
lw $zero 12($a0)
nop
nop
nop
nop
nop
lw $zero 16($a0)
nop
nop
nop
nop
nop
lw $zero 20($a0)
nop
nop
nop
nop
nop
lw $zero 24($a0)
nop
nop
nop
nop
nop
lw $zero 28($a0)
nop
nop
nop
nop
nop
lw $zero 32($a0)
nop
nop
nop
nop
nop
lw $zero 36($a0)
nop
nop
nop
nop
nop
lw $zero 40($a0)