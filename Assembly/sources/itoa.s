.code32



# Sezione delle variabili globali e costanti
.section .data



car:
	.byte 0



# Sezione delle istruzioni
.section .text



.global itoa



# Funzione ITOA
#
# Converte un intero, caricato nel registro EAX,
# in una stringa
#
.type itoa, @function



itoa:

	# Carica il numero 0 in ECX
	mov $0, %ecx

continua_a_dividere:

	# Confronta 10 con il contenuto di EAX
	#
	cmp $10, %eax

	# Salta all'etichetta dividi se EAX è
    	# maggiore o uguale a 10
	#
	jge dividi

	# Salva nello stack il contenuto di EAX
	#
	pushl %eax

	# Incrementa di 1 il valore di ECX per
	# contare quante push esegue
	# Ad ogni push salva nello stack una cifra del
	# numero (a partire da quella meno significativa)
	#
	inc %ecx

	# Pone in EBX il valore di ECX
	#
	mov %ecx, %ebx

	# Salta all'etichetta stampa
	jmp stampa

dividi:

	# Carica 0 in EDX
	#
	movl $0, %edx

	# Carica 10 in EBX
	#
	movl $10, %ebx

	# Divide per EBX (10) il numero ottenuto concatenando
	# il contenuto di EDX e EAX (in questo caso EDX = 0)
	# Il quoziente viene messo in EAX, il resto in EDX
	divl %ebx

	# Salva il resto nello stack
	#
	pushl %edx

	# Incrementa il contatore delle cifre da stampare
	#
	inc %ecx

	# Salta all'etichetta continua_a_dividere
	#
	jmp continua_a_dividere

stampa:

	# Controlla se ci sono ancora caratteri da stampare
	#
	cmp $0, %ebx

	# Se EBX = 0 ha stampato tutto, quindi salta alla fine
	#          
	je fine_itoa

	# Preleva l'elemento da stampare dallo stack
	#
	popl %eax
  
	# Memorizza nella variabile car il valore contenuto
	# negli 8 bit meno significativi del registro EAX
	# Gli altri bit del registro non interessano
	# visto che una cifra decimale è contenuta in un solo byte
	#
	movb %al, car

	# Somma al valore car il codice ascii
	# del carattere 0 (zero)
	#
	addb $48, car

	# Decrementa di 1 il numero di cifre da stampare
	#
	dec %ebx

	# Salva il valore di BX nello stack poiché
	# per effettuare la stampa occorre modificare
	# i valori dei registri come richiesto
	# dalla funzione del sistema operativo write()
	#  
	pushw %bx

	# Carica nel registro EAX il numero 4,
	# cioè il codice della funzione write()
	#
	movl $4, %eax

	# Carica nel registro EBX il numero 1,
	# identificatore dello standard output
	#
	movl $1, %ebx

	# Caricare nel registro ECX il puntatore
	# alla stringa (in questo caso un carattere) da stampare
	#
	leal car, %ecx

	# Carica nel registro EDX la lunghezza
	# della stringa da stampare
	#
	mov $1, %edx

	# Chiama l'interrupt 0x80
	#
	int $0x80

	# Recupera il contatore dei caratteri da stampare
	# salvato nello stack prima della chiamata alla
	# funzione write()
	#
	pop %bx

	# Ritorna all'etichetta stampa per stampare il
	# prossimo carattere
	#
	jmp stampa

fine_itoa:

	# Copia nella variabile car il codice ascii del
	# carattere line feed (per andare a capo riga)
	#
	movb $10, car

	# Carica nel registro EAX il numero 4,
	# cioè il codice della funzione write()
	#
	movl $4, %eax

	# Carica nel registro EBX il numero 1,
	# identificatore dello standard output
	#
	movl $1, %ebx

	# Caricare nel registro ECX il puntatore
	# alla stringa (in questo caso un carattere) da stampare
	#
	leal car, %ecx

	# Carica nel registro EDX la lunghezza
	# della stringa da stampare
	#
	mov $1, %edx

	# Chiama l'interrupt 0x80
	#
	int $0x80

	ret
