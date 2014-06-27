.code32

.bss



key:
    .string ""



# Sezione delle variabili globali e costanti
.section .data



msg_input:
	.string "     > "



key_l:
    .long 0



# LOCK DOOR

msg_lock_door_current_on:
	.string "          Impostazione corrente: Blocco automatico porte: ON\n"

msg_lock_door_current_off:
	.string "          Impostazione corrente: Blocco automatico porte: OFF\n"

msg_lock_door_on:
	.string "          SET Blocco automatico porte: ON\n"

msg_lock_door_off:
	.string "          SET Blocco automatico porte: OFF\n"

lock_door:
    .long 0



# Sezione delle istruzioni
.section .text



.global print_menu_lock_door



# Funzione PRINT_MENU_LOCK_DOOR
#
# Stampa l'impostazione corrente del blocco
# automatico porte in base al valore
# della variabile lock_door passato nel registro EAX.
# Se lock_door vale 0, allora stampa un messaggio
# dicendo che il blocco automatico porte è impostato a OFF.
# Se lock_door vale 1, allora stampa un messaggio
# dicendo che il blocco automatico porte è impostato a ON.
# Inoltre questa funzione permette di impostare
# un nuovo valore per lock_door
# premendo i tasti D/d oppure U/u.
# Il nuovo valore di lock_door viene
# restituito nel registro EAX.
#
.type print_menu_lock_door, @function



print_menu_lock_door:

	# Salva nella variabile lock_door
	# il contenuto del registro EAX.
	#
    movl %eax, lock_door

	# Salta all'etichetta print_msg_lock_door_current
	# che in base al valore di lock_door
	# rimanda ad altre etichette per
	# stampare l'impostazione corrente del
	# blocco automatico porte.
	#
	jmp print_msg_lock_door_current

print_msg_lock_door_current:

	# Confronta il valore 0
	# con il contenuto del registro EAX,
	# nel quale è stato passato il valore
	# della variabile lock_door.
	#
	cmpl $0, %eax

	# Se lock_door vale 0,	
	# allora salta all'etichetta print_msg_lock_door_current_off,
	# che stampa la stringa msg_lock_door_current_off.
	#
	je print_msg_lock_door_current_off

	# Confronta il valore 1
	# con il contenuto del registro EAX,
	# nel quale è stato passato il valore
	# della variabile lock_door.
	#
	cmpl $1, %eax

	# Se lock_door vale 1,	
	# allora salta all'etichetta print_msg_lock_door_current_on,
	# che stampa la stringa msg_lock_door_current_on.
	#
	je print_msg_lock_door_current_on

print_msg_lock_door_current_off:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_lock_door_current_off.
	#
	leal msg_lock_door_current_off, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta press_key
	# che legge una carattere da tastiera.
	#
    jmp press_key

print_msg_lock_door_current_on:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_lock_door_current_on.
	#
	leal msg_lock_door_current_on, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta press_key
	# che legge una carattere da tastiera.
	#
    jmp press_key

press_key:

	# Carica nel registro ECX
	# l'indirizzo della stringa msg_input.
	#
	leal msg_input, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	call print

	# Carica nel registro EAX il numero 3,
	# cioè il codice della funzione read().
	#
	movl $3, %eax

	# Carica nel registro EBX il numero 0,
	# identificatore della tastiera.
	#
	movl $0, %ebx

	# Carica nel registro ECX il puntatore alla variabile
	# in cui verrà salvata stringa letta.
	#
	leal key, %ecx

	# Carica nel registro EDX il numero 2
	# che indica il numero massimo di caratteri
	# che possono essere letti.
	#
	movl $2, %edx

	# Chiama l'interrupt 0x80.
	#
	int $0x80

	# Salva nella variabile key_l
	# la lunghezza della stringa letta.
	#
    movl %eax, (key_l)

	# Salta all'etichetta compare_key_l,
	# che controlla la lunghezza della stringa letta.
	#
    jmp compare_key_l

compare_key_l:

	# Confronta il numero 2 con il contenuto
	# di una parte del registro EAX,
	# per verificare se la lunghezza della stringa
	# letta è pari a 2.
	#
    cmpb $2, %al

	# Se la lunghezza della stringa è minore di 2,
	# allora è stato inserito il carattere di new_line
	# e salta all'etichetta print_menu_lock_door_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jl print_menu_lock_door_end

	# Se la stringa letta da tastiera è lunga 2,
	# cioè comprende un carattere
	# seguito dal carattere di new line,
	# allora salta all'etichetta compare_key_D.
	# Questa controlla se il carattere inserito
	# risulta uguale alla lettera D.
	#
    je compare_key_D

	# Altrimenti salta all'etichetta get_error
	# per richiamare un messaggio di errore.
	#
    jmp get_error

get_error:

	# Chiama la funzione print_msg_error
	# per stampare un messaggio di errore.
	#
	call print_msg_error

	# Salta all'etichetta print_menu_lock_door_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jmp print_menu_lock_door_end

compare_key_D:

    # Controlla il primo parametro
	# che si trova all'indirizzo contenuto in ECX
    # e lo sposta in EAX.
	#
    movl (%ecx), %eax

    # Confronta il codice ascii di "D"
	# con il contenuto del registro AL.
	#
	cmpb $68, %al

    # Se in AL è presente il codice ascii
	# della lettera D,
	# allora salta all'etichetta compare_new_line,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera D,
	# allora salta all'etichetta compare_key_d,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera d.
	#
	jmp compare_key_d

compare_key_d:

    # Confronta il codice ascii di "d"
	# con il contenuto del registro AL.
	#
	cmpb $100, %al

    # Se in AL è presente il codice ascii
	# della lettera d,
	# allora salta all'etichetta compare_new_line,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera d,
	# allora salta all'etichetta compare_key_U,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera U.
	#
	jmp compare_key_U

compare_key_U:

    # Confronta il codice ascii di "U"
	# con il contenuto del registro AL.
	#
	cmpb $85, %al

    # Se in AL è presente il codice ascii
	# della lettera U,
	# allora salta all'etichetta compare_new_line,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera U,
	# allora salta all'etichetta compare_key_u,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera u.
	#
	jmp compare_key_u

compare_key_u:

    # Confronta il codice ascii di "u"
	# con il contenuto del registro AL.
	#
	cmpb $117, %al

    # Se in AL è presente il codice ascii
	# della lettera u,
	# allora salta all'etichetta compare_new_line,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera u,
	# allora salta all'etichetta press_key,
	# che chiede di inserire nuovamente un carattere.
	#
	jmp press_key

compare_new_line:

    # Somma 1 all'indirizzo contenuto in ECX
	# e lo sposta in EAX.
	#
	movl 1(%ecx), %eax

    # Confronta il codice ascii del new line
	# con il contenuto del registro AL.
	#
	cmpb $10, %al

    # Se in AL è presente il codice ascii
	# del carattere di new line,
	# allora salta all'etichetta set_lock_door,
	# che in base al valore di lock_door
	# decide il nuovo valore da impostare per lock_door.
	#
    je set_lock_door

    # Altrimenti, se in AL non è presente
	# il codice ascii del carattere di new line,
	# allora salta all'etichetta print_menu_lock_door_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jmp print_menu_lock_door_end

set_lock_door:

    # Carica nel registro EAX
	# il valore della variabile lock_door.
	#
    movl lock_door, %eax

    # Confronta il valore 0
	# con il contenuto del registro EAX.
	#
    cmpl $0, %eax

    # Se lock_door vale 0,
	# allora salta all'etichetta set_lock_door_on,
	# che imposta a 1 il valore di lock_door.
	#
    je set_lock_door_on

    # Confronta il valore 1
	# con il contenuto del registro EAX.
	#
    cmpl $1, %eax

    # Se lock_door vale 1,
	# allora salta all'etichetta set_lock_door_off,
	# che imposta a 0 il valore di lock_door.
	#
    je set_lock_door_off

set_lock_door_on:

	# Carica il valore 1 nel registro EAX.
	#
    movl $1, %eax

	# Salva nella variabile lock_door
	# il contenuto del registro EAX.
	#
    movl %eax, lock_door

	# Salta all'etichetta print_msg_lock_door_on
	# che stampa la stringa msg_lock_door_on.
	#
    jmp print_msg_lock_door_on

set_lock_door_off:

	# Carica il valore 0 nel registro EAX.
	#
    movl $0, %eax

	# Salva nella variabile lock_door
	# il contenuto del registro EAX.
	#
    movl %eax, lock_door

	# Salta all'etichetta print_msg_lock_door_off
	# che stampa la stringa msg_lock_door_off.
	#
    jmp print_msg_lock_door_off

print_msg_lock_door_on:

	# Carica nel registro ECX l'indirizzo
	# della variabile msg_lock_door_on.
	#
	leal msg_lock_door_on, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta press_key
	# che legge una carattere da tastiera.
	#
    jmp press_key

print_msg_lock_door_off:

	# Carica nel registro ECX l'indirizzo
	# della variabile msg_lock_door_off.
	#
	leal msg_lock_door_off, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta press_key
	# che legge una carattere da tastiera.
	#
    jmp press_key

print_menu_lock_door_end:

	# Carica nel registro EAX
	# il valore della variabile lock_door.
	#
	movl lock_door, %eax

    ret