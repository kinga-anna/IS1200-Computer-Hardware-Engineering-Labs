  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #
	.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text more text lots of text\0"
	.text
	.global	delay
	.global time2string
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,1
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop
delay:	slt	$s0,$0,$a0	#1 if $a0>0, 0 otherwise
	beq	$s0,$0,delayend
	nop
	addi	$s3,$0,0x1
	sub	$a0,$a0,$s3	#sm = sm-1
	addi	$s1,$0,0	#i = 0
	addi	$s2,$0,0x1267	#4711
loop:	beq	$s1,$s2,delay
	nop
	addi	$s1,$s1,1
	j	loop
	nop
delayend:	jr	$ra
		nop

hexasc:	andi	$a0,$a0,0xF	#discards everything except for the 4 least significant bits
	slti	$t0,$a0,0xA	#returns 1 for $a0=1..9, otherwise 0
	beq	$t0,$0,chars	#if $t0==0 skips to chars
	nop
	addi	$v0,$a0,0x30	#add 0x30 for correct ascii value
	jr	$ra
	nop
chars:	addi	$v0,$a0,0x37	#adds 0x37 for correct ascii value
	jr	$ra
	nop



time2string:
	PUSH	$ra		#save return adress
	PUSH	$s0		#save $s-register to be used
	move	$s0,$a0		#saving $a0 into another register rather than the stack saves us time
	
	andi	$a0,$a1,0xF000	#extracts first digit
	srl	$a0,$a0,12
	jal	hexasc
	nop
	sb	$v0, ($s0)
	
	andi	$a0,$a1,0xF00	#extracts second digit
	srl	$a0,$a0,8
	jal	hexasc
	nop
	sb	$v0, 1($s0)
	li	$v0,0x3A	#writes a : into memory
	sb	$v0, 2($s0)
	
	andi	$a0,$a1,0xF0	#extracts third digit
	srl	$a0,$a0,4
	jal	hexasc
	nop
	sb	$v0, 3($s0)
	andi	$a0,$a1,0xF	#extracts last digit
	jal	hexasc
	nop
	sb	$v0, 4($s0)
	
	li	$v0,0x00	#writes the null byte
	sb	$v0, 5($s0)

	move	$a0,$s0
	POP	$s0
	POP	$ra
	jr	$ra
	nop
