	.data
sstring: .space 500	#Source String space 500 bytes
qstring: .space 500	#Query string space 500 bytes
rstring: .space 500	#Replacement string 500 bytes
querystr:	.asciiz "Query String: "
replacestr:	.asciiz "Replace String: "
sourcestr:	.asciiz "Source String: "
nline:	.asciiz "\n"
	.text

main:

	li $s7,0	#Tracker for the number of characters in
	li $v0,4	#Shows the sting "Source String: "
	la $a0,sourcestr
	syscall
	li $v0,8	#Takes in the source string
	la $a0,sstring
	syscall
	la $s0,($a0)	#Saves the address in $s0
	li $v0,4	#Shows the sting "Query String: "
	la $a0,querystr
	syscall
	li $v0,8	#Takes in the query string
	la $a0,qstring
	syscall
	la $s1,($a0)	#Saves the address in $s1
	la $s3,($s1)	#Makes copy of $s1 and saves in $s3
	li $v0,4	#Shows the sting "Replace String: "
	la $a0,replacestr
	syscall
	li $v0,8	#Takes in Replacement string input
	la $a0,rstring
	syscall
	la $s2,($a0)	#Saves the address in $s2
	la $s4,($s2)	#Makes a copy of $s4 in $s4
	j finder 	#Jumps to the finder

jmpr:
	lb $t2,($s2) 	#Sets the first byte of the replacement string intp $t2
	beq $t2,10,reset	#When the replacement string finishes it goes to reset
	li $v0,11	#Prints character of the replacement string
	la $a0,($t2)	#Loads the address of the byten into $a0
	syscall
	addi $s2,$s2,1	#Moves to the next byte of the replacement string
	j jmpr	#Jumps back to the top of the loop

reset:
	la $s2,($s4)	#Resets the pointer for replacement string
	la $s1,($s3)	#Resets the pointer for the query sting
	j finder	#Jumps to the finder function
finder:
	lb $t0,($s0)	#Checks to the first byte of the souce string isnt empty
	beq $t0,10,done	#When the source strings ends it will finish
	lb $t1,($s1)	#First byte for the query string
	beq $t0,$t1, modifystr	#Checks if the source byte and the query byte are the same
	li $v0,11	#Prints the source byte
	la $a0,($t0)
	syscall
	addi $s0,$s0,1 #Moves to the next source byte
	j finder	#Jumps back to the finder 



modifystr:
	beq $t1,10,jmpr	#Checks if the query string is finished
	beq $t1,$t0,loop1 #Checks the character of the word match with the source string
	j adder #jumps to the adder function that adds the rest of the string



adder:
	subu $s0,$s0,$s7 #Shifts back the source string index by the tracker($s7)
checker:
	beq $s7,$zero,finder	#When $s7 is 0 then jumps to the finder
	lb $t0,($s0)	#Loads the byte from souce string
	addi $s0,$s0,1	#Moves the source string by one index forward
	li $v0,11	#Prints the character that was stored in $t0
	la $a0,($t0)
	syscall
	addiu $s7,$s7,-1 #Subtracts 1 from the tracker since the source string moved one index forward
	j checker	#jumps to the checker

	

loop1:
	addi $s7,$s7,1	#Increase the tracker by 1
	addi $s0,$s0,1	#Moves the source string index by 1
	addi $s1,$s1,1	#Moves the query string index by 1
	lb $t1, ($s1)	#Loads byte from source string
	lb $t0, ($s0)	#Loads byte from the query string
	j modifystr	#jumps to the modifystr
	 



done:
	li $v0,4
	la $a0,nline	#New line add the end
	syscall
	li $v0,10	#Exit the program
	syscall
