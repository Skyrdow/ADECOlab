.data
	m: .space 108
	texto1: .asciiz "X: "
	texto2: .asciiz "Y: "
	texto3: .asciiz "Z: "
	espacio: .asciiz " "
	multPrompt: .asciiz "\nIngrese escalar S: "
	escPrompt1: .asciiz "\nIngrese X: "
	escPrompt2: .asciiz "\nIngrese Y: "
	escPrompt3: .asciiz "\nIngrese Z: "
.text
	main:
		la $s0, m($zero)
		jal item1
		jal item2
		jal item3
	
		li $v0, 10
		syscall
	
	item1:
		# X1 + X2
        	li $v0, 4
        	la $a0, texto1
        	syscall
        
        	li $v0, 1
	        lw $t0, ($s0)
        	lw $t1, 20($s0)
	        add $a0, $t0, $t1
        	syscall
        
	        li $v0, 4
        	la $a0, espacio
	        syscall
        
        
		# Y1 + Y2
        	li $v0, 4
        	la $a0, texto2
        	syscall
        
        	li $v0, 1
        	lw $t0, 4($s0)
        	lw $t1, 24($s0)
        	add $a0, $t0, $t1
        	syscall
        
        	li $v0, 4
        	la $a0, espacio
        	syscall
        
        
		# Z1 + Z2
        	li $v0, 4
        	la $a0, texto3
        	syscall
        
        	li $v0, 1
        	lw $t0, 8($s0)
        	lw $t1, 28($s0)
        	add $a0, $t0, $t1
        	syscall
        	
        	# volver
        	jr $ra
        	
        item2:
        	# Obtener S
        	li $v0, 4
        	la $a0, multPrompt
        	syscall
        	
        	li $v0, 5
        	syscall
        	move $s1, $v0
        	
		# X * S
        	li $v0, 4
        	la $a0, texto1
        	syscall
        
        	li $v0, 1
	        lw $t0, 64($s0)
	        mul $a0, $t0, $s1
        	syscall
        
	        li $v0, 4
        	la $a0, espacio
	        syscall
        
        
		# Y * S
        	li $v0, 4
        	la $a0, texto2
        	syscall
        
        	li $v0, 1
	        lw $t0, 68($s0)
	        mul $a0, $t0, $s1
        	syscall
        
        	li $v0, 4
        	la $a0, espacio
        	syscall
        
        
		# Z * S
        	li $v0, 4
        	la $a0, texto3
        	syscall
        
        	li $v0, 1
	        lw $t0, 72($s0)
	        mul $a0, $t0, $s1
        	syscall
        	
        	# volver
        	jr $ra

        item3:
		# X * A
        	# Obtener A
        	li $v0, 4
        	la $a0, escPrompt1
        	syscall
        	
        	li $v0, 5
        	syscall
        	move $s1, $v0
        	
        	# Calculos
	        lw $t0, 96($s0)
	        mul $s2, $t0, $s1
	        
	        
		# Y * B
        	# Obtener B
        	li $v0, 4
        	la $a0, escPrompt2
        	syscall
        	
        	li $v0, 5
        	syscall
        	move $s1, $v0
        	
        	# Calculos
	        lw $t0, 100($s0)
	        mul $s3, $t0, $s1
        	
        	
		# Z * C
        	# Obtener C
        	li $v0, 4
        	la $a0, escPrompt3
        	syscall
        	
        	li $v0, 5
        	syscall
        	move $s1, $v0
        	
        	# Calculos
	        lw $t0, 104($s0)
	        mul $s4, $t0, $s1
        	
        	# X:
        	li $v0, 4
        	la $a0, texto1
        	syscall
        	
        	li $v0, 1
        	add $a0, $s2, $zero
        	syscall
        	
        	# espacio
	        li $v0, 4
        	la $a0, espacio
	        syscall
        	
        	# Y:
        	li $v0, 4
        	la $a0, texto2
        	syscall
        	
        	li $v0, 1
        	add $a0, $s3, $zero
        	syscall
        	
        	# espacio
	        li $v0, 4
        	la $a0, espacio
	        syscall      
	          	
        	# Z:
        	li $v0, 4
        	la $a0, texto3
        	syscall
        	
        	li $v0, 1
        	add $a0, $s4, $zero
        	syscall
        	
        	# volver
        	jr $ra