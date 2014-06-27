.code32

# Sezione delle variabili globali e costanti
.section .data



# Sezione delle istruzioni
.section .text



.global print



# Funzione PRINT
#
# Stampa a video una stringa
# ricevuta nel registro ECX.
#
.type print, @function



print:

    # Salva il valore di EBP.
	#
    pushl %ebp

    # Muove lo Stack Pointer dove punta EBP.
	#
	movl %esp, %ebp

    # Salva EAX.
	#
	pushl %eax

    # Azzera EDX.
	#
	xorl %edx, %edx

count_char:

    # Somma a ECX il valore di EDX
	# e muove quello a cui punta in AL.
	#
	movb (%ecx, %edx), %al

    # Verifica che contenuto di AL non sia 0.
	#
	testb %al ,%al

    # Se in AL è contenuto il valore 0,
	# allora salta all'etichetta count_char_end,
	# che stampa a video la stringa.
	#
	jz count_char_end
	
    # Incrementa EDX.
	#
	incl %edx

    # Salta all'etichetta count_char,
	# che continua a scorrere la stringa.
	#
	jmp count_char

count_char_end:

    # Carica nel registro EAX il numero 4,
	# cioè il codice della funzione write().
	#
	movl $4, %eax

	# Carica nel registro EBX il numero 1,
	# identificatore dello standard output.
	#
	movl $1, %ebx

	# Nel registro ECX è già presente il puntatore
	# alla stringa da stampare.

	# Nel registro EDX è già presente la lunghezza
	# della stringa da stampare.

	# Chiama l'interrupt 0x80.
	#
	int $0x80
	
    # Ripristina il valore di EAX.
	#
	popl %eax

    # Riporta ESP nella sua posizione originaria.
	#
	movl %ebp, %esp

    # Ripristina il Base Pointer.
	#
	popl %ebp

    # Salta all'etichetta print_end,
	# che restituisce il controllo alla funzione
	# chiamante.
	#
    jmp print_end

print_end:

    ret