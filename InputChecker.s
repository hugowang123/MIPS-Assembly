
	# This program first stores all integers passed in
	# by the user into an array ( up to 100 ints ) until
	# a 0 is inputted signifying end of input.
	# Then, the user is free to input any integer. The program
	# will print either the index of the integer in the array
	# if it is present, or -1 if it is not present.
	# Once 0 is inputted a second time, the program quits.


	.data 
arr:	.space 400              # array of 100 int
n:	.word 0
max:	.word 0
ele:	.word 0
idx:	.word 0
pos:	.word 0

	.text

main:	li $v0 5		# scanf("%d", &n)
	syscall

	lw $t0, max		# initialize max to 0
	move $t1, $v0 		# move n to register
	sw $t1, n

	li $t2, 100		# load 100 to register

while:	beqz $t1, check		# if n == 0, go to next loop
	bge $t0, $t2, scan	# if max > 100, go to next statement

	li $t3, 4		# 4 is for indexing array
	mul $t4, $t0, $t3       # find exact memory spot in array
	
	sw $t1, arr($t4)	# store n into the array

	li $t5, 1
	add $t0, $t0, $t5	# max++
	sw $t0, max

scan:   li $v0, 5		# scanf("%d", &n)
	syscall
	
	move $t1, $v0		# store n to register
	sw $t1, n
	
	j while			# back to while loop 

check:  li $v0, 5		# scanf("%d", &element)
	syscall
	
	move $t6, $v0
	sw $t6, ele		# store ele in memory

loop:   beqz $t6, end		# go to end of program if ele == 0
	lw $t7, idx		# load idx

find:	bge $t7, $t0, if	# go to if if idx >= max
	mul $t9, $t7, $t3	# multiply idx by 4 to find array index
	
	lw $t8, arr($t9)	# load the value of array[idx]
	beq $t6, $t8, if	# compare ele to array[idx]
				# if equal, go to print

        add $t7, $t7, $t5	# idx++
	sw $t7, idx
	j find			# back to find loop


if:     bge $t7, $t0, else 	# check if idx >= max, go to else if so
        li $v0, 1		# printf("%d", idx)
        move $a0, $t7
	
        syscall
        j endif			# go to endif

else:	li $v0, 1		# else printf("%d", -1)
	li $a0, -1
	syscall

endif:  li $v0, 11		# printf("%c", '\n')
	li $a0, 10
	syscall

	j check			# back to checking loop

end:    li $v0 10		# quit program
        syscall
