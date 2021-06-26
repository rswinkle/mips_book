
.data

.macro sys_exit
li   $v0, 10
syscall
.end_macro

.macro print_int_reg(%x)
	li    $v0, 1
	move  $a0, %x
	syscall
.end_macro

.macro print_str_label(%x)
	li     $v0, 4
	la     $a0, %x
	syscall
.end_macro

.macro print_str(%str)
.data
str: .asciiz %str
.text
	li     $v0, 4
	la     $a0, str
	syscall
.end_macro



str1:   .asciiz "Hello 1\n"



.text

main:

	print_str_label(str1)

	print_str("Hello World!\n")

	li   $t0, 42
	print_int_reg($t0)




	#sys_exit
	li   $v0, 10
	syscall
