.data
	resultado: .space 12
	inputMessage: .asciiz "Ingrese un entero: "
	outputMessage: .asciiz "El resultado de la división es: "
	indefMessage: .asciiz "INDEFINIDO"
	salto: .asciiz "\n"
	punto: .asciiz "."
	signo: .asciiz "-"
.text

main:
	# Se crea un contador global y un puntero
	# que ayudará a guardar los valores de la parte entera, décima y centésima
	addi $s0, $zero, 0	# CONTADOR
	addi $s1, $zero, 0	# PUNTERO
	
	li $v0, 4
	la $a0, inputMessage	# Se imprime el mensaje para solicitar un número
	syscall
	
	li $v0, 5		# Se pide el valor de X por consola
	syscall
	
	# Movemos el valor del dividendo X al registro $s2
	move $s2, $v0
	
	li $v0, 4
	la $a0, inputMessage	# Se imprime el mensaje para solicitar el segundo número
	syscall
	
	li $v0, 5		# Se pide el valor de X por consola
	syscall
	
	# Movemos el valor del divisor Y al registro $s3
	move $s3, $v0
	
	# Creamos un contadores y acumuladores
	addi $t0, $zero, 0	# CONTADOR (cuántas veces cabe) (t2=0)
	addi $t1, $zero, 0	# ACUMULADOR (t1=0)
	abs $t2, $s2		# RESTO ($t2 = X)
	abs $t3, $s2		# DIVIDENDO TEMPORAL ($t3 = X)
	abs $s4, $s3		# Valor absoluto del DIVISOR
	
	
	
	jal division
	
	li $v0, 4
	la $a0, outputMessage
	syscall
	
	jal casos
	
	addi $s1, $zero, 0	# PUNTERO
	
	li $v0, 1
	lw $a0, resultado($s1)
	syscall
	
	addi $s1, $s1, 4	# Se mueve el puntero una posición
	
	li $v0, 4
	la $a0, punto
	syscall
	
	li $v0, 1
	lw $a0, resultado($s1)
	syscall
	
	addi $s1, $s1, 4	# Se mueve el puntero una posición
	
	li $v0, 1
	lw $a0, resultado($s1)
	syscall
	
	li $v0, 10
	syscall
	
division:
	beq $s0, 3, exit	# Se comprueba si ya se terminó de dividir
	
	add $t1, $t1, $s4 	# Se suma el valor del divisor Y al acumulador
	sub $t2, $t2, $s4	# Se resta el valor del dividendo con el divisor (X-Y)
	bgt $t1, $t3, guardar	# Se comprueba si el ACUMULADOR es mayor al dividendo
	addi $t0, $t0, 1 	# Se incrementa el contador en 1
	
	beqz $s3, indefinido	# Verificamos si el divisor es igual a 0
	
	j division
	
guardar:
	sw $t0, resultado($s1)	# Se guarda el valor entero en la posición del puntero
	addi $s1, $s1, 4	# Se mueve el puntero una posición
	
	add $t2, $t2, $s4	# Se suma el valor del divisor al resto ya que quedó menor a 0
	addi $t0, $zero, 0	# Se reinicia el CONTADOR (cuántas veces cabe)
	addi $t1, $zero, 0	# Se reinicia el ACUMULADOR
	
	addi $s0, $s0, 1	# Se suma 1 al contador de la división
	
	addi $t4, $zero, 0	# ACUMULADOR MULTIPLICACION
	addi $t5, $zero, 9	# CONTADOR MULTIPLICACION
	add $t6, $t2, $zero 	# RESTO TEMPORAL (Usado para multiplicacion)
	j multiplicar
	
multiplicar:
	beq $t4, $t5, division
	
	add $t2, $t2, $t6
	addi $t4, $t4, 1
	addi $t3, $t2, 0
	
	j multiplicar
	
exit:
	jr $ra
	
casos:
	bltz $s2, caso1
	bgez $s2, caso2
	
caso1:
	bgtz $s3, signoNegativo
	
	jr $ra
	
caso2:
	bltz $s3, signoNegativo
	
	jr $ra
	
signoNegativo:
	li $v0, 4
	la $a0, signo
	syscall
	
	jr $ra
	
indefinido:
	li $v0, 4
	la $a0, indefMessage
	syscall

	li $v0, 10
	syscall 