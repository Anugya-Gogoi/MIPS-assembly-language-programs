#Implement the function in MIPS.
#int sum (int n, int acc)
#{
#if (n > 1)
#return sum(n – 2, acc + n);
#else
#return acc;
#}



.data
str1: .asciiz "Enter 1st number: "
str2: .asciiz "Enter 2nd number: "
str3: .asciiz "Sum = "

.text
li $v0,4
la $a0,str1
syscall # print str1
li $v0,5
syscall # take integer input
add $s0,$v0,$zero # move to $s0
li $v0,4
la $a0,str2
syscall # print str2
li $v0,5
syscall # take integer input
add $s1,$v0,$zero # move to $s1
move $a0,$s0 # move to $a0
move $a1,$s1 # move to $a1
jal sum # call sum function
add $s3,$zero,$v0 # move to $s3
li $v0,4
la $a0,str3
syscall # print str3
add $a0,$zero,$s3
li $v0,1
syscall # print result integer
li $v0,10
syscall # end the program

sum: 
beq $a0, $zero, exitFunc # go to exitFunc if n is 0
add $a1, $a1, $a0 # add n to acc
addi $a0, $a0, -1 # subtract 1 from n
j sum # go to sum

exitFunc:
move $v0, $a1 # return value acc
jr $ra # return to caller

