.data
hello:   .asciiz "Hello World!\n"

.text
main:
	jal  hello_world

	# simulating the jal call above manually
	la   $ra, next_instr
	j    hello_world
next_instr:

	li   $v0, 10     # exit syscall
	syscall


# void hello_world()
hello_world:
	li   $v0, 4      # print string system call
	la   $a0, hello  # load address of string to print into a0
	syscall

	jr  $ra

