.code32

.section .data



# Sezione delle istruzioni
.section .text



.global end



# Funzione END
#
# Esce dal programma.
#
.type end, @function



end:

	# Carica nel registro EAX il valore 1.
	#
	movl $1, %eax

	# Carica nel registro EBX il valore 0
	# che rappresenta il codice di ritorno
	# al sistema operativo.
	#
	xorl %ebx, %ebx

	# Chiama l'interrupt 0x80.
	#
	int $0x80
