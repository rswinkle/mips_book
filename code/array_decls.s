

.data

array1: .word 0 : 10
array2: .word 0,1,2,3,4,5,6,7,8,9
array3: .space 40
array4: .word 42 : 10

array5: .byte 64 : 10

# These two only work with MARS not spim
array6: .float 1.618 : 10
array7: .double 3.14159 : 10

.text

main:
	la     $a0, array1
	li     $a1, 10
	jal    print_int_array

	la     $a0, array2
	li     $a1, 10
	jal    print_int_array

	la     $a0, array3
	li     $a1, 10
	jal    print_int_array

	la     $a0, array4
	li     $a1, 10
	jal    print_int_array

	la     $a0, array5
	li     $a1, 10
	jal    print_char_array

	la     $a0, array6
	li     $a1, 10
	jal    print_float_array

	la     $a0, array7
	li     $a1, 10
	jal    print_double_array

	li   $v0, 10     # exit syscall
	syscall


# void print_int_array(int* a, int size)
print_int_array:
	li    $t0, 0
	bge   $t0, $a1, exit_pia

	move  $t1, $a0  # move since we need a0 for syscalls

pia_loop:
	li    $v0, 1
	lw    $a0, 0($t1)
	syscall

	li    $v0, 11
	li    $a0, 32  # ' '
	syscall

	addi  $t0, $t0, 1  # i++
	addi  $t1, $t1, 4  # t1 = &a[i]
	blt   $t0, $a1, pia_loop

	li    $v0, 11
	li    $a0, 10  # '\n'
	syscall

exit_pia:
	jr    $ra



# void print_char_array(char* a, int size)
print_char_array:
	li    $t0, 0
	bge   $t0, $a1, exit_pca

	move  $t1, $a0  # move since we need a0 for syscalls

pca_loop:
	li    $v0, 11
	lb    $a0, 0($t1)
	syscall

	li    $v0, 11
	li    $a0, 32  # ' '
	syscall

	addi  $t0, $t0, 1  # i++
	addi  $t1, $t1, 1  # t1 = &a[i]
	blt   $t0, $a1, pca_loop

	li    $v0, 11
	li    $a0, 10  # '\n'
	syscall

exit_pca:
	jr    $ra

# void print_float_array(float* a, int size)
print_float_array:
	li    $t0, 0
	bge   $t0, $a1, exit_pfa

	move  $t1, $a0  # move since we need a0 for syscalls

pfa_loop:
	li    $v0, 2
	lwc1  $f12, 0($t1)
	syscall

	li    $v0, 11
	li    $a0, 32  # ' '
	syscall

	addi  $t0, $t0, 1  # i++
	addi  $t1, $t1, 4  # t1 = &a[i]
	blt   $t0, $a1, pfa_loop

	li    $v0, 11
	li    $a0, 10  # '\n'
	syscall

exit_pfa:
	jr    $ra



# void print_double_array(double* a, int size)
print_double_array:
	li    $t0, 0
	bge   $t0, $a1, exit_pda

	move  $t1, $a0  # move since we need a0 for syscalls

pda_loop:
	li    $v0, 3
	ldc1  $f12, 0($t1)
	syscall

	li    $v0, 11
	li    $a0, 32  # ' '
	syscall

	addi  $t0, $t0, 1  # i++
	addi  $t1, $t1, 8  # t1 = &a[i]
	blt   $t0, $a1, pda_loop

	li    $v0, 11
	li    $a0, 10  # '\n'
	syscall

exit_pda:
	jr    $ra
