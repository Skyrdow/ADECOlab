.data
	m: .space 108
	texto1: .asciiz "X: "
	texto2: .asciiz "Y: "
	texto3: .asciiz "Z: "
	espacio: .asciiz " "
	multPrompt: .asciiz "\nIngrese escalar S: "

.text
	# Cargar vector M en registro
	la $s0, m($zero)
	
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
        	