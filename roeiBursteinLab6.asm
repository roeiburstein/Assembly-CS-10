# CS 10 Lab 6
# Demonstrate ability use stacks and functions
# Development Environment: MARS MIPS Simulator
# Name: Roei Burstein
# Solution File: roeiBursteinLab6.asm
# Date: 05/27/19
# Registers Used:
# $v0: Holds print type
# $a0: Holds printing value
# $t1: Holds total value to be printed
# $t2: Holds lower value of sum
# $t3: Holds upper value of sum
# $t4: Holds the product of the two numbers 
#      to be added in each iteration of the loop

		.data
ln_message: 	.asciiz "My name is Roei Burtstein\n"
id_message: 	.asciiz "My Foothill ID is 20272219\n\n"
		.text
		
main:
	li $v0, 4      				# Perform the print_string
	la $a0, ln_message
	syscall
	la $a0, id_message
	syscall
	li $t2, 0				# Set $t2 as the value 0
	li $t3, 1				# Set $t3 as the value 1

top_of_loop: 	bgt $t3, 21, end_of_loop	# Break out if $t3 exceeds 21
	
	mult $t2, $t3				# $t2 * $t3
	mflo $t4				# Stores the above value into $t1
	add $t1, $t1, $t4			# $t1 = $t1 + $t4

	add $t2, $t2, 1				# Increment $t2 by 1
	add $t3, $t3, 1				# Increment $t3 by 1
	
	b top_of_loop   			# and loop back
	
end_of_loop:	move $a0, $t1   		# print_int($t0)

	li $v0, 1		
	syscall
		
	li $v0, 10  				# exit syscall
	syscall
