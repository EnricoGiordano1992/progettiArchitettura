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



# RESET TIRE PRESSURE

msg_reset_tire_pressure:
	.string "          Pressione gomme resettata\n"

reset_tire_pressure:
    .long 0



# Sezione delle istruzioni
.section .text



.global print_menu_reset_tire_pressure



# Funzione PRINT_MENU_RESET_TIRE_PRESSURE
#
# Permette di resettare la pressione delle gomme
# in seguito alla pressione del tasto R/r.
# Se viene premuto il tasto R oppure r,
# in base al valore di reset_tire_pressure
# passato attraverso il registro EAX,
# allora stampa un messaggio che informa
# che la pressione degli pneumatici è stata resettata.
#
.type print_menu_reset_tire_pressure, @function



print_menu_reset_tire_pressure:

	# Salva nella variabile reset_tire_pressure
	# il contenuto del registro EAX.
	#
    movl %eax, reset_tire_pressure

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
	# e salta all'etichetta print_menu_reset_tire_pressure_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jl print_menu_reset_tire_pressure_end

	# Se la stringa letta da tastiera è lunga 2,
	# cioè comprende un carattere
	# seguito dal carattere di new line,
	# allora salta all'etichetta compare_key_R.
	# Questa controlla se il carattere inserito
	# risulta uguale alla lettera R.
	#
    je compare_key_R

	# Altrimenti salta all'etichetta get_error
	# per richiamare un messaggio di errore.
	#
    jmp get_error

get_error:

	# Chiama la funzione print_msg_error
	# per stampare un messaggio di errore.
	#
	call print_msg_error

	# Salta all'etichetta print_menu_reset_tire_pressure_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jmp print_menu_reset_tire_pressure_end

compare_key_R:

    # Controlla il primo parametro
	# che si trova all'indirizzo contenuto in ECX
    # e lo sposta in EAX.
	#
    movl (%ecx), %eax

    # Confronta il codice ascii di "R"
	# con il contenuto del registro AL.
	#
	cmpb $82, %al

    # Se in AL è presente il codice ascii
	# della lettera R,
	# allora salta all'etichetta compare_new_line,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera R,
	# allora salta all'etichetta compare_key_r,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera r.
	#
	jmp compare_key_r

compare_key_r:

    # Confronta il codice ascii di "r"
	# con il contenuto del registro AL.
	#
	cmpb $114, %al

    # Se in AL è presente il codice ascii
	# della lettera r,
	# allora salta all'etichetta compare_new_line,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera r,
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
	# allora salta all'etichetta print_msg_reset_tire_pressure,
	# che informa che la pressione delle gomme
	# è stata resettata.
	#
    je print_msg_reset_tire_pressure

    # Altrimenti, se in AL non è presente
	# il codice ascii del carattere di new line,
	# allora salta all'etichetta print_menu_reset_tire_pressure_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
	jmp print_menu_reset_tire_pressure_end

print_msg_reset_tire_pressure:

	# Carica nel registro ECX l'indirizzo
	# della variabile msg_reset_tire_pressure.
	#
	leal msg_reset_tire_pressure, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_reset_tire_pressure_end,
	# che ritorna il controllo alla funzione chiamante
	# print_menu_voice.
	#
    jmp print_menu_reset_tire_pressure_end

print_menu_reset_tire_pressure_end:

    ret
