
.data

pi_float:  .float 3.14159265358979323846264338327950288 
pi_double: .double 3.14159265358979323846264338327950288


.text
main:

	# print best representation of pi as float
	li      $v0, 2
	lwc1    $f12, pi_float
	syscall

	li      $v0, 11
	li      $a0, 10   # '\n'
	syscall

	# calculate and print pi using floats to compare
	li      $a0, 5000000
	jal     calc_pi_float

	li      $v0, 2
	mov.s   $f12, $f0
	syscall

	li      $v0, 11
	li      $a0, 10
	syscall


	# print best representation of pi as double
	li      $v0, 3
	ldc1    $f12, pi_double
	syscall

	li      $v0, 11
	li      $a0, 10
	syscall

	# calculate and print pi using doubles to compare
	li      $a0, 5000000
	jal     calc_pi_double


	li      $v0, 3
	mov.d   $f12, $f0
	syscall

	li      $v0, 11
	li      $a0, 10
	syscall

	li      $v0, 10     # exit syscall
	syscall



# float calc_pi_float(int iterations)
calc_pi_float:
	mtc1    $0, $f0     # move 0 to $f0 (0 integer == 0.0 float)

	# li.s not available by default in MARS?
	#li.s    $f0, 0.0
	#li.s    $f2, 4.0

	# get 4 to 4.0 in $f2
	li       $t0, 4
	mtc1     $t0, $f2
	cvt.s.w  $f2, $f2   # convert 4 to 4.0

	li       $t0, 1    # denominator
	mtc1     $t0, $f4
	cvt.s.w  $f4, $f4   # convert 1 to 1.0

	# 2 for add
	li       $t0, 2
	mtc1     $t0, $f8
	cvt.s.w  $f8, $f8   # convert float

	li       $t0, 0     # negate = false, i = 0

gregory_leibniz_loop:

	div.s   $f6, $f2, $f4   # f6 = 4 / denom

	andi    $t2, $t0, 0x1
	beq     $t2, $0, no_negate  # if (negate % 2 == 0) goto no_negate
	neg.s   $f6, $f6

no_negate:
	add.s   $f0, $f0, $f6       # sum += term  (sum approaches pi)
	

	addi    $t0, $t0, 1     # negate++
	add.s   $f4, $f4, $f8   # denominator += 2
	blt     $t0, $a0, gregory_leibniz_loop  # while (negate aka i < iterations)

	jr      $ra



# double calc_pi_double(int iterations)
calc_pi_double:
	mtc1    $0, $f0     # move 0 to $f0-f1 (0 integer == 0.0 float)
	mtc1    $0, $f1

	# li.s/li.d not available by default in MARS?
	#li.s    $f0, 0.0
	#li.s    $f2, 4.0

	# get 4 to 4.0 in $f2
	li       $t0, 4
	mtc1     $t0, $f2
	cvt.d.w  $f2, $f2   # convert 4 to 4.0

	li       $t0, 1    # denominator
	mtc1     $t0, $f4
	cvt.d.w  $f4, $f4   # convert 1 to 1.0

	# 2 for add
	li       $t0, 2
	mtc1     $t0, $f8
	cvt.d.w  $f8, $f8   # convert float

	li       $t0, 0     # negate = false, i = 0

gregory_leibniz_loop_d:

	div.d   $f6, $f2, $f4   # f6 = 4 / denom

	andi    $t2, $t0, 0x1
	beq     $t2, $0, no_negate_d  # if (negate % 2 == 0) goto no_negate
	neg.d   $f6, $f6

no_negate_d:
	add.d   $f0, $f0, $f6       # sum += term  (sum approaches pi)
	

	addi    $t0, $t0, 1     # negate++
	add.d   $f4, $f4, $f8   # denominator += 2
	blt     $t0, $a0, gregory_leibniz_loop_d  # while (negate aka i < iterations)

	jr      $ra
