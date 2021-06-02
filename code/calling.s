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
