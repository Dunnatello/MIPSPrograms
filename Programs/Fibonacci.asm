# Dunnatello
.data

	instructions: .asciiz "Enter a number to compute the Fibonacci: "

.text


	li $t1, 0 # Sum
	li $t2, 1 # Iterator
	
	li $t3, 0 # F(N - 2)
	li $t4, 1 # F(N - 1)
	 
	li $t5, 1 # One
	
	main:
	
		# Print Instructions
		li $v0, 4
		la $a0, instructions
		syscall
	
		# Get User Input
		li $v0, 5
		syscall
		
		# Move User Input to Temporary Variable
		move $t0, $v0
		
		# Compute Fibonacci
		j compute
	
	# User Input is 1. Return Special Case
	returnOne:
	
		move $t1, $t5
		j printResult
		
	compute:
		
		beq $t0, $t5, returnOne # Branch if User Input is 1.
		bge $t2, $t0, printResult # Branch if index is the user input
		
		add $t1, $t3, $t4 # f(n) = f(n - 1) + f(n - 2)
	
		move $t3, $t4 # Move F(n - 1) to F(n - 2)
		
		# Set Current
		la $t4, ($t1)
		
		# Iterate Index
		add $t2, $t2, $t5
		
		# Loop
		j compute
		
	
	printResult:
	
		# Print Result
		li $v0, 1
		move $a0, $t1
		syscall	
	
	exit: # Exit Program
	
		li $v0, 10
		syscall
