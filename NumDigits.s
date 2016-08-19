
	# This program counts the number of digits in
	# a number inputted by the user

	.data
n:	.word 0

	.text
main:	li $sp, 0x7ffffffc	# initialize stack pointer

	li $v0, 5		# scanf("%d", &n)
	syscall

	move $t0, $v0		# store n into register $t0
	sw $t0, n
	
	sw $t0, ($sp)		# push n on stack
	sub $sp, $sp, 4		# decrement stack pointer

	jal count		# call count_digits function

	add $sp, $sp, 4		# pop argument off stack

	move $a0, $v0		# move returned value to arg register
	li $v0, 1		# printf("%d", count_digits(n))
	syscall

	li $v0, 11		# printf("%c", '\n')
	li $a0, 10
	syscall

	li $v0 10		# quit program
	syscall
	
				# prologue
count:	sub $sp, $sp, 12	# set new stack pointer
	sw $ra, 12($sp)		# save return address in stack
	sw $fp, 8($sp)		# save old frame pointer in stack
	add $fp, $sp, 12 	# set new frame pointer

	li $t1, 0		# num_digits = 0

	bltz $t0, rev 		# if value < 0, go to reverse

	j loop			# or else go to loop

rev:	neg $t0, $t0		# value = -value

loop:	li $t2, 10		# load 10 into register
	li $t3, 1		
	div $t0, $t0, $t2	# divide value by 10
	add $t1, $t1, $t3	# num_digits++

	bgtz $t0, loop		# go back to loop if value > 0

	move $v0, $t1		# move num_digits to return register

				# epilogue
	lw $ra, 12($sp)		# load return address from stack
	lw $fp, 8($sp)		# restore old frame pointer from stack
	add $sp, $sp, 12	# reset stack pointer
	jr $ra			# return to caller using saved return address
	
