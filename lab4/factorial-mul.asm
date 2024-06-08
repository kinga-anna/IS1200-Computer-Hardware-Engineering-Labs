.text

	addi $a0,$0,4
	addi $a1,$0,0
	addi $v0,$0,1
loop:	beq $a0,$a1,done
	mul $a2,$a1,$v0
	add $v0,$v0,$a2
	addi $a1,$a1,1
	beq $0,$0,loop
done:	beq $0,$0,done