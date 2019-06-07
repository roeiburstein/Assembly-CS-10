# CS 10 Lab 4
# Demonstrate ability use loops and user input in MIPS
# Development Environment: MARS MIPS Simulator
# Name: Roei Burstein
# Solution File: roeiBursteinLab4.asm
# Date: 05/6/19
# Registers Used:
# $v0: Holds print type
# $a0: Holds printing value
# $t0: Holds loop counter (incremented by 2)
# $t1: Holds sum value
# $t2: Holds the value of user input (adjusted for odd/even)
# $t3: Holds 0 or 1 for odd/even value
# $t4: Register with the value of 1

		.data
prompt:		.asciiz	"Pick a number: "
result:		.asciiz	"The sum is "
ln_message: 	.asciiz "My name is Roei Burtstein\n"
id_message: 	.asciiz "My Foothill ID is 20272219\n\n"
		.text
main:		
		li $v0, 4      			# Perform the print_string
		la $a0, ln_message
		syscall
		la $a0, id_message
		syscall
		
		la $a0, prompt 			# using the prompt
		syscall
		li $v0, 5      			# a number into $v0
		syscall
		
		li $t4, 1			# Set $t4 as the value 1
		move $t2, $v0  			# Copy it away safely into $t2
		andi $t3, $t2, 1		# Checks if input number is odd or even
		sub $t3, $t4, $t3		# If $t3 is 0, becomes 1 and vice versa
		sub $t2, $t2, $t3 		# If odd, subtracts 0. If even, subtract 1
		
		li $t0, 1   			# Counter starts at 1
		li $t1, 0			# Sum starts at 0
		
		li $v0, 4      			# Print out the result string
		la $a0, result
		syscall
		
top_of_loop: 	bgt $t0, $t2, end_of_loop	# Break out if $t0 exceeds loop $t2
		

		add $t1, $t1, $t0		# $t1 = $t1 + $t0
		add $t0, $t0, 2 		# $t0 = $t0 + 2
		b top_of_loop   		# and loop back
	
end_of_loop:	move $a0, $t1   		# print_int($t0)
		
		li $v0, 1		
		syscall
		
		li $v0, 10  			# exit syscall
		syscall
