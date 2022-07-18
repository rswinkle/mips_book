.data

there_are:  .asciiz "There are "
arguments:  .asciiz " command line arguments:\n"


.text

main:
	move    $t0, $a0  # save argc

	li      $v0, 4
	la      $a0, there_are
	syscall

	move    $a0, $t0
	li      $v0, 1   # print int
	syscall

	li      $v0, 4
	la      $a0, arguments
	syscall

	li      $t1, 0   # i = 0
	j       arg_loop_test

arg_loop:
	li      $v0, 4
	lw      $a0, 0($a1)
	syscall

	li      $v0, 11
	li      $a0, 10    # '\n'
	syscall

	addi    $t1, $t1, 1   # i++
	addi    $a1, $a1, 4    # argv++ ie a1 = &argv[i]
arg_loop_test:
	blt     $t1, $t0, arg_loop  # while (i < argc)

	li      $v0, 10
	syscall
