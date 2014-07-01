.code32

# Sezione delle variabili globali e costanti
.section .data



# Sezione delle istruzioni
.section .text



.global printf



# Stampa una stringa
# ricevuta tramite registro ecx
.type printf, @function



printf:

    	pushl %ebp

	movl %esp, %ebp

   	# conservo eax per l'esecuzione corretta del programma
	pushl %eax

    	# azzero edx che funge da contatore caratteri
	xorl %edx, %edx

count_c:

	# sposta il contenuto puntato da ecx e edx negli
	# 8 bit a sinistra di eax (quindi in al)
	movb (%ecx, %edx), %al

    	# al vale 0?
	testb %al ,%al

	# si, allora ho finito di contare
	jz count_c_end
	
    	# no, Incrementa edx
	incl %edx

    	
	# ricomincio a contare
	jmp count_c

count_c_end:

    
	# 4 in eax per la system call write()
	movl $4, %eax

	
	# 1 in ebx per reindirizzare allo standard output
	movl $1, %ebx

	# in ecx c'e' la stringa da stampare,
	# in edx la lunghezza della stringa
	int $0x80
	
    	# ripristino eax
	popl %eax

	movl %ebp, %esp
	popl %ebp

    	ret
