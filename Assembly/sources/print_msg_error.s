.code32

.section .data



msg_error:
	.string "Unrecognized key\n"



# Sezione delle istruzioni
.section .text



.global print_msg_error



# Funzione PRINT_MGS_ERROR
#
# Stampa a video un messaggio di errore.
#
.type print_msg_error, @function



print_msg_error:

	# Carica nel registro ECX
	# l'indirizzo della stringa msg_error.
	#
	leal msg_error, %ecx

	# Chiama la funzione print
	# cha stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_msg_error_end
	# che restituisce il controllo alla funzione chiamante.
	#
    jmp print_msg_error_end

print_msg_error_end:

    ret
