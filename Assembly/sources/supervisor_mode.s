.code32

.bss



key:
    .string ""



# Sezione delle variabili globali e costanti
.section .data



msg_input:
	.string "> "

key_l:
    .long 0

counter:
    .long 0

supervisor:
	.long 1

lock_door:
    .long 0

back_home:
    .long 0

num_lights:
    .long 3



# Sezione delle istruzioni
.section .text



.global supervisor_mode



# Funzione SUPERVISOR_MODE
#
# Esegue in modalità supervisor
# il menù del cruscotto dell'automobile.
#
.type supervisor_mode, @function



supervisor_mode:

	# Salta all'etichetta press_key
	# che legge un carattere inserito da tastiera.
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

	# Carica nel registro EDX il numero 30
	# che indica il numero massimo di caratteri
	# che possono essere letti.
	#
	movl $30, %edx

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
	# e salta all'etichetta supervisor_mode_end,
	# che termina l'esecuzione della modalità supervisor.
	#
	jl supervisor_mode_end

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

	# Salta all'etichetta supervisor_mode_end,
	# che termina l'esecuzione della modalità supervisor.
	#
	jmp supervisor_mode_end

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
	# allora salta all'etichetta compare_new_line_down,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line_down

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
	# allora salta all'etichetta compare_new_line_down,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line_down

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera d,
	# allora salta all'etichetta compare_key_U,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera U.
	#
	jmp compare_key_E

compare_key_E:

    # Confronta il codice ascii di "E"
	# con il contenuto del registro AL.
	#
	cmpb $69, %al

    # Se in AL è presente il codice ascii
	# della lettera E,
	# allora salta all'etichetta compare_new_line_up,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line_up

     # Altrimenti, se in AL non è presente
	# il codice ascii della lettera U,
	# allora salta all'etichetta compare_key_u,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera e.
	#
	jmp compare_key_e

compare_key_e:

    # Confronta il codice ascii di "e"
	# con il contenuto del registro AL.
	#
	cmpb $101, %al

    # Se in AL è presente il codice ascii
	# della lettera u,
	# allora salta all'etichetta compare_new_line_up,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line_up

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera u,
	# allora salta all'etichetta compare_key_R,
	# che controlla se il primo carattere
	# della stringa letta sia uguale
	# alla lettera R.
	#
	jmp compare_key_R

compare_key_R:

    # Confronta il codice ascii di "R"
	# con il contenuto del registro AL.
	#
	cmpb $82, %al

    # Se in AL è presente il codice ascii
	# della lettera R,
	# allora salta all'etichetta compare_new_line_right,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line_right

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
	# allora salta all'etichetta compare_new_line_right,
	# che controlla se il carattere successivo
	# della stringa letta sia uguale al carattere di new line.
	#
    je compare_new_line_right

    # Altrimenti, se in AL non è presente
	# il codice ascii della lettera r,
	# allora salta all'etichetta press_key,
	# che chiede di inserire nuovamente un carattere.
	#
	jmp press_key

compare_new_line_down:

	# Si giunge all'etichetta compare_new_line_down
	# se è stata premuta la lettera D
	# oppure la lettera d.

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
	# allora salta all'etichetta set_counter_down,
	# che imposta correttamente il contatore
	# della voce del menù da visualizzare
	# secondo un ordine crescente da 1 a 8,
	# ricominciando poi da 1 se il contatore vale 8.
	#
    je set_counter_down

    # Altrimenti, se in AL non è presente
	# il codice ascii del carattere di new line,
	# allora salta all'etichetta supervisor_mode_end,
	# che termina l'esecuzione della modalità supervisor.
	#
	jmp supervisor_mode_end

compare_new_line_up:

	# Si giunge all'etichetta compare_new_line_up
	# se è stata premuta la lettera U
	# oppure la lettera u.

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
	# allora salta all'etichetta set_counter_up,
	# che imposta correttamente il contatore
	# della voce del menù da visualizzare
	# secondo un ordine decrescente da 8 a 1,
	# ricominciando poi da 8 se il contatore vale 1.
	#
    je set_counter_up

    # Altrimenti, se in AL non è presente
	# il codice ascii del carattere di new line,
	# allora salta all'etichetta supervisor_mode_end,
	# che termina l'esecuzione della modalità supervisor.
	#
	jmp supervisor_mode_end

compare_new_line_right:

	# Si giunge all'etichetta compare_new_line_right
	# se è stata premuta la lettera R
	# oppure la lettera r.

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
	# allora salta all'etichetta choose_submenu,
	# che in base al valore del contatore,
	# il quale rappresenta la voce correntemente visualizzata,
	# sceglie il corretto sottomenù da attivare.
	#
    je choose_submenu

    # Altrimenti, se in AL non è presente
	# il codice ascii del carattere di new line,
	# allora salta all'etichetta supervisor_mode_end,
	# che termina l'esecuzione della modalità supervisor.
	#
	jmp supervisor_mode_end

set_counter_down:

	# Si giunge all'etichetta set_counter_down
	# se si deve incrementare il contatore
	# per visualizzare correttamente
	# la successiva voce del menù.

    # Carica nel registro EDX il valore del contatore.
    #
    movl counter, %edx

    # Confronta il numero 0
	# con il contenuto del registro EDX,
	# nel quale è stato caricato precedentemente
	# il valore corrente del contatore.
	#
    cmpl $0, %edx

    # Se il contatore vale 0,
	# allora salta all'etichetta set_counter_one,
	# che imposta a 1 il contatore.
	#
    je set_counter_one

    # Confronta il numero 8
	# con il contenuto del registro EDX,
	# nel quale è stato caricato precedentemente
	# il valore corrente del contatore.
	#
    cmpl $8, %edx

    # Se il contatore vale 8,
	# allora salta all'etichetta set_counter_one,
	# che imposta a 1 il contatore.
	#
    je set_counter_one

	# Altrimenti salta all'etichetta increase_counter,
	# che incrementa il valore del contatore
	# per visualizzare la successiva voce del menù.
	#
    jmp increase_counter

set_counter_up:

	# Si giunge all'etichetta set_counter_up
	# se si deve decrementare il contatore
	# per visualizzare correttamente
	# la precedente voce del menù.

	# Carica nel registro EDX il valore del contatore.
    #
    movl counter, %edx

	# Confronta il numero 0
	# con il contenuto del registro EDX,
	# nel quale è stato caricato precedentemente
	# il valore corrente del contatore.
	#
    cmpl $0, %edx

    # Se il contatore vale 0,
	# allora salta all'etichetta set_counter_eight,
	# che imposta a 8 il contatore.
	#
    je set_counter_eight

	# Confronta il numero 1
	# con il contenuto del registro EDX,
	# nel quale è stato caricato precedentemente
	# il valore corrente del contatore.
	#
    cmpl $1, %edx

    # Se il contatore vale 1,
	# allora salta all'etichetta set_counter_eight,
	# che imposta a 8 il contatore.
	#
    je set_counter_eight

    # Altrimenti salta all'etichetta decrease_counter,
	# che decrementa il valore del contatore
	# per visualizzare la precedente voce del menù.
	#
    jmp decrease_counter

set_counter_one:

	# Carica il valore 1 nel registro EDX.
    #
    movl $1, %edx

	# Mette il contenuto del registro EDX
    # nella variabile counter,
    # che ora il contiene il numero della voce
    # del menù da visualizzare.
    #
    movl %edx, (counter)

	# Sposta il contenuto del registro EDX
    # nel registro EAX.
    #
    movl %edx, %eax

	# Mette nel registro EBX
    # il valore della variabile supervisor.
    #
	movl supervisor, %ebx

	# Mette nel registro ECX
    # il valore della variabile lock_door.
    #
	movl lock_door, %ecx

	# Mette nel registro EDX
    # il valore della variabile back_home.
    #
	movl back_home, %edx

	# Chiama la funzione print_menu_voice
    # per stampare la voce del menù da visualizzare.
    #
    call print_menu_voice

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

set_counter_eight:

	# Carica il valore 8 nel registro EDX.
    #
    movl $8, %edx

	# Mette il contenuto del registro EDX
    # nella variabile counter,
    # che ora il contiene il numero della voce
    # del menù da visualizzare.
    #
    movl %edx, (counter)

	# Sposta il contenuto del registro EDX
    # nel registro EAX.
    #
    movl %edx, %eax

	# Mette nel registro EBX
    # il valore della variabile supervisor.
    #
	movl supervisor, %ebx

	# Mette nel registro ECX
    # il valore della variabile lock_door.
    #
	movl lock_door, %ecx

	# Mette nel registro EDX
    # il valore della variabile back_home.
    #
	movl back_home, %edx

	# Chiama la funzione print_menu_voice
    # per stampare la voce del menù da visualizzare.
    #
    call print_menu_voice

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

increase_counter:

	# Somma il valore 1 al contenuto
    # del registro EDX, il quale contiene
    # il vecchio valore del contatore.
    #
    addl $1, %edx

	# Mette il contenuto del registro EDX
    # nella variabile counter,
    # che ora il contiene il numero della voce
    # del menù da visualizzare.
    #
    movl %edx, (counter)

	# Sposta il contenuto del registro EDX
    # nel registro EAX.
    #
    movl %edx, %eax

	# Mette nel registro EBX
    # il valore della variabile supervisor.
    #
	movl supervisor, %ebx

	# Mette nel registro ECX
    # il valore della variabile lock_door.
    #
	movl lock_door, %ecx

	# Mette nel registro EDX
    # il valore della variabile back_home.
    #
	movl back_home, %edx

	# Chiama la funzione print_menu_voice
    # per stampare la voce del menù da visualizzare.
    #
    call print_menu_voice

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

decrease_counter:

	# Sottrae il valore 1 al contenuto
    # del registro EDX, il quale contiene
    # il vecchio valore del contatore.
    #
    subl $1, %edx

	# Mette il contenuto del registro EDX
    # nella variabile counter,
    # che ora il contiene il numero della voce
    # del menù da visualizzare.
    #
    movl %edx, (counter)

	# Sposta il contenuto del registro EDX
    # nel registro EAX.
    #
    movl %edx, %eax

	# Mette nel registro EBX
    # il valore della variabile supervisor.
    #
	movl supervisor, %ebx

	# Mette nel registro ECX
    # il valore della variabile lock_door.
    #
	movl lock_door, %ecx

	# Mette nel registro EDX
    # il valore della variabile back_home.
    #
	movl back_home, %edx

	# Chiama la funzione print_menu_voice
    # per stampare la voce del menù da visualizzare.
    #
    call print_menu_voice

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

choose_submenu:

	# Si giunge all'etichetta choose_submenu
	# se in corrispondenza di una voce del menù
    # è stata premuta la lettera R oppure la lettera r.
    # Questo significa che deve essere selezionato
    # il sottomenù corrispondente alla voce visualizzata.

	# Carica il valore del contatore
    # nel registro EAX.
    #
    movl counter, %eax

	# Confronta il valore 4
    # con il contenuto del registro EAX.
    #
    cmpl $4, %eax

	# Se nel contatore è presente il valore 4,
    # allora salta all'etichetta move_menu_lock_door.
    #
    je move_menu_lock_door

	# Confronta il valore 5
    # con il contenuto del registro EAX.
    #
    cmpl $5, %eax

	# Se nel contatore è presente il valore 5,
    # allora salta all'etichetta move_menu_back_home.
    #
    je move_menu_back_home

	# Confronta il valore 7
    # con il contenuto del registro EAX.
    #
	cmpl $7, %eax

	# Se nel contatore è presente il valore 7,
    # allora salta all'etichetta move_menu_direction_arrows.
    #
	je move_menu_direction_arrows

	# Confronta il valore 8
    # con il contenuto del registro EAX.
    #
	cmpl $8, %eax

	# Se nel contatore è presente il valore 8,
    # allora salta all'etichetta move_menu_reset_tire_pressure.
    #
	je move_menu_reset_tire_pressure

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

move_menu_lock_door:

	# Carica nel registro EAX
	# il valore della variabile lock_door,
	# la quale vale 0 se il blocco automatico
	# porte è impostato a OFF, altrimenti vale 1.
	#
    movl lock_door, %eax

	# Chiama la funzione print_menu_lock_door,
	# che stampa il valore corrente del blocco
	# automatico porte e permette inoltre di
	# cambiare l'impostazione.
	#
    call print_menu_lock_door

	# Salva nella variabile lock_door
	# il valore del registro EAX,
	# salvando quindi la nuova impostazione
	# del blocco automatico porte.
	#
	movl %eax, lock_door

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

move_menu_back_home:

	# Carica nel registro EAX
	# il valore della variabile back_home,
	# la quale vale 0 se il back-home
	# è impostato a OFF, altrimenti vale 1.
	#
    movl back_home, %eax

	# Chiama la funzione print_menu_back_home,
	# che stampa il valore corrente del back-home
	# e permette inoltre di cambiare l'impostazione.
	#
    call print_menu_back_home

	# Salva nella variabile back_home
	# il valore del registro EAX,
	# salvando quindi la nuova impostazione
	# del back-home.
	#
	movl %eax, back_home

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

move_menu_direction_arrows:

	# Carica nel registro EAX
	# il valore della variabile num_lights,
	# la quale rappresenta il numero dei lampeggi
	# delle frecce in modalità autostrada
	# e può avere un valore compreso tra 2 e 5.
	#
	movl num_lights, %eax

	# Chiama la funzione print_menu_direction_arrows,
	# che stampa il valore corrente dell'impostazione
	# delle frecce direzione e permette inoltre di
	# impostare per esse un nuovo valore.
	#
    call print_menu_direction_arrows

	# Salva nella variabile num_lights
	# il valore del registro EAX,
	# salvando quindi la nuova impostazione
	# per num_lights.
	#
	movl %eax, num_lights

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

move_menu_reset_tire_pressure:

	# Carica nel registro EAX
	# il valore 1 per indicare che
	# si vuole resettare la pressione
	# delle gomme.
	#
	movl $1, %eax

	# Chiama la funzione print_menu_reset_tire_pressure,
	# che stampa una stringa annunciando che la
	# pressione delle gomme è stata resettata.
	#
    call print_menu_reset_tire_pressure

	# Salta all'etichetta press_key
    # per leggere un nuovo carattere da tastiera.
    #
    jmp press_key

supervisor_mode_end:

    ret