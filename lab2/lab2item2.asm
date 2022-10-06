.data
	x0: .double 1.0
	double2: .double 2.0
	mensaje1: .asciiz "Ax: "
	mensaje2: .asciiz "Bx: "
	mensaje3: .asciiz "Ay: "
	mensaje4: .asciiz "By: "
	mensaje5: .asciiz "Az: "
	mensaje6: .asciiz "Bz: "
.text
main:
  	
	jal obtVector
	mtc1.d $v1, $f10
  	cvt.d.w $f10, $f10
  	
  	addi $sp, $sp, -4 # reservar stack
  	sw $ra, 0($sp)	# guardar $ra en stack
	jal newton
	
	li $v0, 3
	mov.d $f12, $f2
	syscall
	
	li $v0, 10
	syscall
	
obtVector:
       	# Obtener Ax
       	li $v0, 4
       	la $a0, mensaje1
       	syscall
       	
       	li $v0, 5
       	syscall
       	move $t1, $v0
       	
       	# Obtener Bx
       	li $v0, 4
       	la $a0, mensaje2
       	syscall
       	
       	li $v0, 5
       	syscall
       	move $t2, $v0
       	
       	# (Ax - Bx) **2
       	sub $t1, $t1, $t2
       	mul $t0, $t1, $t1
       	
       	# Obtener Ay
       	li $v0, 4
       	la $a0, mensaje3
       	syscall
       	
       	li $v0, 5
       	syscall
       	move $t1, $v0
       	
       	# Obtener By
       	li $v0, 4
       	la $a0, mensaje4
       	syscall
       	
       	li $v0, 5
       	syscall
       	move $t2, $v0
       	
       	sub $t1, $t1, $t2
       	mul $t1, $t1, $t1
       	add $t0, $t0, $t1
	
       	# Obtener Az
       	li $v0, 4
       	la $a0, mensaje5
       	syscall
       	
       	li $v0, 5
       	syscall
       	move $t1, $v0
       	
       	# Obtener Bz
       	li $v0, 4
       	la $a0, mensaje6
       	syscall
       	
       	li $v0, 5
       	syscall
       	move $t2, $v0
       	
       	sub $t1, $t1, $t2
       	mul $t1, $t1, $t1
       	# resultado -> $v1
       	add $v1, $t0, $t1
       	
       	jr $ra
       	
# $f10 entrada/ $f2 salida
# $t0 iterador
newton:
  	addi $sp, $sp, -4 # reservar stack
  	sw $ra, 0($sp)	# guardar $ra para volver a main en stack
  	
	# X0 = 1
	ldc1 $f2, x0
	# 2 constante
	ldc1 $f4, double2
	# iterador = 7
	li $t0, 7
	
	jal newtonIt
	
       	lw $ra, 0($sp) # cargar stack
       	addi $sp, $sp, 4 # limpiar stack
       	jr $ra
	
newtonIt:
	# $f6 = (X*X - $f2) / 2*X
	# X*X
	mul.d $f6, $f2, $f2
	# (X*X - $f2)
	sub.d $f6, $f6, $f10
	# 2*X
	mul.d $f8, $f2, $f4
	# (X*X - $f2) / 2*X
	div.d $f6, $f6, $f8
	# $f2 = X - (X*X - $f2) / 2*X
	sub.d $f2, $f2, $f6
	
	# mod. iterador
	subi $t0, $t0, 1
	bnez $t0, newtonIt
	
	jr $ra
	
