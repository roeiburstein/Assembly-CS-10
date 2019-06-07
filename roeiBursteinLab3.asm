# Lab 3 CS10 roeiBursteinLab3.asm 
#
		.data
myId:		.word	20272219	# Store 20272219 as a word into myId location
nLet:		.byte	8		# Store 8 as a byte into nLet location

fn_message:	.asciiz	"My family name is Burstein!\n"
id_message:  	.asciiz "My Foothill ID is 20272219 \n"
val_message:  	.asciiz "The value of myId is 25\n"
num_message:  	.asciiz "The number of characters in my last name is 8\n\n"


# Perform the command num1 = num1 * num2 + num3
#

	.text
main:
	la 	$a0, fn_message 	# Loads the addr of fn_message into $a0
	li 	$v0, 4			# 4 is the print_string syscall
	syscall				# Do the syscall
	la 	$a0, id_message		# Loads the addr of id_message into $a0
	syscall				# Do the syscall
	la 	$a0, val_message	# Loads the addr of val_message into $a0
	syscall				# Do the syscall
	la 	$a0, num_message	# Loads the addr of num_message1 into $a0
	syscall				# Do the syscall
	
	lw	$s0, myId       	# $s0 = myId
	lb	$s1, nLet        	# $s1 = nLet
	add	$t1, $s1, $s0	  	# $t1 = $s0 + $s1
	sub 	$t2, $s1, $s0		# $t2 = $s0 - $s1
	sll 	$t3, $s1, 2		# $t3 = $s1 left shift twice = $s1 * 4
	add	$s2, $t1, 1		# $s2 = $t1 + 1 (to turn sum even)
	andi 	$s3, $s2, 1
	sub	$s4, $s2, $s3
	srl 	$t4, $s3, 1		# $t4 = $s2 right shift once = $s1 / 2
	
	
# Now print out the result
	li	$v0, 1            	# 1 means the print_int syscall
	move 	$a0, $t1
	syscall
	move 	$a0, $t2
	syscall	
	move 	$a0, $t3
	syscall
	move 	$a0, $t4
	syscall		
                          		# Now tell the system to stop
	li	$v0, 10          	# 10 means the exit syscall
	syscall
