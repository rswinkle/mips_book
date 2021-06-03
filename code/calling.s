.data
hello:   .asciiz "Hello World!\n"
name:    .asciiz "Robert"

.text
main:
	jal     hello_world

	# simulating the jal call above manually
	la      $ra, next_instr
	j       hello_world
next_instr:

	la      $a0, name
	li      $a1, 15
	jal     hello_name_number

	move    $a0, $v0   # move return value to a0 first
	li      $v0, 1     # so we don't overwrite it and lose it
	syscall

	li      $v0, 11    # print char
	li      $a0, 10    # '\n'
	syscall

	li      $s0, 0     # i = 0 (I can use s regs without saving because I exit from main, rather than return)
	li      $s1, 10
fib_loop:
	move    $a0, $s0
	jal     fib         # fib(i)

	move    $a0, $v0
	li      $v0, 1      # print int
	syscall

	li      $v0, 11    # print char
	li      $a0, 32    # ' '
	syscall
	
	addi    $s0, $s0, 1   # i++
	blt     $s0, $s1, fib_loop  # while (i < 10)

	li      $v0, 11    # print char
	li      $a0, 10    # '\n'
	syscall

	li      $s0, 0     # i = 0
fib2_loop:
	move    $a0, $s0
	jal     fib2         # fib2(i)

	move    $a0, $v0
	li      $v0, 1      # print int
	syscall

	li      $v0, 11    # print char
	li      $a0, 32    # ' '
	syscall
	
	addi    $s0, $s0, 1   # i++
	blt     $s0, $s1, fib2_loop    # while (i < 10)

	li      $v0, 11    # print char
	li      $a0, 10    # '\n'
	syscall

	li      $v0, 10     # exit syscall
	syscall




# void hello_world()
hello_world:
	li   $v0, 4      # print string system call
	la   $a0, hello  # load address of string to print into a0
	syscall

	jr  $ra

.data
hello_space:  .asciiz "Hello "
exclaim_nl:   .asciiz "!\n"

.text
#int hello_name_number(char* name, int number)
hello_name_number:
	move    $t0, $a0   # save name in t0 since we need a0 for the syscall

	li      $v0, 4        # print string
	la      $a0, hello_space
	syscall

	move      $a0, $t0    # print name (v0 is still 4)
	syscall

	la        $a0, exclaim_nl
	syscall


	addi    $v0, $a1, 10  # return number+10
	jr      $ra



#int fib(int n)
fib:
	addi    $sp, $sp, -8
	sw      $ra, 0($sp)
	sw      $s0, 4($sp)

	move    $v0, $a0        # prepare to return n
	li      $t0, 1
	ble     $a0, $t0, exit_fib  # if (n <= 1) goto exit_fib (ie return n)

	move    $s0, $a0        # save n

	addi    $a0, $a0, -2
	jal     fib             # fib(n-2)

	addi    $a0, $s0, -1    # prep arg first so we can use s0 to save v0
	move    $s0, $v0        # save return of fib(n-2) in s0
	jal     fib             # fib(n-1)

	add     $v0, $v0, $s0   #  v0 = fib(n-1) + fib(n-2)

exit_fib:
	lw      $ra, 0($sp)
	lw      $s0, 4($sp)
	addi    $sp, $sp, 8
	jr      $ra

# identical to fib() except a tiny bit more efficient by saving 6 instructions
# any time n is <= 1
#int fib2(int n)
fib2:
	move    $v0, $a0        # prepare to return n
	li      $t0, 1
	ble     $a0, $t0, exit_fib2  # if (n <= 1) goto exit_fib2 (ie return n)

	addi    $sp, $sp, -8
	sw      $ra, 0($sp)
	sw      $s0, 4($sp)


	move    $s0, $a0        # save n

	addi    $a0, $a0, -2
	jal     fib2             # fib2(n-2)

	addi    $a0, $s0, -1    # prep arg first so we can use s0 to save v0
	move    $s0, $v0        # save return of fib(n-2) in s0
	jal     fib2            # fib2(n-1)

	add     $v0, $v0, $s0   #  v0 = fib2(n-1) + fib2(n-2)

	lw      $ra, 0($sp)
	lw      $s0, 4($sp)
	addi    $sp, $sp, 8
exit_fib2:
	jr      $ra
