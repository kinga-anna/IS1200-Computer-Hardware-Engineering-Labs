  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0,0		# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
  #
hexasc:	andi	$a0,$a0,0xF	#discards everything except for the 4 least significant bits
	slti	$t0,$a0,0xA	#returns 1 for $a0=1..9, otherwise 0
	beq	$t0,$0,chars	#if $t0==0 skips to chars
	addi	$v0,$a0,0x30	#add 0x30 for correct ascii value
	jr	$ra

chars:	addi	$v0,$a0,0x37	#adds 0x37 for correct ascii value
	jr	$ra