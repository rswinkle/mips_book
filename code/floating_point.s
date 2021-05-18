.data

test: .asciiz "hello 1\n"

test2: .asciiz "hello 2\n"


.text
main:
	li    $t0, 1
	bltz  $t0, label1

	li    $v0, 4
	la    $a0, test
	syscall

	j     exit_prog


label1:
	li    $v0, 4
	la    $a0, test2
	syscall

exit_prog:
	li   $v0, 10     # exit syscall
	syscall
