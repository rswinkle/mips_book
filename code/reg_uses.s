
# run with
# spim -bare -file reg_uses.s

.data

.text
main:

	# in bare mode you can't use pseudo-instructions like li
	# but you can use register 1 ($at, assembler temporary) which
	# is not allowed in normal mode.

	ori    $at, $0, 22
	ori    $s8, $0, 20
	add    $a0, $at, $s8
	ori    $v0, $0, 1
	syscall

	ori     $v0, $0, 11    # print char
	ori     $a0, $0, 10    # '\n'
	syscall

	ori     $v0, $0, 10     # exit syscall
	syscall
	
