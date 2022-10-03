.data
	resultado: .space 12
	inputMessage: .asciiz "Ingrese un entero: "
	outputMessage: .asciiz "El resultado de la división es: "
	indefMessage: .asciiz "INDEFINIDO"
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
	
	li $v0, 5		# Se pide el valor de Y por consola
	syscall
	
	# Movemos el valor del divisor Y al registro $s3
	move $s3, $v0
	
	# Almacenamos el valor absoluto de X e Y según los procedimientos absX y absY
	jal absX
	jal absY
	
	# Creamos un contadores y acumuladores que se usarán para cada iteración de la división
	addi $t0, $zero, 0	# CONTADOR (cuántas veces cabe) (t0=0)
	addi $t1, $zero, 0	# ACUMULADOR (t1=0)
	
	jal division
	
	# Se imprime el mensaje que introduce el resultado de la división
	li $v0, 4
	la $a0, outputMessage
	syscall
	
	# Vemos en qué caso de división estamos
	jal casos
	
	# Se reinicia el valor de puntero para imprimir el resultado en consola
	addi $s1, $zero, 0
	
	# Se imprime la parte ENTERA del resultado
	li $v0, 1
	lw $a0, resultado($s1)	
	syscall
	
	addi $s1, $s1, 4	# Se mueve el puntero una posición
	
	# Se imprime el punto que se separa la parte entera de la decimal
	li $v0, 4
	la $a0, punto
	syscall
	
	# Se imprime la DÉCIMA
	li $v0, 1
	lw $a0, resultado($s1)
	syscall
	
	addi $s1, $s1, 4	# Se mueve el puntero una posición
	
	# Se imprime la CENTÉSIMA
	li $v0, 1
	lw $a0, resultado($s1)
	syscall
	
	# Se termina el programa
	li $v0, 10
	syscall
	
########################################## PROCEDIMIENTOS ########################################
	
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
	beq $t4, $t5, division	# Se verifica si el contador ha llegado a 9
	
	add $t2, $t2, $t6	# Se incrementa el valor de lo que será el próximo controlador del resto
	addi $t4, $t4, 1	# Se incrementa en 1 el valor del contador
	addi $t3, $t2, 0	# Se actualiza el valor del que será el próximo dividendo en cada iteración
	
	j multiplicar
	
exit:
	jr $ra			# Ayuda a vover al main una vez terminada la división
	
absX:
	bltz $s2, absXcaso1	# if X < 0
	bgez $s2, absXcaso2	# if X >= 0

absXcaso1:
	sub $t2, $zero, $s2	# Acumulador RESTO $t2 = (0 - X), cuando X < 0
	sub $t3, $zero, $s2	# Dividendo temporal $t3 = (0 - X), cuando X < 0
	
	jr $ra			# Regresa a main luego de linkear absX
	
absXcaso2:
	add $t2, $zero, $s2	# Acumulador RESTO $t2 = 0+X, cuando X >= 0
	add $t3, $zero, $s2	# Dividendo temporal $t3 = 0+X, cuando X >= 0
	
	jr $ra			# Regresa a main luego de linkear absX
	
absY:
	bltz $s3, absYcaso1	# if Y < 0
	bgez $s3, absYcaso2	# if Y >= 0
	
absYcaso1:
	sub $s4, $zero, $s3	# Valor absoluto divisor cuando Y < 0, $s4 = 0 - Y
	
	jr $ra			# Regresa a main luego de linkear asbY
	
absYcaso2:
	add $s4, $zero, $s3	# Valor absoluto divisor cuando Y > 0, $s4 = 0 + Y
	
	jr $ra			# Regresa a main luego de linkear absY
	
casos:
	bltz $s2, caso1		# if X < 0
	bgez $s2, caso2		# if X >= 0
	
caso1:
	bgtz $s3, signoNegativo	# if X/Y tiene signo negativo
	
	jr $ra			# Regresa a main si X/Y positivo
	
caso2:
	bltz $s3, signoNegativo	# if X/Y tiene signo negativo
	
	jr $ra			# Regresa a main si X/Y positivo
	
signoNegativo:
	li $v0, 4
	la $a0, signo		# Imprime el signo "-" si la división es negativa
	syscall
	
	jr $ra			# Regresa a main luego de linkear casos
	
indefinido:
	li $v0, 4
	la $a0, outputMessage	# Se imprime el mensaje que introduce el resultado de la división
	syscall

	li $v0, 4
	la $a0, indefMessage	# Imprime INDEFINIDO en consola si el divisor Y = 0
	syscall

	li $v0, 10		# Termina el programa
	syscall 
