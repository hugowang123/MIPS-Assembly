	# This program reads three integers from the user and then
	# counts the number of multiples of the third integer that
	# lie between the other two numbers (inclusive). The result
	# will always be 0 or more

	
	.data
m:	.word 0
n:	.word 0
mod:	.word 0
count:	.word 0

	.text
main:	li $v0, 5  		 # scanf("%d", &m)
	syscall
	move $t0, $v0   	 # move m to a register
	sw $t0, m
	
	li $v0, 5  		 # scanf("%d", &n) 
	syscall
	move $t1, $v0		 # move n to a register
	sw $t1, n
	
	li $v0, 5  		 # scanf("%d", &mod_value)
	syscall
	move $t2, $v0		 # move mod_value to a register
	sw $t2, mod
	
	li $t3, 0  		 # initialize count
	
	ble $t0, $t1, loop 	 # check if m <= n
	j end			 # if m > n, go to the end of program

loop:	rem $t4, $t0, $t2        # find the remainder of m/mod_value
	bnez $t4, endif		 # if it is not equal to 0, skip count incr
	li $t5, 1      
	add $t3, $t3, $t5        # count++
	sw $t3, count

endif:	li $t5, 1
	add $t0, $t0, $t5 	 # m++
	sw $t0, m
	ble $t0, $t1, loop       # check if m <= n, if so go to loop again

end:	move $a0, $t3            # load count value into arg register
	sw $a0, count
	li $v0, 1                # printf("%d", count) 
	syscall

	li $v0, 11               # printf("%c", '\n') 
	li $a0, 10
	syscall

	li $v0, 10 		 # quit program
	syscall
