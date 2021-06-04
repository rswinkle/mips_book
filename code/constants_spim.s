
sys_print_str = 4
sys_exit = 10

.data
hello:   .asciiz "Hello World!\n"

.text
main:
	li   $v0, sys_print_str
	la   $a0, hello  # load address of string to print into a0
	syscall

	li   $v0, sys_exit
	syscall
