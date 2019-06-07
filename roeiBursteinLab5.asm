# CS 10 Lab 5
# Demonstrate ability use stacks and functions
# Development Environment: MARS MIPS Simulator
# Name: Roei Burstein
# Solution File: roeiBursteinLab5.asm
# Date: 05/21/19
# Registers Used:
# $v0: Holds print type
# $a0: Holds printing value
# $t0: Holds average of 2 numbers
# $t1: Holds sum of 2 numbers
# $t7: Holds the average out of the stack
# $s0: Holds the value of first number
# $s1: Holds the value of second number
# $sp: Register with stack pointer
# $ra: Return address

		.data
ln_message: 	.asciiz "My name is Roei Burtstein\n"
id_message: 	.asciiz "My Foothill ID is 20272219\n\n"
		.text
		
main:
	li $v0, 4      			# Perform the print_string
	la $a0, ln_message
	syscall
	la $a0, id_message
	syscall
		
	li 	$s0, 12			# Saves the value 12 in register $s0
	li 	$s1, 16			# Saves the value 16 in register $s1
	
	subu	$sp, $sp, 8		# Create Stack Frame
	sw	$s0, 0,($sp)		# Put value of $s0 in address 0 of the stack
	sw	$s1, 4,($sp)		# Put value of $s1 in address 4 of the stack
	
	jal rb_avg			# Calls the function
	
	lw $t7, 0($sp)			# Saves average value into $t7
	addi $sp, $sp, 4		# Deletes memory from stack
	
	li $v0, 10			# Saves 10 into $v0
	syscall
	
	
rb_avg:	
	lw 	$s0, 0($sp)		# Loads the value in address 0 of the stack into $s0
	lw 	$s1, 4($sp)		# Loads the value in address 4 of the stack into $s1
	addi 	$sp, $sp, 8		# Deletes space from stack
	
	add 	$t1, $s0, $s1		# Adds the two numbers from the stack 
	div 	$t0, $t1, 2		# Divides by two and saves the average
	
	subu 	$sp, $sp, 4		# Decrement $sp by 4
	sw	$t0, 0,($sp)		# Saves $t0 into the stack
	
	li	$t0, 9			# Overwrites the value of $t0 (id is 20272219, last number is 9)
	jr 	$ra			# Exits the function
	
	
	
	
	
	
	
