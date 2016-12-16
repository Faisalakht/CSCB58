	.data
ispsq:	.asciiz " is a perfect square, its square root is "
isnotsq: .asciiz " is not a perfect square \n"
prompt:	.asciiz "Enter a number: "
nline:	.asciiz "\n"
	.text
main:
	li $v0,4	#Shows the string "Enter a number: "
	la $a0,prompt
	syscall
	li $v0,5	#Reads an integer
	syscall
	move $s0,$v0	#Moves the integer to $s0
	li $s1,1	#Sets the $s1 to 1
subcall:
	beq $s2,$s0, prsq	#Checks if the $s2 is equal o the userinput
	addi $s1,$s1,1	#Increments the counter
	blt $s2,$s0, square	#If the square number is less then the input number then it square it agian
	bge $s2,$s0, finished	#If its the square number is greater than the input number then it will go to the finised
	li $v0,10	#Exits the Program
	syscall

prsq:
	li $v0,1	#Prints the integer
	move $a0,$s0	#Loads the number into $a0
	syscall
	li $v0,4	#Prints the string it is a perfect number, its squareroot is 
	la $a0,ispsq
	syscall
	li $v0,1	#Prints the square root numer
	move $a0,$s1
	syscall
	li $v0,4	#Prints new line to make it look clean
	la $a0,nline
	syscall
	li $v0,10	#Exits the program
	syscall

finished:
	li $v0,1	#Prints the integer
	move $a0,$s0	#Puts the number into $a0
	syscall
	li $v0,4
	la $a0,isnotsq	#Prints the string is not a perfect square
	syscall
	li $v0,10 #Exits the program
	syscall

square:
	mult $s1,$s1	#Multiplies the number by itself
	mflo $s2	#Get the lo number
	b subcall	#Jumps to subcall
	
