# MIPS Programs
These are several MIPS assembly language programs that I made for my Computer Organization and Architecture course. Feel free to use them however you like.

# Tic-tac-toe
The tic-tac-toe program evaluates a list of winning conditions to determine the winner between two players. It checks for diagonal as well as vertical wins. If no player wins, then the program will consider the game a draw.

<p align="center"><img src="https://github.com/Dunnatello/MIPSPrograms/blob/main/GitHub%20Readme%20Data/Tic-tac-toe%20Start.png" width="366"></p>
<p align="center"><b>Figure 1:</b> The tic-tac-toe program features a console UI that will allow players to select a number to indicate their movement.</p>

<p align="center"><img src="https://github.com/Dunnatello/MIPSPrograms/blob/main/GitHub%20Readme%20Data/Tic-tac-toe%20Win%20Check.png" width="366"></p>
<p align="center"><b>Figure 2:</b> After the game ends, the program will display the winner or state that it was a tie.</p>

# Rock Paper Scissors
This is a two player game that compares player 1's choice to player 2's choice and determines the winner. It works by checking whether the first player used rock, paper, or scissors and then determining the win outcome based on player 2's response.

<p align="center"><img src="https://github.com/Dunnatello/MIPSPrograms/blob/main/GitHub%20Readme%20Data/Rock%20Paper%20Scissors.png" width="415"></p>
<p align="center"><b>Figure 3:</b> Players can choose between rock, paper, or scissors and the program will evaluate the result afterwards.</p>

# Fibonacci
This program computes the Fibonacci sequence sum from a user-provided number. However, numbers that are above a certain threshold result in an arithmetic overflow error due to the limitations of the program and the MIPS architecture.

<b>Example Result</b>
```
Enter a number to compute the Fibonacci: 20
6765
```

# Max Number in Array
This program calculates the maximum number along with the average in a list. List elements are provided in the script and a loop is used to iterate through the list.

<b>Program Input</b>
```asm
.data
  list: .word 3, 6, 23, 6, 92, 2, 2, 5, 12, 76
  size: .word 10

  (...)
```
<b>Program Output</b>
```
The max number of the list is: 92
The average of the list is: 22
```

# How to Run
You can run these programs by using the free MARS MIPS Simulator found on the Missouri State University website [here](https://courses.missouristate.edu/kenvollmar/mars/download.htm).  

<b>Program Execution</b>
1. After opening the software, navigate to `File -> Open ...` and then select the `.asm` file downloaded from this repository.
2. Click `Run -> Assemble` to compile the program.
3. Press the green "Play" button. Alternatively, you can use `Run -> Go` or the F5 function key.

<b>Notice</b>
The simulator requires the Java Runtime Environment to run, so make sure that you have that installed.  
