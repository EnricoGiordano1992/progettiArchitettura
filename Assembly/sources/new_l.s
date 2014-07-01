.code32

# variabili globali e costanti
.section .data



string_new_line:
	.string "\n"



# Sezione delle istruzioni
.section .text



.global new_l



# Stampa a video il carattere di new_line
.type new_l, @function



new_l:

	# Carica nel registro ECX
	# l'indirizzo della stringa string_new_line
	#
	leal string_new_line, %ecx

	# Chiama la funzione print
	# cha stampa una stringa passata nel registro ECX
	
    call printf

    ret
