
.data

in2cm: .float 2.54

fahrenheit2celsius: .float 0.5555555

sixft: .float 72.0

prompt_height: .asciiz "Enter your height in inches (doesn't have to be integer): "
prompt_temp:   .asciiz "Enter the temperature in fahrenheit (doesn't have to be integer): "

height_in_cm:  .asciiz "Your height in centimeters: "
temp_in_C:     .asciiz "The temperature in Celsius is: "

at_least72: .asciiz "You are at least 6 ft tall\n"

shorter_than72: .asciiz "You are less than 6 ft tall\n"

.text

main:
	li      $v0, 4
	la      $a0, prompt_height
	syscall

	li      $v0, 6    # read float
	syscall

	lwc1    $f1, sixft    # get 72.0

	li      $v0, 4
	la      $a0, shorter_than72   # preset for syscall, default shorter

	c.lt.s  $f0, $f1
	bc1t    print_ht_str   # if (height < 72.0) goto print_ht_str

	la      $a0, at_least72   # otherwise set a0 to >= string

print_ht_str:
	syscall           # print taller/shorter str


	mov.s   $f12, $f0   # put read float in f12 for arg
	jal     convert_in2cm

	li      $v0, 4
	la      $a0, height_in_cm
	syscall

	mov.s   $f12, $f0  # move to print cm height
	li      $v0, 2     # print float
	syscall

	li      $v0, 11  # print char
	li      $a0, 10   # '\n'
	syscall

	li      $v0, 4
	la      $a0, prompt_temp
	syscall

	li      $v0, 6    # read float
	syscall

	mov.s   $f12, $f0   # put read float in f12 for arg
	jal     convert_F2C

	li      $v0, 4
	la      $a0, temp_in_C
	syscall

	mov.s   $f12, $f0  # move to print degrees C
	li      $v0, 2     # print float
	syscall

	li      $v0, 11  # print char
	li      $a0, 10   # '\n'
	syscall
	




	li      $v0, 10
	syscall



# float convert_in2cm(float inches)
convert_in2cm:
	la      $t0, in2cm
	lwc1    $f0, 0($t0)    # get conversion factor

	mul.s   $f0, $f0, $f12  # f0 = 2.54 * inches

	jr      $ra

# float convert_F2C(float degrees_f)
convert_F2C:
	la      $t0, fahrenheit2celsius
	lwc1    $f0, 0($t0)    # get conversion factor

	# C = (F - 32) * 5/9
	li      $t0, 32        
	mtc1    $t0, $f1       # move int 32 to f1
	cvt.s.w $f1, $f1      # convert to 32.0


	sub.s   $f12, $f12, $f1  # f12 = degrees - 32

	mul.s   $f0, $f0, $f12  # f0 = 0.555555 * f12

	jr     $ra
