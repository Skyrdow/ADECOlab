.data
	m: .space 108
	texto1: .asciiz "X: "
	texto2: .asciiz "Y: "
	texto3: .asciiz "Z: "
	espacio: .asciiz " "
	escPrompt1: .asciiz "\nIngrese X: "
	escPrompt2: .asciiz "\nIngrese Y: "
	escPrompt3: .asciiz "\nIngrese Z: "
	
.text
	# Cargar vector M en registro
	la $s0, m($zero)
	
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
