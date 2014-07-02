.code32

.bss

key:
    .string ""

output_temp:
    .long 1

# variabili globali e costanti
.section .data


string_error:
	.string "errore; inserire i caratteri ammissibili\nd, d (su), e (giu'), r (select)\n"

string_input:
	.string "     > "

key_to_long:
    .long 0

.section .text

.global compare_key

# stampa comprende il carattere letto (D,d,E,e,R,r)
.type compare_key, @function



compare_key:

    	pushl %ebp
	movl %esp, %ebp


    	movl (%ecx), %eax

    	# e' il carattere D?
	cmpb $68, %al

    	# si, allora mi assicuro che dopo ci sia \n
    	je compare_new_line


    	# e' il carattere d?
	cmpb $100, %al

    	# si, allora mi assicuro che dopo ci sia \n
    	je compare_new_line

    	# e' il carattere E?
	cmpb $69, %al

    	# si, allora mi assicuro che dopo ci sia \n
    	je compare_new_line


     	# e' il carattere e?
	cmpb $101, %al

    	# si, allora mi assicuro che dopo ci sia \n
    	je compare_new_line


     	# e' il carattere R?
	cmpb $82, %al

    	# si, allora mi assicuro che dopo ci sia \n
    	je compare_new_line


     	# e' il carattere r?
	cmpb $114, %al

    	# si, allora mi assicuro che dopo ci sia \n
    	je compare_new_line


    	# no, allora si chiede di inserire il carattere giusto
	leal string_error, %ecx
    	call printf

	#movl $1, %edx

	jmp end_function

compare_new_line:

	mov %al, output_temp
    	# metto il carattere successivo in eax
	movl 1(%ecx), %eax

    	# ho letto \n?
	cmpb $10, %al

	#si, allora setto il nuovo valore (nella funzione chiamante)

	movl $2, %edx    
    	jmp end_function

    
    	# no, allora si chiede di inserire il carattere giusto
	leal string_error, %ecx
    	call printf

	movl $1, %edx
	movl %edx, output_temp

end_function:

	movl output_temp, %edx
	movl %ebp, %esp
	popl %ebp

    	ret
