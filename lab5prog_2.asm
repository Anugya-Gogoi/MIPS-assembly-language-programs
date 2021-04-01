#Implement the function into MIPS assembly code. If you need to use registers $t0 through $t7, use the lower-numbered registers first. The code for the function is as follows:
#int add (int n)
#{
#if (n < 1)
#return 1;
#else
#return (n + add(n/2));
#}


.data
str: .asciiz "Enter any number: "

.text
li $v0,4
la $a0,str
syscall # print str
li $v0,5
syscall # take integer input
add $a0,$v0,$zero # move to $a0
jal addition # call addition function
add $s0,$zero,$v0 # move to $s0
add $a0,$zero,$s0 # move to $a0
li $v0,1
syscall # print result integer
li $v0, 10
syscall # end the program

addition: 
addi $sp,$sp,-8 # modify stack pointer to accommodate 2 bytes
sw $ra,0($sp) # store return address in stack
sw $s0,4($sp) # store requisite value
add $s0,$a0,$zero # move to $s0
addi $t0,$zero,1 # store value 1 in $t0
blt $s0,$t0,ret1 # compare and jump if the value of $s0 is less than $t0
div $a0,$s0,2 # divide value in $s0 by 2 and store result in $a0
jal addition # call addition function recursively
add $v0,$v0,$s0 # add $s0 to $v0
addExit: 
lw $ra,0($sp) # restore return address
lw $s0,4($sp) # restore requisite value
addi $sp,$sp,8 # restore stack pointer
jr $ra # return back
ret1: 
li $v0,1 # load 1 to $v0
j addExit # jump to addExit
