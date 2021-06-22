

# in bare mode the .data section starts at 0x10000000
# without -bare, spim puts it at 0x10010000, so your lui will change
# but if you weren't doing bare you'd probably just be using la

# MARS .data always starts at 0x10010000, whether pseudoinstructions
# or delayed branching are on or not.

.data

there_are:  .asciiz "There are "
arguments:  .asciiz " command line arguments:\n"

# run with spim -bare -file args_bare.s

.text

.globl main
main:
	or      $t0, $0, $a0  # save argc

	ori     $v0, $0, 4
	lui     $a0, 0x1000    # there_are is at beginning of data so just lui, lower is 0
	syscall

	or      $a0, $0, $t0
	ori     $v0, $0, 1   # print int
	syscall

	ori     $v0, $0, 4
	lui     $a0, 0x1000
	ori     $a0, $a0, 11   # 11 is length in bytes of "There are " 10 chars + '\0'
	#la      $a0, arguments
	syscall

	ori     $t1, $0, 0   # i = 0
	j       arg_loop_test
	or      $0, $0, $0

arg_loop:
	ori     $v0, $0, 4
	lw      $a0, 0($a1)
	or      $0, $0, $0
	syscall

	ori     $v0, $0, 11
	ori     $a0, $0, 10    # '\n'
	syscall

	addi    $t1, $t1, 1   # i++
	addi    $a1, $a1, 4    # argv++ ie a1 = &argv[i]
arg_loop_test:
	bne     $t1, $t0, arg_loop  # while (i != argc)
	or      $0, $0, $0


	ori     $v0, $0, 10
	syscall
