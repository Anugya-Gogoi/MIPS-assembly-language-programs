.data
msg: .asciiz "The input string must have less than 40 characters\n"
msg1: .asciiz "Enter the string: "
count: .space 40
str: .space 40
ch: .space 40
msg2: .asciiz "\nAfter compression: "
msg3: .asciiz "\nInvalid input"
msg4: .asciiz "\nInput characters are equal to or more than 40"
msg5: .asciiz " "

.text
li $v0, 4
la $a0, msg #print msg
syscall
li $v0, 4
la $a0, msg1 #print msg1
syscall
li $v0, 8
la $a0, str
li $a1, 91 #take input for str
syscall
la $a0, str #string to be operated is in a0
addi $a1, $zero, 0 #size of string
jal strlen #calling strlen function
move $s1, $v0 #size of string
bgt $s1, 40, overflowFunc
jal validity
#---initializing the count and char name arrays with 0 ---
li $t0, 0
addi $t0, $zero, 0
loop1:
bge $t0, 40, exit #if $t0>=40, then go to exit
sb $zero, count($t0) #initializing count[] ={0}
sb $zero, ch($t0) #initializing ch[] ={0}
addi $t0, $t0, 4 #i++
j loop1 #jump to loop1
exit:
jal compression #calling ComprStr function
#printing the compressed string
jal printVal
li $v0,10
syscall #end of the program
#---function to calculate the string length---
strlen:
lb $t0, 0($a0) #load the byte
beqz $t0, out #if branch is equal to Zero than go to out
addi $a1, $a1, 1
addi $a0, $a0, 1
j strlen #jump to strlen
out:
move $v0, $a1
jr $ra
#---Checking if the string input is valid or not(character or numaric value)----
validity:
li $t1, 0 #to keep track of the size of the string
li $t0, -1
#--Function to checking whether the present char and next char is equal or not ----
checking1:
addi $t1, $t1, 1
addi $t0, $t0,1
bge $t1, $s1,next
bge $t0, $s1, next
lb $t2, str($t0)
ble $t2, 64, invalidCase
bge $t2, 91, checking2
j checking1 #jump to checking1
checking2:
ble $t2, 96, invalidCase #if $t2<=96, then got to Break
bge $t2, 123, invalidCase # if $t2>=123, thhen go to Break
j checking1
next:
jr $ra
 # Function to compress string
compression:
addi $t0, $zero, -1 #i =-1 as incrementing of i is done below
addi $t2, $zero, 0 #t2=k
else:
addi $t2, $t2, 1 #k++
addi $t0, $t0, 1 #i++
loop2:
bgt $t0, 40, exitFunc
lb $s1, str($t0) # z=a[i]
 loop3:
addi $t1, $t0, 1 #j=i+1
lb $t3, str($t1) #t3=a[j]
lb $t4, count($t2) #t4=count[k]
addi $t4, $t4, 1 #count[k]+=1
sb $t4, count($t2) #count[k]+=1
sb $s1, ch($t2) #ch[k]=z
bne $t3, $s1, else
addi $t0, $t0, 1 #i++
j loop3
exitFunc:
jr $ra

 #Function to print the compressed string
printVal:
addi $t0, $zero, 1
la $a0, msg2
li $v0, 4
syscall

display:
bge $t0, 40, exitFunc2 #if $t0>=40 then go to exit
lb $a0, ch($t0) #load byte (sign extended in $a0)
ble $a0, 64, exitFunc2 #if $a0<=64 then go to exit
li $v0, 11 #prints character
syscall
lb $a0, count($t0)
beq $a0, 1, space #if character is already present then it won't print 1 with it
li $v0, 1 #prints integer
syscall
space:
li $v0, 4
la $a0, msg5 #print msg5
syscall
addi $t0, $t0, 1
j display
exitFunc2:
jr $ra
overflowFunc:
la $a0, msg4
li $v0, 4 #Prints msg4
syscall
invalidCase:
la $a0, msg3 #prints msg3
li $v0, 4
syscall 