.code32

# variabili globali e costanti
.section .data



msg_new_line:
	.string "\n"



# Sezione delle istruzioni
.section .text



.global new_line



# Funzione NEW_LINE
#
# Stampa a video il carattere di new_line.
#
.type new_line, @function



new_line:

	# Carica nel registro ECX
	# l'indirizzo della stringa msg_new_line.
	#
	leal msg_new_line, %ecx

	# Chiama la funzione print
	# cha stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta new_line_end
	# che restituisce il controllo alla funzione chiamante.
	#
    jmp new_line_end

new_line_end:

    ret
