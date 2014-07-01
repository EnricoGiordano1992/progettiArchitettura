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



# LOCK DOOR

string_lockdoor_actual_on:
	.string "          Impostazione corrente: Blocco automatico porte: ON\n"

string_lockdoor_actual_off:
	.string "          Impostazione corrente: Blocco automatico porte: OFF\n"

string_lockdoor_on:
	.string "          SET Blocco automatico porte: ON\n"

string_lockdoor_off:
	.string "          SET Blocco automatico porte: OFF\n"


# Sezione delle istruzioni
.section .text



.global scelta_lockdoor



# stampa il setting del lock door
#
# parametro ricevuto da eax
# parametro di ret inviato da eax

.type scelta_lockdoor, @function



scelta_lockdoor:

	# Salva nella variabile lock_door
	# il contenuto del registro EAX.
    	pushl %eax


	# eax vale 0?
	cmpl $0, %eax

	# no, allora stampo on
	jne print_string_lockdoor_actual_on


	# mi preparo a stampare string_lockdoor_actual_off
	leal string_lockdoor_actual_off, %ecx

   	call printf

	# inizio a leggere i valori da tastiera
    	jmp get_key

print_string_lockdoor_actual_on:

	# mi preparo a stampare string_lockdoor_actual_on
	leal string_lockdoor_actual_on, %ecx

    	call printf

# inizio a leggere i valori da tastiera
get_key:

	# mi preparo a stampare string_input
	leal string_input, %ecx

	call printf

	# Carica nel registro eax il numero 3 (codice funzione read())
	movl $3, %eax

	# identificatore tastiera
	movl $0, %ebx

	# puntatore alla stringa in cui memorizzare
	leal key, %ecx

	# numero di caratteri da leggere
	movl $2, %edx

	int $0x80

	
	# salvo la lunghezza della stringa
    	movl %eax, (key_length)


# controlla la lunghezza della stringa letta
compare_key_length:

	# ho letto 2 caratteri?
    	cmpb $2, %al

	# no ne ho letti meno, allora termino
	jl scelta_lockdoor_end

	# si, allora interpreto cio' che ho letto
    	je goto_compare

	# Altrimenti salta all'etichetta get_error
	# per richiamare un messaggio di errore.
	#
    	jmp get_error

get_error:

	# Chiama la funzione print_string_error
	# per stampare un messaggio di errore.
	#
	call print_string_error

	# Salta all'etichetta scelta_lockdoor_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jmp scelta_lockdoor_end

goto_compare:
	call compare_key

	# codice di ritorno errore ?
	cmp $1, %edx
	
	# si, allora rieseguo read_key
	je get_key



set_lock_door:

    	# riottengo in valore di eax
    	popl %eax

    	# eax vale 1?
    	cmpl $1, %eax

    	# si, allora imposto a off (1->0)
    	je set_lock_door_off


    	movl $1, %eax

	# memorizzo nello stack eax
    	pushl %eax

    	jmp print_string_lockdoor_on

set_lock_door_off:

    	movl $0, %eax

	# memorizzo nello stack eax
    	pushl %eax

    	jmp print_string_lockdoor_off

print_string_lockdoor_on:

	# mi preparo a stampare string_lockdoor_on
	leal string_lockdoor_on, %ecx

    	call printf

	# leggo un carattere da tastiera
    	jmp get_key

print_string_lockdoor_off:

	# mi preparo a stampare string_lockdoor_off
	leal string_lockdoor_off, %ecx

    	call printf

    	jmp get_key

scelta_lockdoor_end:

	# riottengo il valore messo precedentemente nello stack
	popl %eax

    ret
