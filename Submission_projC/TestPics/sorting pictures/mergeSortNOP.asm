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

main:



addi $a0, $zero, 0x1001

sll $a0, $a0, 16

         

lw    $t0 , 0($a0)	     # n = mem[0]



addi  $a1, $t0, 1

sll  $a1 , $a1, 2

add  $a1 , $a0, $a1        # start temparr at mem[n + 1]

addi $a0, $a0, 4



addi  $t1 , $zero, 1         # i = 1

outer_loop:		     # start loop



addi $t3 , $zero, 0          #int j = 0 ($t3)



inner_loop:



add $t5 , $t3  , $zero        #index1 = j ($t5)

add $t6 , $t5  , $t1          #end1 = index1 + i ($t6) 

add $t7 , $zero, $t6          #index2 = end1 ($t7)

add $t8 , $t7  , $t1

slt $t9 , $t0  , $t8

beq $t9 , $zero, no_use_length 

add $t8 , $t0  , $zero

no_use_length:               #end2 = min(arr.length, index2 + i) ($t8)



add $s0 , $t5  , $zero       # indextotal = index1 ($s0)



merge_loop_main:

slt $s1 , $t5   , $t6

slt $s2 , $t7   , $t8

and $s3 , $s1   , $s2

beq $s3 , $zero , merge_loop_main_done  # while(index1 < end1 && index2 < end2)





sll  $s4 , $t5 , 2

add  $s4 , $s4 , $a0

lw   $s4 , 4($s4)            # $s4 = arr[index1]



sll  $s5 , $t7 , 2

add  $s5 , $s5 , $a0

lw   $s5 , 4($s5)            # $s5 = arr[index2]



sll  $s7 , $s0 , 2

add  $s7 , $a1 , $s7         # $s7 = location of temparr[totalindex]



slt  $s6 , $s4   , $s5

beq  $s6 , $zero , get_from_index2



sw   $s4 , 0($s7)            # temparr[totalindex] = arr[index1]

addi $t5 , $t5 , 1           # index1++

j    done_with_get



get_from_index2:

sw   $s5 , 0($s7)            # temparr[totalindex] = arr[index2]

addi $t7 , $t7 , 1           # index2++



done_with_get:

addi $s0 , $s0 , 1           # totalindex++



j merge_loop_main







merge_loop_main_done:





merge_loop_index1:

slt $s1 , $t5   , $t6

slt $s2 , $s0   , $t8

and $s2 , $s1   , $s2

beq $s2 , $zero , merge_loop_index1_done # while(index1 < end1 && totalindex < end2)



sll  $s4 , $s0 , 2

add  $s4 , $a1 , $s4                     # $s4 = location of temparr[totalindex]



sll  $s5 , $t5 , 2

add  $s5 , $s5 , $a0

lw   $s5 , 4($s5)                        # $s5 = arr[index1]



sw   $s5 , 0($s4)



addi $t5 , $t5, 1                        #index1++

addi $s0 , $s0, 1                        #totalindex++



j merge_loop_index1

merge_loop_index1_done:



merge_loop_index2:

slt $s1 , $t7   , $t8

slt $s2 , $s0   , $t8

and $s2 , $s1   , $s2

beq $s2 , $zero , merge_loop_index2_done # while(index1 < end1 && totalindex < end2)



sll  $s4 , $s0 , 2

add  $s4 , $a1 , $s4                     # $s4 = location of temparr[totalindex]



sll  $s5 , $t7 , 2

add  $s5 , $s5 , $a0

lw   $s5 , 4($s5)                        # $s5 = arr[index2]



sw   $s5 , 0($s4)



addi $t7 , $t7, 1                        #index2++

addi $s0 , $s0, 1                        #totalindex++



j merge_loop_index2

merge_loop_index2_done:





add   $t3 , $t3 , $t1

add   $t3 , $t3 , $t1          # j += i * 2

slt   $t4 , $t3 , $t0

bne   $t4 , $zero, inner_loop  # while(j < n)



addi  $t3 , $zero, 0           # int k = 0

copy_loop:



sll  $t4 , $t3 , 2

add  $t5 , $t4 , $a0

add  $t6 , $t4 , $a1
nop
nop
nop
nop
nop
lw   $t7 , 0($t6)
nop
nop
nop
nop
nop

sw   $t7 , 4($t5)
nop
nop
nop
nop
nop

addi $t3 , $t3 , 1
nop
nop
nop
nop
nop

slt  $t6 , $t3 , $t0
nop
nop
nop
nop
nop

bne  $t6 , $zero, copy_loop
nop
nop
nop
nop
nop




sll   $t1 , $t1   , 1        # i = i << 1
nop
nop
nop
nop
nop

slt   $t2 , $t1   , $t0
nop
nop
nop
nop
nop

bne   $t2 , $zero ,  outer_loop       # while(i < n)

nop
nop
nop
nop
nop




lw $zero, 4($a0)

nop
nop
nop
nop
nop
lw $zero, 8($a0)
nop
nop
nop
nop
nop

lw $zero, 12($a0)
nop
nop
nop
nop
nop

lw $zero, 16($a0)
nop
nop
nop
nop
nop

lw $zero, 20($a0)
nop
nop
nop
nop
nop

lw $zero, 24($a0)
nop
nop
nop
nop
nop

lw $zero, 28($a0)
nop
nop
nop
nop
nop

lw $zero, 32($a0)
nop
nop
nop
nop
nop

lw $zero, 36($a0)
nop
nop
nop
nop
nop

lw $zero, 40($a0)
nop
nop
nop
nop
nop