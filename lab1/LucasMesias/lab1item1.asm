.data
	m: .space 108
	texto1: .asciiz "X: "
	texto2: .asciiz "Y: "
	texto3: .asciiz "Z: "
	espacio: .asciiz " "
	
.text
	# Cargar vector M en registro
	la $s0, m($zero)
	
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
       	