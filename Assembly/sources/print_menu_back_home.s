.code32

.bss

key:
    .string ""



# variabili globali e costanti
.section .data



msg_input:
	.string "     > "



key_l:
    .long 0



# BACK HOME

msg_back_home_current_on:
	.string "          Impostazione corrente: Back-home: ON\n"

msg_back_home_current_off:
	.string "          Impostazione corrente: Back-home: OFF\n"

msg_back_home_on:
	.string "          SET Back-home: ON\n"

msg_back_home_off:
	.string "          SET Back-home: OFF\n"

back_home:
    .long 0



# Sezione delle istruzioni
.section .text



.global print_menu_back_home



# Funzione PRINT_MENU_BACK_HOME
#
# Stampa l'impostazione corrente del
# back-home in base al valore
# della variabile back_home passato nel registro EAX.
# Se back_home vale 0, allora stampa un messaggio
# dicendo che il back-home è impostato a OFF.
# Se back_home vale 1, allora stampa un messaggio
# dicendo che il back-home è impostato a ON.
# Inoltre questa funzione permette di impostare
# un nuovo valore per back_home
# premendo i tasti D/d oppure U/u.
# Il nuovo valore di back_home viene
# restituito nel registro EAX.
#
.type print_menu_back_home, @function



print_menu_back_home:

	# Salva nella variabile back_home
	# il contenuto del registro EAX.
	#
    movl %eax, back_home

	# Salta all'etichetta print_msg_back_home_current
	# che in base al valore di back_home
	# rimanda ad altre etichette per
	# stampare l'impostazione corrente del back-home.
	#
    jmp print_msg_back_home_current

print_msg_back_home_current:

	# Confronta il valore 0
	# con il contenuto del registro EAX,
	# nel quale è stato passato il valore
	# della variabile back_home.
	#
	cmpl $0, %eax

	# Se back_home vale 0,	
	# allora salta all'etichetta print_msg_back_home_current_off,
	# che stampa la stringa msg_back_home_current_off.
	#
	je print_msg_back_home_current_off

	# Confronta il valore 1
	# con il contenuto del registro EAX,
	# nel quale è stato passato il valore
	# della variabile back_home.
	#
	cmpl $1, %eax

	# Se back_home vale 1,	
	# allora salta all'etichetta print_msg_back_home_current_on,
	# che stampa la stringa msg_back_home_current_on.
	#
	je print_msg_back_home_current_on

print_msg_back_home_current_off:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_back_home_current_off.
	#
	leal msg_back_home_current_off, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta press_key
	# che legge una carattere da tastiera.
	#
    jmp press_key

print_msg_back_home_current_on:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_back_home_current_on.
	#
	leal msg_back_home_current_on, %ecx

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
	# e salta all'etichetta print_menu_back_home_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jl print_menu_back_home_end

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

	# Salta all'etichetta print_menu_back_home_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jmp print_menu_back_home_end

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
	# allora salta all'etichetta compare_key_E,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera E.
	#
	jmp compare_key_E

compare_key_E:

    # Confronta il codice ascii di "E"
	# con il contenuto del registro AL.
	#
	cmpb $69, %al

    # Se in AL è presente il codice ascii
	# della lettera U,
	# allora salta all'etichetta compare_new_line,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera E,
	# allora salta all'etichetta compare_key_u,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera u.
	#
	jmp compare_key_e

compare_key_e:

    # Confronta il codice ascii di "e"
	# con il contenuto del registro AL.
	#
	cmpb $101, %al

    # Se in AL è presente il codice ascii
	# della lettera e,
	# allora salta all'etichetta compare_new_line,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera e,
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
	# allora salta all'etichetta set_back_home,
	# che in base al valore di back_home
	# decide il nuovo valore da impostare per back_home.
	#
    je set_back_home

    # Altrimenti, se in AL non è presente
	# il codice ascii del carattere di new line,
	# allora salta all'etichetta print_menu_back_home_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jmp print_menu_back_home_end

set_back_home:

    # Carica nel registro EAX
	# il valore della variabile back_home.
	#
    movl back_home, %eax

    # Confronta il valore 0
	# con il contenuto del registro EAX.
	#
    cmpl $0, %eax

    # Se back_home vale 0,
	# allora salta all'etichetta set_back_home_on,
	# che imposta a 1 il valore di back_home.
	#
    je set_back_home_on

    # Confronta il valore 1
	# con il contenuto del registro EAX.
	#
    cmpl $1, %eax

    # Se back_home vale 1,
	# allora salta all'etichetta set_back_home_off,
	# che imposta a 0 il valore di back_home.
	#
    je set_back_home_off

set_back_home_on:

	# Carica il valore 1 nel registro EAX.
	#
    movl $1, %eax

	# Salva nella variabile back_home
	# il contenuto del registro EAX.
	#
    movl %eax, back_home

	# Salta all'etichetta print_msg_back_home_on
	# che stampa la stringa msg_back_home_on.
	#
    jmp print_msg_back_home_on

set_back_home_off:

	# Carica il valore 0 nel registro EAX.
	#
    movl $0, %eax

	# Salva nella variabile back_home
	# il contenuto del registro EAX.
	#
    movl %eax, back_home

	# Salta all'etichetta print_msg_back_home_on
	# che stampa la stringa msg_back_home_on.
	#
    jmp print_msg_back_home_off

print_msg_back_home_on:

	# Carica nel registro ECX l'indirizzo
	# della variabile msg_back_home_on.
	#
	leal msg_back_home_on, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta press_key
	# che legge una carattere da tastiera.
	#
    jmp press_key

print_msg_back_home_off:

	# Carica nel registro ECX l'indirizzo
	# della variabile msg_back_home_on.
	#
	leal msg_back_home_off, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta press_key
	# che legge una carattere da tastiera.
	#
    jmp press_key

print_menu_back_home_end:

	# Carica nel registro EAX
	# il valore della variabile back_home.
	#
	movl back_home, %eax

    ret
