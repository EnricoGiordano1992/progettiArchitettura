.code32

.bss

key:
    .string ""

# Sezione delle variabili globali e costanti
.section .data

string_input:
	.string "     > "

key_length:
    .long 0

string_reset_pressione:
	.string "          Pressione gomme resettata\n"

reset_tire_pressure:
    .long 0

string_error:
	.string "errore; inserire i caratteri ammissibili\nr (select)\n"


.section .text



.global reset_pressione



# Funzione reset_pressione
#
# reset con tasto r
.type reset_pressione, @function



reset_pressione:

get_key:
	# mi preparo a stampare string_input
	leal string_input, %ecx

	call printf

	# eseguo la funzione read() da tastiera di 2 caratteri e memorizzo
	# cio' che ho letto in key
	movl $3, %eax

	movl $0, %ebx

	leal key, %ecx

	movl $2, %edx

	int $0x80

	# salvo la lunghezza della stringa
    	movl %eax, (key_length)

	# ho letto 2 caratteri ?
    	cmpb $2, %al

	# ne ho letti meno, allora finisco l'esecuzione
	jl reset_pressione_end

	# si, allora controllo se ho letto R
    	je compare_key_R
	
	# no, errore
    	jmp get_error

get_error:

	call print_string_error

	# fine esecuzione
	jmp reset_pressione_end

compare_key_R:

	# leggo il primo carattere spostandolo in eax
    	movl (%ecx), %eax

	# ho letto R?
	cmpb $82, %al

	# si, allora devo leggere \n
    	je compare_new_line

    	# no, ho letto R?
	cmpb $114, %al

	# si, allora devo leggere \n
    	je compare_new_line

	# no, allora stampo errore e rieseguo la lettura

	leal string_error, %ecx
    	call printf

	jmp get_key

compare_new_line:

	# leggo il secondo carattere
	movl 1(%ecx), %eax

	# ho letto \n?
	cmpb $10, %al

	# si, allora eseguo il reset
    	je print_string_reset_pressione

	# no, allora termino
	jmp reset_pressione_end

print_string_reset_pressione:

	# mi preparo a stampare string_reset_pressione
	leal string_reset_pressione, %ecx

    call printf

reset_pressione_end:

    ret
