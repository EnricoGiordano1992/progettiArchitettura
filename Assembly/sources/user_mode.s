.code32

.bss

key:
    .string ""

.section .data

string_input:
	.string "> "

key_length:
    .long 0

counter:
    .long 0

supervisor:
	.long 0

lock_door:
    .long 0

back_home:
    .long 0



# Sezione delle istruzioni
.section .text



.global user_mode



# esecuzione in modalità supervisor
.type user_mode, @function



user_mode:

get_key:

	# mi preparo a scrivere la tringa string_input a video
	leal string_input, %ecx

	call printf

	# eseguo una read() che legge al massimo 50 caratteri
	movl $3, %eax

	movl $0, %ebx

	leal key, %ecx

	movl $50, %edx

	int $0x80

	# salvo la lunghezza della stringa
    	movl %eax, (key_length)

compare_key_length:

	# ho letto 2 caratteri?
    	cmpb $2, %al

	# no ne ho letti meno, allora termino
	jl user_mod_end

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

	# Salta all'etichetta user_mod_end,
	# che termina l'esecuzione della modalità supervisor.
	#
	jmp user_mod_end


goto_compare:
	call compare_key

	# codice di ritorno errore ?
	cmp $1, %edx
	
	# si, allora termino
	je user_mod_end

	movl %edx, %eax

	# no, allora ho i vari casi
	# D
	cmpb $68, %al
	je set_counter_down
	
	# d
	cmpb $100, %al
	je set_counter_down

	# E
	cmpb $69, %al
	je set_counter_up

	# e
	cmpb $101, %al
	je set_counter_up

	# r o R
    	jmp choose_submenu

set_counter_down:

	# si guarda in quale posizione si e' nello
	# scorrimento del menu'
    	movl counter, %edx
	
	# sono a posizione 0 ?
    	cmpl $0, %edx

    	# si, allora vado alla posizione 1
   	je set_counter_one

	# sono in posizione 6?
    	cmpl $6, %edx

    	# si, allora vado alla posizione 1
    	je set_counter_one

	# altrimenti incremento semplicemente
    	jmp increase_counter

set_counter_up:

	# si guarda in quale posizione si e' nello
	# scorrimento del menu'
    	movl counter, %edx

 	# sono a posizione 0 ?
   	cmpl $0, %edx

	# si, allora vado in posizione 6
    	je set_counter_six

 	# sono a posizione 1 ?
    	cmpl $1, %edx

	# si, allora vado in posizione 6
    	je set_counter_six

	# altrimenti decremento semplicemente	
    	jmp decrease_counter

set_counter_one:

	# preparo i registri per passare
	# i parametri alla funzione menu
    	movl $1, %edx

	jmp prepare_to_call_menu

set_counter_six:

    	movl $6, %edx

	jmp prepare_to_call_menu

increase_counter:

    	addl $1, %edx

	jmp prepare_to_call_menu

decrease_counter:

    	subl $1, %edx


prepare_to_call_menu:
	# preparo i registri per passare
	# i parametri alla funzione menu

    	movl %edx, (counter)

    	movl %edx, %eax

	movl supervisor, %ebx

	movl lock_door, %ecx

	movl back_home, %edx

    	call menu

    	jmp get_key


choose_submenu:

	# e' stata letta un carattere r
    
	movl counter, %eax

	# sono alla posizione 4?
    	cmpl $4, %eax

	# si, allora vado nel sottomenu' lock_door
    	je move_scelta_lockdoor

	# sono alla posizione 5?
    	cmpl $5, %eax

	# si, allora vado nel sottomenu' back_home
    	je move_scelta_backhome

    	jmp get_key

move_scelta_lockdoor:

	# passo il valore alla funzione tramite il registro eax
    	movl lock_door, %eax

   	call scelta_lockdoor

	movl %eax, lock_door

    	jmp get_key

move_scelta_backhome:

	# passo il valore alla funzione tramite il registro eax
    	movl back_home, %eax

    	call scelta_backhome

	movl %eax, back_home

    	jmp get_key


user_mod_end:

    ret
