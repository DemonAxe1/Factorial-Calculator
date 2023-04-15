#####################################################################
# Factorial			Programmer: Tarek Hisham Ahmed Fouad
# Due Date: 4/3/2023		
# Last Modified: 4/3/2023
#####################################################################
# Functional Description:
# This program takes input from the user and calcs the 
#factorial of that number
#####################################################################
# Pseudocode:
#	Take input from the user
#	enter a loop to check if the user input is 0 if not make calculations for the factorial
#	mult the user input with the solution register (starting at 1)
#	remove 1 from the user input then loop back to the start of the loop
#	
#	Print the solution when the user input gets to 0
# 
######################################################################
# Register Usage:
# $v0: used for system calls 
# $a0: Used to hold print addresses 
# $t2: Holds the solution of the multiplication
# $t1: Holds the user input and when we remove 1 every loop
######################################################################
.data
	#### Setting the string for the program
	prompt: .asciiz "Welcome to the Factorial Calculator!\nThis program calculates the factorial of the first 12 numbers!\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	str1: .asciiz "Enter number (Between 1-12): "
	str2: .ascii "The factorial for your number: "
	newline: .asciiz "\n"
	bye: .asciiz "Thank you! Goodbye!"

.text
main:
	li $s5, 5
	
	li $v0, 4
	la $a0, prompt
	syscall
start:
	li $t1, 0
	addi $t2, $zero, 1	#set t2 as 1 so when we multiply later it is not multiplying by 0
	li $v0, 4		#system call to print string
	la $a0, str1    	#Load address of str1 (user prompt)
	syscall
	
	li $v0, 5		#system call to read integer
	syscall
	move $t1, $v0		#move the user integer input into t2 so we can manipulate later
	
#find factorial function
findFactorial:
	mult $t1, $t2		#multiply the user input by 1. After the first loop the user input is going down by 1 and the t2 is the previous multiplication result
	mflo $t2		#this grabs the results of the multiplication
	subi $t1, $t1, 1	#this takes 1 away from the user int input 
	beqz $t1, factorialDone	#check if the user input is now 0, if 0 then we jump to print result 
	j findFactorial		#if not 0 then we loop findFactorial
	
factorialDone:
	#Display the results
	li $v0, 4		#system call to print string
	la $a0, str2		#load address of str2 to prompt the result
	syscall
	
	li $v0, 1		#system call to print integer
	move $a0, $t2		#move the results of the factorial into a0 to be printed
	syscall
	
	li $v0, 4		#system call to print string
	la $a0, newline		#load address for the new line
	syscall
	
	addi $t7, $t7, 1		#add 1 to our counter	
	bne $t7, $s5 start 	#loop back to start if t7 our counter is not 5
	
	li $v0, 4		#system call to print string
	la $a0, bye		#load adress of bye
	syscall
	#Tell the os that we are done with the program
	li $v0, 10	#system call to end program safe
	syscall
	
	
