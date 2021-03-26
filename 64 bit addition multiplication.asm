.data
msg1: .asciiz "Enter 4 unsigned numbers:"
msg2: .asciiz "\nFirst integer, A = "
msg3: .asciiz "\nSecond integer, B = "
msg4: .asciiz "\nThird integer, C = "
msg5: .asciiz "\nFourth integer, D = "
A: .space 13
B: .space 13
C: .space 13
D: .space 13
msg6: .asciiz "\n\nThe result: "
msg7: .asciiz "\n = "

.text
li $v0,4
la $a0,msg1
syscall 
li $v0,4
la $a0,msg2
syscall 
li $v0,8 
la $a0,A
li $a1,12
syscall
jal NumStr
move $s0,$v0
li $v0,4
la $a0,msg3
syscall # print msg3
li $v0,8 # input B
la $a0,B
li $a1,12
syscall
jal NumStr
move $s1,$v0
li $v0,4
la $a0,msg4
syscall # print msg4
li $v0,8 # input C
la $a0,C
li $a1,12
syscall
jal NumStr
move $s2,$v0
li $v0,4
la $a0,msg5
syscall # print msg5
li $v0,8 # input D
la $a0,D
li $a1,12
syscall
jal NumStr
move $s3,$v0
move $a0,$s0 # Function Arguments
move $a1,$s1
move $a2,$s2
move $a3,$s3
jal RealFunc # Function RealFunc is called 
move $t8,$v0 # Restore results from function
move $t9,$v1
li $v0,4
la $a0,msg6
syscall # print msg6
li $v0,1
move $a0,$t8
syscall # print MSB of result as decimal
li $v0,1
move $a0,$t9
syscall # print LSB of result as decimal
li $v0,4
la $a0,msg7
syscall #print msg7
li $v0,34
move $a0,$t8
syscall # print MSB of result as hexadecimal
li $v0,34
move $a0,$t9
syscall # print LSB of result as hexadecimal
li $v0,10
syscall # end program
#--Function Implementation----
RealFunc: multu $a0,$a1 # unsigned A*B
mfhi $t0
mflo $t1 # assigning $t0 as high and $t0 as low in A*B
multu $a2,$a3 # unsigned C*D
mfhi $t2
mflo $t3 # assigning $t0 as high and $t0 as low in C*D
addu $t7,$t1,$t3 # unsigned addition of LSB
not $t4,$t1 # bitwise inversion of the binary value in $t1
sltu $t5,$t4,$t3 # check for overflow in unsigned addition of LSB
addu $t6,$t5,$t0 # unsigned addition of first MSB and overflow bit
addu $t6,$t6,$t2 # unsigned addition of second MSB
move $v0,$t6
move $v1,$t7
jr $ra
#--Conversion of integer msging to unsigned integer
NumStr: addiu $t1,$zero,48 #add immidiate unsigned without overflow
addiu $t2,$zero,57 #check whether the msging input falls under the ASCII value range for numbers or not
addiu $t3,$zero,10
addu $t4,$zero,$zero
theLoop: lb $t5,($a0) # loading a single byte of the msging
bltu $t5,$t1,exit
bgtu $t5,$t2,exit # checking if the input is valid
multu $t4,$t3
mflo $t4
subiu $t5,$t5,48 # generating single integer
addu $t4,$t4,$t5 # generating the whole unsigned integer
addiu $a0,$a0,1 # incrementing to the next byte of the msging
j theLoop
exit: move $v0,$t4 #moving value of $t4 into $v0
jr $ra # returning back to the main function
