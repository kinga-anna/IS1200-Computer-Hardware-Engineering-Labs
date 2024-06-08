.text

	addi $a0,$0,3		#a0=n
	add $v0,$0,$a0		#v0=a0
	beq $a0,$0,zero		#if a0==0 done
loop:	add $a3,$0,$v0		#a3=a0 -> this will be the current value we're adding to the answer (first n, n-1, ...)
	addi $a0,$a0,-1		#a0-- -> n=n-1
	beq $a0,$0,done		#if a0==0 done, else continue
	add $a1,$a0,$0		#a1=a0
inner:  addi $a1,$a1,-1		#a1-- -> we go over this inner loop a1 amount of times for every outer loop iteration
	beq $a1,$0,loop		#if a1==0 go to outer loop, else continue inner
	add $v0,$v0,$a3		#v0=v0+a3	
	beq $0,$0,inner		#jump to inner
zero:	addi $v0,$0,1		#if n=0 the answer should be 1
done:	beq $0,$0,done		#unconditional jump
