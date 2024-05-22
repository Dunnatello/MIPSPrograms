# Dunnatello
# April 11th - April 12th 2022
# Tic Tac Toe in MIPS
.data

	separator: .asciiz "\n---------------------------------------------------\n"
	newLine: .asciiz "\n"
	
	welcomeMessage: .asciiz "\tWelcome to Tic Tac Toe in MIPS!"
	credit: .asciiz "\n\tCreated by Dunnatello\n\n Enter a tile number between 1 and 9 to play.\n (left->right, top->bottom)."
	
	
	# Messages
	playAgain: .asciiz "Would you like to play again?"
	tileTaken: .asciiz "That tile is currently taken. Please choose another tile."
	
	# Player Board Symbols
	player1Symbol: .asciiz "X"
	player2Symbol: .asciiz "O"
	emptySpace: .asciiz "-"
	
	# Wins
	player1Name: .asciiz "Player 1: "
	player2Name: .asciiz "Player 2: "
	
	winCount: .asciiz "\n\tWins: "
	player1Win: .asciiz "\n\tPlayer 1 Wins!\n"
	player2Win: .asciiz "\n\tPlayer 2 Wins!\n"
	tieResult: .asciiz "\n\tTie!\n"
	
	# Turn Info
	turnTitle: "\tTurn: "
	
	# Board Info
	space: " "
	bar: .asciiz " | "
	bottomBar: .asciiz "\n-----------\n"

	boardItems: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
.text
	
main:
	
	# Print Separator
	la $a0, separator
	jal printMessage
	
	# Print Welcome Message
	la $a0, welcomeMessage
	jal printMessage
	
	# Print Credits
	la $a0, credit
	jal printMessage
	
	# Print Separator
	la $a0, separator
	jal printMessage

	# Round Count
	li $t0, 3
	
	# Player 1 Wins
	li $t1, 0
	
	# Player 2 Wins
	li $t2, 0
	
	la $t4, boardItems
		
	# Start Game
	j start

promptChoice:
	
	# Prompt Yes/No/Cancel Choice
	li $v0, 50
	syscall
	
	jr $ra
	
	
printDialog:
	
	li $v0, 55
	syscall
	
	jr $ra
	
getIntInput:

	# Get Integer User Input
	li $v0, 5
	syscall
	
	jr $ra
	
printMessage:
	
	# Print String Message
	li $v0, 4
	syscall
	jr $ra

printInt:
	
	# Print Integer
	li $v0, 1
	syscall
	jr $ra

resetBoard:
	
	# Reset Board to start New Game
	
	li $t8, 0
	
	resetLoop:
		
		sw $zero, ($t9)
		add $t9, $t9, 4
		addi $t8, $t8, 1
		
		beq $t8, 9, endResetLoop
		j resetLoop
		
	endResetLoop:
	
	# Return Stack to Start
	la $t9, ($t4)
	
	jr $ra
	
start:

	# $t0 = round count
	
	# $t1 = player 1 wins
	# $t2 = player 2 wins
	
	# Turns
	li $t3, 0

	# $t4 = Head Pointer
	
	# $t5 = free variable
	# $t6 = free variable
	# $t7 = free variable
	
	li $t8, 0 # Iterator
	
	la $t9, ($t4)
	
	jal resetBoard
	
	j gameLoop

printTurnTitle:

	la $a0, separator
	jal printMessage
	
	la $a0, turnTitle
	jal printMessage
	
	la $a0, ($t3)
	jal printInt
	
	la $a0, separator
	jal printMessage
	
	j returnFromRoundTitle

getPlayer2Name:

	la $a0, player2Name
	
	j returnFromGetPlayer2Name

setWinCheck:
	
	li $t7, 1
	j returnWinCheckResult
	
getWinCheckResult:

	bne $t7, $zero, setWinCheck
	returnWinCheckResult:
	
	jr $ra
	

player1WinRound:

	addi $t1, $t1, 1
	
	la $a0, player1Win
	jal printMessage
	
	j returnFromWonRound

player2WinRound:

	addi $t2, $t2, 1
	
	la $a0, player2Win
	jal printMessage
	
	j returnFromWonRound
	
tieRound:

	la $a0, tieResult
	jal printMessage
	
	j returnFromWonRound
	
playerWonRound:

	move $s1, $a0
	
	# Print Separator
	la $a0, separator
	jal printMessage
	
	li $a2, 3
	j showBoard
	
	returnFromBoard3:
	
	# Print Separator
	la $a0, separator
	jal printMessage
	
	# Show Round Result
	beq $s1, 0, tieRound
	beq $s1, 1, player1WinRound
	beq $s1, 2, player2WinRound

	
	returnFromWonRound:
	
	# Print Separator
	la $a0, separator
	jal printMessage
	
	sub $t0, $t0, 1
	# End Game if Game Count Equals Zero
	beqz $t0, endGame
	
	j start
	
checkBoard:
	
	# Check for Horizontal
	
	move $a0, $t6
	li $a1, 1

	
	horizontalCheckLoop:

		lw $t5, ($t9)
		lw $t6, 4($t9)
		lw $t8, 8($t9)
		
		# Check for Bitwise
		and $t7, $t5, $t6
		and $t7, $t7, $t8
	
		jal getWinCheckResult
	
		beq $t7, 1, playerWonRound
		beq $a1, 3, exitHorizontalCheckLoop
		
		addi $t9, $t9, 12
		addi $a1, $a1, 1
		
		j horizontalCheckLoop
	
	exitHorizontalCheckLoop:
	
		# Check for Vertical
		
		li $a1, 1
		la $t9, ($t4)
		
	verticalCheckLoop:
		
		lw $t5, ($t9)
		lw $t6, 12($t9)
		lw $t8, 24($t9)
		
		# Check for Bitwise
		and $t7, $t5, $t6
		and $t7, $t7, $t8
	
		jal getWinCheckResult
	
		beq $t7, 1, playerWonRound
		beq $a1, 3, exitVerticalCheckLoop
		
		addi $t9, $t9, 4
		addi $a1, $a1, 1
		
		j verticalCheckLoop
		
	exitVerticalCheckLoop:
	
		la $t9, ($t4)
		
	diagonalCheckLoop:
		
		# First Diagonal
		lw $t5, ($t9)
		lw $t6, 16($t9)
		lw $t8, 32($t9)
		
		# Check for Bitwise
		and $t7, $t5, $t6
		and $t7, $t7, $t8
		
		jal getWinCheckResult
		beq $t7, 1, playerWonRound
		
		# Second Diagonal
		lw $t5, 8($t9)
		lw $t6, 16($t9)
		lw $t8, 24($t9)
		
		# Check for Bitwise
		and $t7, $t5, $t6
		and $t7, $t7, $t8
		
		jal getWinCheckResult
		beq $t7, 1, playerWonRound
		
	endCheckBoard:
		
		j returnToCheckForWin


sendTieResult:

	li $a0, 0
	j playerWonRound
	
checkForScratch:
	
	beq $t6, 1, sendTieResult
	j endWinCheck
	
checkForWin:
	
	jal checkBoard
	
	returnToCheckForWin:
	move $t6, $a0

	# End Game if Turn Limit is Reached
	beq $t3, 5, checkForScratch
	
	j endWinCheck
	
storeTile:
	
	# Load Initial Values
	li $t8, 1
	# Reset List Location
	la $t9, ($t4)
	
	checkLoop:
		
		beq $t7, $t8, foundTile
		beq $t8, 9, tileNotFound # Tile Not Found after all tiles were checked.
		
		# Go to Next Array Element
		addi $t9, $t9, 4
		
		# Increment Index
		addi $t8, $t8, 1
		
		j checkLoop

		
	tileNotFound:
	
		la $t9, ($t4)
		li $a0, -1
		j returnTileResults
		
	foundTile:
	
		
		# Tile Already Claimed
		lw $t7, ($t9)
		bne $t7, $zero, tileNotFound
		
		# Set Return Argument as Tile Found
		li $a0, 1
				
		# Store Tile
		sw $t6, ($t9)
		
		# Reset List Location
		la $t9, ($t4)
		
		j returnTileResults
	
incorrectTile:

	# Print Error Message
	
	la $a0, tileTaken
	li $a1, 2
	jal printDialog
	
		
	move $a0, $t6
	j getPlayerInput
	
getPlayerInput:

	# Move Current Player Info to $t6
	move $t6, $a0
	
	# Print Player Name Prompt
	beq $t6, 2, getPlayer2Name
	la $a0, player1Name
	
	returnFromGetPlayer2Name:
	
	# Print Player Name Prompt
	jal printMessage
	
	# Get User Input Integer
	jal getIntInput
	
	# Move User Input Integer into $t7
	move $t7, $v0
	
	# Store Tile
	j storeTile
	
	returnTileResults:
	
	# Incorrect Tile, print error and start again
	beq $a0, -1, incorrectTile
	
	# Check for Win
	j checkForWin
	endWinCheck:
	
	# If Result is 1, then a win condition is met.
	beq $t7, 1, endGame
	
	beq $t6, 1, getPlayer2Input
	j endPlayerInput
	
gameLoop:
	
	# Increment Turn Count
	addi $t3, $t3, 1
	
	# Print Current Turn
	jal printTurnTitle
	
	returnFromRoundTitle:
	
	# Show Current Board
	li $a2, 1
	j showBoard
	
	returnFromBoard1:

	# Print Separator
	la $a0, separator
	jal printMessage

	# Prompt Player 1 Choice
	li $a0, 1
	j getPlayerInput
	
	getPlayer2Input:
	
	# Print Separator
	la $a0, separator
	jal printMessage
	
	li $a2, 2
	j showBoard
		
	returnFromBoard2:
	
	# Print Separator
	la $a0, separator
	jal printMessage
	

	# Prompt Player 2 Choice
	li $a0, 2
	j getPlayerInput

	
	endPlayerInput:
	
	j gameLoop
	
displayPlayer1Symbol:
	
	la $a0, player1Symbol
	j boardSymbolContinue
		
displayPlayer2Symbol:
	
	la $a0, player2Symbol
	j boardSymbolContinue
	
getBoardSymbol:
		
	# Display Tile Status
	la $a0, emptySpace # Display Empty Symbol
	
	lw $t6, ($t9)
	
	beq $t6, 1, displayPlayer1Symbol # Display Player 1 Claim
	beq $t6, 2, displayPlayer2Symbol # Display Player 2 Claim
	
	boardSymbolContinue:
	
	jr $ra

showBoard:
	
	li $t8, 1 # Reset Iterator
	la $t9, ($t4)
	
	showBoardLoop:
		
		# Add Space
		la $a0, space
		jal printMessage
		
		# Print Left Symbol
		jal getBoardSymbol
		jal printMessage
		addi $t9, $t9, 4

		# Print Bar
		la $a0, bar
		jal printMessage
		
		# Print Middle Symbol
		jal getBoardSymbol
		jal printMessage
		addi $t9, $t9, 4
		
		# Print Bar
		la $a0, bar
		jal printMessage
		
		# Print Right Symbol
		jal getBoardSymbol
		jal printMessage
		
		# Board Drawn, Return
		beq $t8, 3, showBoard_return
		
		# Increment Value for next loop
		addi $t9, $t9, 4
		
		la $a0, bottomBar
		jal printMessage
		
		addi $t8, $t8, 1
		
		j showBoardLoop
		
	showBoard_return:
	
	# Return Stack to Start
	la $t9, ($t4)
	
	beq $a2, 1, returnFromBoard1
	beq $a2, 3, returnFromBoard3
	j returnFromBoard2
	
player1WonResult:

	la $a0, player1Win
	j results
	
player2WonResult:
	
	la $a0, player2Win
	j results
	
playersTiedResult:

	la $a0, tieResult
	j results
	
endGame:
	
	# Print Wins
	
	# Print Separator
	la $a0, separator
	jal printMessage
	
	# Print Player 1 Name
	la $a0, player1Name
	jal printMessage

	# Print Win Heading
	la $a0, winCount
	jal printMessage
	
	# Print Score
	la $a0, ($t1)
	jal printInt
	
	# Print New Line
	la $a0, newLine
	jal printMessage
	
	# Print Player 2 Name
	la $a0, player2Name
	jal printMessage
	
	# Print Win Heading
	la $a0, winCount
	jal printMessage
	
	# Print Score
	la $a0, ($t2)
	jal printInt
	
	# Print Separator
	la $a0, separator
	jal printMessage
	
	
	# Determine Winner
	
	bgt $t1, $t2, player1WonResult # Player 1 Wins
	blt $t1, $t2, player2WonResult # Player 2 Wins
	beq $t1, $t2, playersTiedResult # Players Tied

	results:
	
	# Print Winner
	jal printMessage
	
	# Print Separator
	la $a0, separator
	jal printMessage
	
	# Prompt Play Again
	la $a0, playAgain
	jal promptChoice
	
	# If User Picked Yes, Restart Game
	beq $a0, $zero, main
	
	# End Program
	li $v0, 10
	syscall
