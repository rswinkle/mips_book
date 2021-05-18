.data

.eqv print_str 4

name:     .space 50

nameprompt:  .asciiz "What's your name? "
hello_space: .asciiz "Hello "
how_old:     .asciiz "How old are you? "
ask_height:  .asciiz "Enter your height in inches: "
ageplusheight: .asciiz "Your age + height = "


.text
main:
	li   $v0, 4      # print string system call
	la   $a0, nameprompt  # load address of string to print into a0
	syscall

	li   $v0, 8      # read string
	la   $a0, name
	li   $a1, 50
	syscall

	li   $v0, 4
	la   $a0, hello_space
	syscall

	la   $a0, name  # note 4 is still in $v0
	syscall

	# don't print a newline here because
	# one will be part of name unless they typed >48 characters

	li   $v0, 4
	la   $a0, how_old
	syscall

	li   $v0, 5   # read integer
	syscall
	move $t0, $v0  # save age in t0

	li   $v0, 4
	la   $a0, ask_height
	syscall

	li   $v0, 5   # read integer
	syscall
	add  $t0, $t0, $v0 # t0 += height


	li   $v0, 4
	la   $a0, ageplusheight
	syscall

	li   $v0, 1  # print int
	move $a0, $t0  # a0 = age + height
	syscall
	
	# print newline
	li   $v0, 11   # print char
	li   $a0, 10   # ascii value of '\n'
	syscall


	li   $v0, 10     # exit syscall
	syscall
