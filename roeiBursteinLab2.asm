# CS 10 Lab 2
# Demonstrate ability to create simple hello world program in MIPS
# Development Environment: MARS MIPS Simulator
# Name: Roei Burstein
# Solution File: HelloWorld.asm
# Date: 04/21/19
# Registers Used:
# $a0 : holds the address of hello_message
# $v0 : holds addr syscalls

	.data			# Data declarations follow this line
	
hello_message: .asciiz		"Hello World from Roei Burstein!\n"
ln_message: .asciiz 	"My name is Roei Burtstein\n"
id_message: .asciiz 		"My Foothill ID is 20272219\n\n"
s_message1: .asciiz 	"You must post an introduction in the first week\n"
s_message2: .asciiz 	"To get an A, you need 93%\n"
s_message3: .asciiz 	"The total for your two exams is 60 points out of 240\n"
	
	.text 			# Instructions follow this line

main:				# First Instructions to execute

	la $a0, hello_message 	# Loads the addr of hello_message into $a0
	li $v0, 4		# 4 is the print_string syscall
	syscall			# Do the syscall
	la $a0, ln_message	# Loads the addr of ln_message into $a0
	syscall			# Do the syscall
	la $a0, id_message	# Loads the addr of id_message into $a0
	syscall			# Do the syscall
	la $a0, s_message1	# Loads the addr of s_message1 into $a0
	syscall			# Do the syscall
	la $a0, s_message2	# Loads the addr of s_message2 into $a0
	syscall			# Do the syscall
	la $a0, s_message3	# Loads the addr of s_message3 into $a0
	syscall			# Do the syscall
	li $v0, 10		# 10 is the exit syscall
	syscall 		# Do the syscall