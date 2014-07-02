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

superuser:
	.long 1

lock_door:
    .long 0

back_home:
    .long 0

num_lights:
    .long 3



# Sezione delle istruzioni
.section .text



.global superuser_mode



# esecuzione in modalità superuser
.type superuser_mode, @function



superuser_mode:

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
	jl superuser_mode_end

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

	# Salta all'etichetta superuser_mode_end,
	# che termina l'esecuzione della modalità superuser.
	#
	jmp superuser_mode_end


goto_compare:
	call compare_key

	# codice di ritorno errore ?
	cmp $1, %edx
	
	# si, allora termino
	je superuser_mode_end

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

	# sono in posizione 8?
    	cmpl $8, %edx

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

	# si, allora vado in posizione 8
    	je set_counter_eight

 	# sono a posizione 1 ?
    	cmpl $1, %edx

	# si, allora vado in posizione 8
    	je set_counter_eight

	# altrimenti decremento semplicemente	
    	jmp decrease_counter

set_counter_one:

	# preparo i registri per passare
	# i parametri alla funzione menu
    	movl $1, %edx

	jmp prepare_to_call_menu

set_counter_eight:

    	movl $8, %edx

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

	movl superuser, %ebx

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

	# sono alla posizione 7?
	cmpl $7, %eax

	# si, allora vado nel sottomenu' direction_arrows
	je move_scelta_frecce_direzione

	# sono alla posizione 7?
	cmpl $8, %eax

	# si, allora vado nel sottomenu' reset_tire_pressure
	je move_reset_pressione

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

move_scelta_frecce_direzione:

	# passo il valore alla funzione tramite il registro eax
	movl num_lights, %eax

   	call scelta_frecce_direzione

	movl %eax, num_lights

    	jmp get_key

move_reset_pressione:

	# passo il valore alla funzione tramite il registro eax
	movl $1, %eax

    	call reset_pressione

    	jmp get_key

superuser_mode_end:

    ret
