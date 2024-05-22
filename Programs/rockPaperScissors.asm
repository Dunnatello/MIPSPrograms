# Dunnatello

.data

	userPrompt: .asciiz "\tEnter your choice as a number as stated below: \n\t Paper - 1\n\t Scissors - 2\n\t Rock - 3\n\t Your Choice: "
	
	user1Name: "\nPlayer 1: "
	user2Name: "\nPlayer 2: "
	
	user1Win: .asciiz "\n\tPlayer 1 wins!\n"
	user2Win: .asciiz "\n\tPlayer 2 wins!\n"
	tieResult: "\n\tTie!\n"
	
	doubleIndent: .asciiz "\n\n"
	
	separationText: .asciiz "\n\n-------------------------------------------\n\n"
	
.text

main:
	
	li $t1, 3 # Rounds Left
	
	li, $t2, 0 # Player 1 Wins
	li, $t3, 0 # Player 2 Wins
	
	li $t4, 0 # Player 1 Choice
	li $t5, -1 # Player 2 Choice
	
	li $t6, 1 # Paper
	li $t7, 2 # Scissors
	li $t8, 3 # Rock
	
	j Game

PrintString:
	
	li $v0, 4
	syscall
	jr $ra
	
PrintInt:

	li $v0, 1
	syscall
	jr $ra
	
Game:
	
	# Print Player 1 Name
	la $a0, user1Name
	jal PrintString
	
	la $a0, doubleIndent
	jal PrintString
	
	# Get Player 1 Choice
	jal GetUserChoice
	move $t4, $v0
	
	# Print Player 2 Name
	la $a0, user2Name
	jal PrintString
	
	la $a0, doubleIndent
	jal PrintString
	
	# Get Player 2 Choice
	jal GetUserChoice
	move $t5, $v0
	
	j CompareResults
	
				
Update:

	sub $t1, $t1, 1
	beqz $t1, EndGame
	
	j Game

displayTie:

	la $a0, tieResult
	jal PrintString
	
	j Update
	
displayPlayer1Win:

	la $a0, user1Win
	jal PrintString
	
	# Increment Player 1 Score
	addi $t2, $t2, 1
	
	j Update

displayPlayer2Win:

	la $a0, user2Win
	jal PrintString
	
	# Increment Player 2 Score
	addi $t3, $t3, 1
	
	j Update

PaperOptions:
	
	# Player 2 Chose Rock
	beq $t5, $t8, displayPlayer1Win
	
	#Player 2 Chose Scissors
	beq $t5, $t7, displayPlayer2Win
	
	
ScissorOptions:

	# Player 2 Chose Paper
	beq $t5, $t6, displayPlayer1Win
	
	# Player 2 Chose Rock
	beq $t5, $t8, displayPlayer2Win
	
RockOptions:

	# Player 2 Chose Scissors
	beq $t5, $t7, displayPlayer1Win
	
	# Player 2 Chose Paper
	beq $t5, $t6, displayPlayer2Win
	
CompareResults:

	beq $t4, $t5, displayTie
	
	# Player 1 Chose Paper
	beq $t4, $t6, PaperOptions
	
	# Player 1 Chose Scissors
	beq $t4, $t7, ScissorOptions
	
	# Player 1 Chose Rock
	beq $t4, $t8, RockOptions
	

	
	j Update
	
GetUserChoice:
	
	
	# Print Prompt
	li $v0, 4
	la $a0, userPrompt
 	syscall
 	
 	# Get Input
 	li $v0, 5
	syscall
	
	jr $ra

Player1Won:

	la $a0, user1Win
	jal PrintString

	jr $ra
	
Player2Won:

	la $a0, user2Win
	jal PrintString

	jr $ra
	
EndGame:

	la $a0, separationText
	jal PrintString

	# Print Player 1 Score	
	la $a0, user1Name
	jal PrintString
	
	move $a0, $t2
	jal PrintInt
	
	# Print Player 2 Score
	la $a0, user2Name
	jal PrintString
	
	move $a0, $t3
	jal PrintInt
	
	
	la $a0, separationText
	jal PrintString
	
	# Player 1 > Player 2
	bgt $t4, $t5, Player1Won
	
	# Player 1 < Player 2
	blt $t4, $t5, Player2Won
	
	la $a0, separationText
	jal PrintString
	
	# Exit Program
	li $v0, 10
	syscall
