.code32

.bss

key:
    .string ""



# variabili globali e costanti
.section .data



string_input:
	.string "     > "



key_length:
    .long 0



# BACK HOME

string_backhome_actual_on:
	.string "          Impostazione corrente: Back-home: ON\n"

string_backhome_actual_off:
	.string "          Impostazione corrente: Back-home: OFF\n"

string_backhome_on:
	.string "          SET Back-home: ON\n"

string_backhome_off:
	.string "          SET Back-home: OFF\n"

backhome:
    .long 0



# Sezione delle istruzioni
.section .text



.global scelta_backhome



# stampa il valore corrente di backhome,
# poi permette di cambiare questa impostazione (on/off)
.type scelta_backhome, @function



scelta_backhome:

	#salva in backhome il contenuto di eax
    	movl %eax, backhome


	# eax vale 0?
	cmpl $0, %eax

	# no, allora stampo il caso on (vale quindi 1)
	jne print_string_backhome_actual_on


	# si, allora stampo il caso off

print_string_backhome_actual_off:

	# mi preparo a stampare la stringa
	# string_backhome_actual_off
	leal string_backhome_actual_off, %ecx

	call printf

	# ora leggo da tastiera
    	jmp read_key

print_string_backhome_actual_on:

	
	# mi preparo a stampare string_backhome_actual_on
	leal string_backhome_actual_on, %ecx

    	call printf

# leggo da tastiera
read_key:

	
	# mi preparo a stampare la stringa string_input
	leal string_input, %ecx

	call printf

	# mi preparo a eseguire la read() (3 in eax, 0 in ebx, *string ecx, n_char edx)
	movl $3, %eax

	# identificatore della tastiera
	movl $0, %ebx

	# puntatore alla variabile in cui si memorizza la stringa
	leal key, %ecx

	# leggo 2 caratteri massimo (char + '\n')
	movl $2, %edx

	int $0x80

	# salvo il valore letto in key_length
   	movl %eax, (key_length)


compare_key_length:

   
	# ho letto 2 caratteri?
    cmpb $2, %al

	# no ne ho letti meno, quindi termino
	jl scelta_backhome_end

	# si, allora interpreto il carattere letto
    	je goto_compare

# no, allora vado in errore
get_error:

	# Chiama la funzione print_string_error
	# per stampare un messaggio di errore.
	#
	call print_string_error

	# Salta all'etichetta scelta_backhome_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jmp scelta_backhome_end

goto_compare:
	call compare_key

	# codice di ritorno errore ?
	cmp $1, %edx
	
	# si, allora rieseguo read_key
	je read_key

set_backhome:

    	# metto in eax il contenuto di backhome
    	movl backhome, %eax

	#eax vale 1?
    	cmpl $1, %eax

    	# si, allora imposto a off (1->0)
    	je set_backhome_off

# imposto a on (0->1)
set_backhome_on:

   	movl $1, %eax
	
	# salvo l'attuale valore in backhome
    	movl %eax, backhome

	# stampo la stringa corrispondente
    	jmp print_string_backhome_on

#imposto a off (1->0)
set_backhome_off:

    	movl $0, %eax

	# salvo l'attuale valore in backhome
    	movl %eax, backhome

	# stampo la stringa corrispondente
    	jmp print_string_backhome_off

print_string_backhome_on:

	# mi preparo a stampare string_backhome_on
	leal string_backhome_on, %ecx

    	call printf

	# rieseguo la lettura
    	jmp read_key

print_string_backhome_off:

	# mi preparo a stampare string_backhome_off
	leal string_backhome_off, %ecx

    	call printf

	# rieseguo la lettura
    	jmp read_key

scelta_backhome_end:

	# Carica nel registro EAX
	# il valore della variabile backhome.
	#
	movl backhome, %eax

    ret
