#Implement the following C code in MIPS assembly. Optimize the total number of MIPS instructions needed to execute the function.
#int fib (int n)
#{
#if (n == 0)
#return 0;
#else if (n == 1)
#return 1;
#else
#return fib(n – 1) + fib(n – 2);
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
jal fibFunc # call fibFunc function
add $s0,$v0,$zero # move to $s0
add $a0,$zero,$s0 # move to $a0
li $v0,1
syscall # print result integer
li $v0, 10
syscall # end the program
#-------------Function-------------
fibFunc: 
addi $sp,$sp,-12 # modify stack pointer to accommodate 3 bytes
sw $ra,0($sp) # store return address in stack
sw $s0,4($sp) # store requisite values
sw $s1,8($sp)
add $s0,$a0,$zero # move to $s0
addi $t0,$zero,1 # store value 1 in $t0
beq $s0,$zero,ret0 # compare equality with 0
beq $s0,$t0,ret1 # compare equality with 1
addi $a0,$s0,-1 # decrement by 1
jal fibFunc # call fibFunc function recursively
add $s1,$zero,$v0 # move to $s1
addi $a0,$s0,-2 # decrement by 2
jal fibFunc # call fibFunc function
add $v0,$v0,$s1 # add $s0 to $v0

fibExit: 
lw $ra,0($sp) # restore return address
lw $s0,4($sp) # restore requisite values
lw $s1,8($sp)
addi $sp,$sp,12 # restore stack pointer
jr $ra # return back

ret1: 
li $v0,1 # load 1 to $v0
j fibExit # jump to fibExit

ret0: 
li $v0,0 # load 0 to $v0
j fibExit # jump to fibExit
