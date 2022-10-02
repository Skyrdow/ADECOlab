.data
	preg1: .asciiz "Secuencia de collatz\nIngrese el numero: "
.text
main:
	# direccion de memoria para guardar
	li $s1, 0x100100A0
	# 1 para comparar
	li $s2, 1
	
	# obtener el numero
	li $v0, 4
	la $a0, preg1
	syscall       	
	li $v0, 5
       	syscall
       	# se guarda el valor en $a1
       	move $a1, $v0
       	# se guarda el primer numero de la secuencia
	jal guardarVal
       	
       	# se revisa que $a1 no sea 1
	beq $a1, $s2, end
	ciclo:
		# calcular collatz de $a1, retornado en $v1
		jal collatz
		# se mueve el resultado a $a1
		add $a1, $v1, $zero
		jal guardarVal
		# si el valor calculado es 1 la secuencia esta completa
		beq $a1, $s2, end
		# si no es 1, se repite
		b ciclo
	
end:
	li $v0, 10
	syscall
	
guardarVal:
	# se usa $a1 para el valor a memoria
	# se usa $s1 para el contador de posicion en memoria, se aumenta automaticamente
	sw $a1, ($s1)
	addi $s1, $s1, 4
	jr $ra
	
collatz:
	# $a1 para entrada
	# $v1 para retorno
	
	#revisar par
	li $t0, 2
	div $a1, $t0
	# resto de la division x / 2
	mfhi $t0
	# si es par salta, sino sigue
	beqz $t0, collatzPar
	# collatzImpar 3x + 1
	li $t0, 3
	mul $v1, $a1, $t0
	addi $v1, $v1, 1
	jr $ra

collatzPar:
	# division por bitshift x/2
	sra $v1, $a1, 1
	jr $ra
	
	
	
	
