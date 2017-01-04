# bubble sort

    .data
Arr:        .word       -3,5,3,5,7,8,9,14,37,0

    .text
    .globl  main
main:
    li      $t1,10                   # get total number of array elements

# main_loop -- do multiple passes through array
main_loop:
    subi    $a1,$t1,1               # get count for this pass (must be one less)
    blez    $a1,main_done           # are we done? if yes, fly

    la      $a0,Arr                 # get address of array
    li      $t2,0                   # clear the "did swap" flag

    jal     pass_loop               # do a single sort pass

    # NOTES:
    # (1) if we make no swaps on a given pass, everything is in sort and we
    #     can stop
    # (2) after a pass the last element is now highest, so there is no need
    #     to compare it again
    # (3) a standard optimization is that each subsequent pass shortens the
    #     pass count by 1
    # (4) by bumping down the outer loop count here, this serves both _us_ and
    #     the single pass routine [with a single register]

    beqz    $t2,main_done           # if no swaps on current pass, we are done

    subi    $t1,$t1,1               # bump down number of remaining passes
    b       main_loop

# everything is sorted
# do whatever with the sorted data ...
main_done:
    j       end                     # terminate program

# pass_loop -- do single pass through array
#   a0 -- address of array
#   a1 -- number of loops to perform (must be one less than array size because
#         of the 4($a0) below)
pass_loop:
    lw      $s1,0($a0)              # Load first element in s1
    lw      $s2,4($a0)              # Load second element in s2
    bgt     $s1,$s2,pass_swap       # if (s1 > s2) swap elements

pass_next:
    addiu   $a0,$a0,4               # move pointer to next element
    subiu   $a1,$a1,1               # decrement number of loops remaining
    bgtz    $a1,pass_loop           # swap pass done? if no, loop
    jr      $ra                     # yes, return

pass_swap:
    sw      $s1,4($a0)              # put value of [i+1] in s1
    sw      $s2,0($a0)              # put value of [i] in s2
    li      $t2,1                   # tell main loop that we did a swap
    j       pass_next

# End the program
end:
    li      $v0,10
    syscall