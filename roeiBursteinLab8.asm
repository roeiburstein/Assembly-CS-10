# CS 10 Lab 8
# Demonstrate ability to use no ops to prevent hazards
# Development Environment: MARS MIPS Simulator
# Name: Roei Burstein
# Solution File: roeiBursteinLab8.asm
# Date: 06/11/19
# Registers Used:
# $2: Holds any value
# $3: Holds any value
# $4: Holds any value
# $5: Holds any value
# $6: Holds any value
# $7: Holds any value
# $9: Holds any value
# $10: Holds any value
# $16: Holds any value
# $18: Holds any value

#+-------------------------------------------------------------------------------+
#|  Original          |                       CPU Cycles                         |
#+--------------------+----+----+------------------------------------------------+
#|                    | 1  | 2  | 3  |  4  | 5  | 6  |  7  |  8  |  9  | 10 | 11 |
#+--------------------+----+----+----+-----+----+----+-----+-----+-----+----+----+
#|i1 add $3, $2, $3   | IF | ID | EX | MEM | WB |    |     |     |     |    |    | 
#|i2 lw $4, 100($3)   |    | IF | ID | EX  | WB |    |     |     |     |    |    |
#|i3 sub $7, $6, $2   |    |    | IF | ID  | EX | MEM| WB  |     |     |    |    |
#|i4 xor $6, $4, $3   |    |    |    | IF  | ID | EX | WB  |     |     |    |    |
#+---------+---------------------------------------------------------------------+

# Cycles 5 and 7 have structural hazards (Writing to the same register)

#+-------------------------------------------------------------------------------+
#|  Updated           |                       CPU Cycles                         |
#+--------------------+----+----+------------------------------------------------+
#|                    | 1  | 2  | 3  |  4  | 5  | 6  |  7  |  8  |  9  | 10 | 11 |
#+--------------------+----+----+----+-----+----+----+-----+-----+-----+----+----+
#|i1 add $3, $2, $3   | IF | ID | EX | MEM | WB |    |     |     |     |    |    |
#|i2 add $16, $4, $5  |    | IF | ID | EX  | MEM| WB |     |     |     |    |    |
#|i3 add $18, $9, $10 |    |    | IF | ID  | EX | MEM| WB  |     |     |    |    |
#|i4 lw $4, 100($3)   |    | 	|    |	IF | ID | EX | WB  |     |     |    |    |    
#|i5 sub $7, $6, $2   |	   |	|    |     | IF | ID | EX  | MEM | WB  |    |    | 
#|i6 add $16, $4, $5  |    | 	|    |	   |	| IF | ID  | EX  | MEM | WB |    |
#|i7 add $18, $9, $10 |    |    |    |	   |	|    | IF  | ID  | EX  | MEM| WB |     
#|i8 xor $6, $4, $3   |    |	|    |     |    |    |     | IF  | ID  | EX | WB |  
#+---------+---------------------------------------------------------------------+

# 4 no-ops included to prevent overlapping writing to single register
# Note: overlaps seen in chart above are using different registers

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
	
	add $3, $2, $3		# Writes to register $3
	
	add $16, $4, $5		# i-type No op to delay lw
	add $18, $9, $10	# Additional No op using
	
	lw $4, 100($3)		# RAW: This instruction reads $3 
				# right after it's written (r-type)
	sub $7, $6, $2	
	
	add $16, $4, $5		# i-type No op to delay lw
	add $18, $9, $10	# Additional No op using
	
	xor $6, $4, $3		# WAR: This instruction writes to $6 
				# right after it's written (r-type)