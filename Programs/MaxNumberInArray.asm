# Dunnatello
.data

	list: .word 3, 6, 23, 6, 92, 2, 2, 5, 12, 76
	size: .word 10
	max: .word -1
	average: .word 0
	
	maxMessage: .asciiz "The max number of the list is: "
	averageMessage: .asciiz "\nThe average of the list is: "
	
.text

	lw $t3, size
	la $t1, list
	li $t2, 0
	li $t4, -1
	lw $t6, average
	
	
loop:

	# End Loop
	beq  $t2, $t3, end_loop
	
	# Add to Sum
	lw $t5, ($t1)
	add $t6, $t6, $t5
	
	# Branch if less than Max
	ble $t5, $t4, less
	move $t4, $t5
	
	# Increment the list iterator
	less:
	addi $t2, $t2, 1
	addi $t1, $t1, 4
	
	j loop		
	
end_loop:

	# Print Max Message
	
	li $v0, 4
	la $a0, maxMessage
	syscall
	
	# Print Max
	li $v0, 1
	move $a0, $t4
	syscall
	
	# Print Average Message
	
	li $v0, 4
	la $a0, averageMessage
	syscall
	
	# Compute Average
	
	div $t6, $t3
	mflo $t6
	
	li $v0, 1
	move $a0, $t6
	syscall
