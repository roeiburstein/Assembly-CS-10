# CS 10 Lab 7
# Demonstrate ability use exception handlers
# Development Environment: MARS MIPS Simulator
# Name: Roei Burstein
# Solution File: roeiBursteinLab7.asm
# Date: 06/04/19
# Registers Used:
# $v0: Holds print type
# $a0: Holds printing value
# $k0: Holds address and exception code number

		.kdata
__m1_:		.asciiz "  Exception caused by instruction at Address: "
__m2_:		.asciiz "\n  Exception Code: "
__m3_:		.asciiz "\n  Ignore and continue program\n\n  "

s1:		.word 0
s2:		.word 0
		.ktext 0x80000180
		
	
	sw $v0 s1               # Not re-entrant and we can't trust $sp
	sw $a0 s2               # But we need to use these registers
	
	li $v0 4                # syscall 4 (print_str)
	la $a0 __m1_		# Print out Exception Address statement
	
	syscall

	li $v0 34               # Syscall 34 
	mfc0 $k0 $14            # Get Cause Address
	srl $a0 $k0 2           # Extract ExcCode Field
	andi $a0 $a0 0xf
	syscall
############################################################	
	li $v0 4                # syscall 4 (print_str)
	la $a0 __m2_		# Print out Exception Code statement
	
	syscall

	li $v0 1              	# Syscall 34 
	mfc0 $k0 $13            # Get Exception Code
	srl $a0 $k0 2           # Extract ExcCode Field
	andi $a0 $a0 0xf
	syscall
############################################################	
	mfc0 $k0 $14            # Get EPC register value
	addiu $k0 $k0 4         # Skip faulting instruction by skipping
	mtc0 $k0 $14            # Reset the EPC register
	
	li $v0 4                # syscall 4 (print_str)
	la $a0 __m3_		# Print out Exception Address statement
	
	syscall
############################################################
	lw $v0 s1               # Restore $v0 and $a0
	lw $a0 s2
	mtc0 $0 $13             # Clear Cause register
	mtc0 $k0 $12
	eret
	