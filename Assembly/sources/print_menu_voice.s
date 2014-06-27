.code32

.section .data



supervisor:
	.long 0



# SETTING USER MODE

msg_setting_user:
	.string "     1. Setting automobile:\n"



# SETTING SUPERVISOR MODE

msg_setting_supervisor:
	.string "     1. Setting automobile (supervisor):\n"



# DATE

msg_date:
	.string "     2. Data: 15/06/2014\n"



# TIME

msg_time:
	.string "     3. Ora: 15:32\n"



# LOCK DOOR

msg_lock_door_on:
	.string "     4. Blocco automatico porte: ON\n"

msg_lock_door_off:
	.string "     4. Blocco automatico porte: OFF\n"

lock_door:
    .long 0



# BACK HOME

msg_back_home_on:
	.string "     5. Back-home: ON\n"

msg_back_home_off:
	.string "     5. Back-home: OFF\n"

back_home:
    .long 0



# CHECK OIL

msg_check_oil:
	.string "     6. Check olio\n"



# DIRECTION ARROWS

msg_direction_arrows:
	.string "     7. Frecce direzione\n"



# RESET TIRE PRESSURE

msg_reset_tire_pressure:
	.string "     8. Reset pressione gomme\n"



# Sezione delle istruzioni
.section .text



.global print_menu_voice



# Funzione PRINT_MENU_VOICE
#
# Stampa la voce del menù in base
# al valore del contatore
# passato nel registro EAX.
# Inoltre riceve dalla funzione
# user_mode o supervisor_mode il valore delle variabili
#    - supervisor, nel registro EBX,
#      per sapere in quale modalità (USER/SUPERVISOR)
#      è stato avviato il menù;
#    - lock_door, nel registro ECX,
#      per sapere quale sia l'impostazione (ON/OFF)
#      del blocco automatico porte;
#    - back_home, nel registro EDX,
#      per sapere quale sia l'impostazione (ON/OFF)
#      del back-home.
#
.type print_menu_voice, @function



print_menu_voice:

	# Salva nella variabile supervisor
	# il contenuto del registro EBX.
	#
	movl %ebx, supervisor

	# Salva nella variabile lock_door
	# il contenuto del registro EBX.
	#
	movl %ecx, lock_door

	# Salva nella variabile back_home
	# il contenuto del registro EBX.
	#
	movl %edx, back_home

	# Confronta il valore 1 con il
	# contenuto del registro EAX,
	# nel quale è stato passato il valore
	# del contatore della voce del menù da visualizzare.
	#
    cmpl $1, %eax

	# Se il contatore vale 1,
	# allora salta all'etichetta print_msg_setting,
	# che stampa la prima voce del menù.
	#
    je print_msg_setting

	# Confronta il valore 2 con il
	# contenuto del registro EAX,
	# nel quale è stato passato il valore
	# del contatore della voce del menù da visualizzare.
	#
    cmpl $2, %eax

	# Se il contatore vale 2,
	# allora salta all'etichetta print_msg_date,
	# che stampa la seconda voce del menù.
	#
    je print_msg_date

	# Confronta il valore 3 con il
	# contenuto del registro EAX,
	# nel quale è stato passato il valore
	# del contatore della voce del menù da visualizzare.
	#
    cmpl $3, %eax

	# Se il contatore vale 3,
	# allora salta all'etichetta print_msg_time,
	# che stampa la terza voce del menù.
	#
    je print_msg_time

	# Confronta il valore 4 con il
	# contenuto del registro EAX,
	# nel quale è stato passato il valore
	# del contatore della voce del menù da visualizzare.
	#
    cmpl $4, %eax

	# Se il contatore vale 4,
	# allora salta all'etichetta print_msg_lock_door,
	# che stampa la quarta voce del menù.
	#
    je print_msg_lock_door

	# Confronta il valore 5 con il
	# contenuto del registro EAX,
	# nel quale è stato passato il valore
	# del contatore della voce del menù da visualizzare.
	#
    cmpl $5, %eax

	# Se il contatore vale 5,
	# allora salta all'etichetta print_msg_back_home,
	# che stampa la quinta voce del menù.
	#
    je print_msg_back_home

	# Confronta il valore 6 con il
	# contenuto del registro EAX,
	# nel quale è stato passato il valore
	# del contatore della voce del menù da visualizzare.
	#
    cmpl $6, %eax

	# Se il contatore vale 6,
	# allora salta all'etichetta print_msg_check_oil,
	# che stampa la sesta voce del menù.
	#
    je print_msg_check_oil

	# Confronta il valore 7 con il
	# contenuto del registro EAX,
	# nel quale è stato passato il valore
	# del contatore della voce del menù da visualizzare.
	#
	cmpl $7, %eax

	# Se il contatore vale 7,
	# allora salta all'etichetta print_msg_direction_arrows,
	# che stampa la settima voce del menù.
	#
    je print_msg_direction_arrows

	# Confronta il valore 8 con il
	# contenuto del registro EAX,
	# nel quale è stato passato il valore
	# del contatore della voce del menù da visualizzare.
	#
	cmpl $8, %eax

	# Se il contatore vale 8,
	# allora salta all'etichetta print_msg_reset_tire_pressure,
	# che stampa l'ottava voce del menù.
	#
    je print_msg_reset_tire_pressure

print_msg_setting:

	# Confronta il valore 0 con il
	# contenuto del registro EBX,
	# nel quale è stato passato il valore
	# della variabile supervisor.
	#
	cmpl $0, %ebx

	# Se la variabile supervisor vale 0,
	# allora salta all'etichetta print_msg_setting_user,
	# che stampa la prima voce del menù
	# relativa all'esecuzione in modalità utente.
	#
	je print_msg_setting_user

	# Confronta il valore 1 con il
	# contenuto del registro EBX,
	# nel quale è stato passato il valore
	# della variabile supervisor.
	#
	cmpl $1, %ebx

	# Se la variabile supervisor vale 1,
	# allora salta all'etichetta print_msg_setting_supervisor,
	# che stampa la prima voce del menù
	# relativa all'esecuzione in modalità supervisor.
	#
	je print_msg_setting_supervisor

	# Altrimenti, salta all'etichetta
	# print_menu_voice_end.
	#
	jmp print_menu_voice_end

print_msg_setting_user:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_setting_user.
	#
	leal msg_setting_user, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_setting_supervisor:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_setting_supervisor.
	#
	leal msg_setting_supervisor, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_date:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_date.
	#
	leal msg_date, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_time:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_time.
	#
	leal msg_time, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_lock_door:

	# Carica nel registro EAX
	# il valore della variabile lock_door.
	#
	movl lock_door, %eax

	# Confronta il valore 0
	# con il contenuto del registro EAX.
	#
	cmpl $0, %eax

	# Se la variabile lock_door vale 0,
	# allora salta all'etichetta print_msg_lock_door_off,
	# che stampa la stringa relativa al blocco automatico
	# porte impostato a OFF.
	#
	je print_msg_lock_door_off

	# Confronta il valore 1
	# con il contenuto del registro EAX.
	#
	cmpl $1, %eax

	# Se la variabile lock_door vale 1,
	# allora salta all'etichetta print_msg_lock_door_on,
	# che stampa la stringa relativa al blocco automatico
	# porte impostato a ON.
	#
	je print_msg_lock_door_on

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_lock_door_off:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_lock_door_off.
	#
	leal msg_lock_door_off, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_lock_door_on:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_lock_door_on.
	#
	leal msg_lock_door_on, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_back_home:

	# Carica nel registro EAX
	# il valore della variabile back_home.
	#
	movl back_home, %eax

	# Confronta il valore 0
	# con il contenuto del registro EAX.
	#
	cmpl $0, %eax

	# Se la variabile back_home vale 0,
	# allora salta all'etichetta print_msg_back_home_off,
	# che stampa la stringa relativa al blocco automatico
	# porte impostato a OFF.
	#
	je print_msg_back_home_off

	# Confronta il valore 1
	# con il contenuto del registro EAX.
	#
	cmpl $1, %eax

	# Se la variabile back_home vale 1,
	# allora salta all'etichetta print_msg_back_home_on,
	# che stampa la stringa relativa al blocco automatico
	# porte impostato a ON.
	#
	je print_msg_back_home_on

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_back_home_off:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_back_home_off.
	#
	leal msg_back_home_off, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_back_home_on:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_back_home_on.
	#
	leal msg_back_home_on, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_check_oil:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_check_oil.
	#
	leal msg_check_oil, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_direction_arrows:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_direction_arrows.
	#
	leal msg_direction_arrows, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_msg_reset_tire_pressure:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_reset_tire_pressure.
	#
	leal msg_reset_tire_pressure, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta print_menu_voice_end
	# per tornare alla funzione user_mode/supervisor_mode.
	#
    jmp print_menu_voice_end

print_menu_voice_end:

    ret
