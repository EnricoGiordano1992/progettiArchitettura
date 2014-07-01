.code32

.section .data

string_error:
	.string "valore non riconosciuto\n"

.section .text

.global print_string_error

# Stampa a video un messaggio di errore.
.type print_string_error, @function



print_string_error:

	# mi preparo a stampare il messaggio di errore
	leal string_error, %ecx

    	call printf

    	jmp print_string_error_end

print_string_error_end:

    	ret
