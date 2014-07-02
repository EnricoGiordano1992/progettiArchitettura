.code32

.section .data

supervisor:
	.long 0

string_setting_user:
	.string "     1. Setting automobile:\n"

string_setting_supervisor:
	.string "     1. Setting automobile (supervisor):\n"

string_date:
	.string "     2. Data: 15/06/2014\n"

string_time:
	.string "     3. Ora: 15:32\n"

string_lock_door_on:
	.string "     4. Blocco automatico porte: ON\n"

string_lock_door_off:
	.string "     4. Blocco automatico porte: OFF\n"

lock_door:
    .long 0

string_back_home_on:
	.string "     5. Back-home: ON\n"

string_back_home_off:
	.string "     5. Back-home: OFF\n"

back_home:
    .long 0

string_olio:
	.string "     6. Check olio\n"

string_frecce_direzione:
	.string "     7. Frecce direzione\n"


string_reset_pressione:
	.string "     8. Reset pressione gomme\n"



# Sezione delle istruzioni
.section .text



.global menu



# Stampa la voce del menù secondo
# il valore passato tramite
# registro eax
.type menu, @function



menu:

	# memorizzo i valori che mi serviranno dopo
	movl %ebx, supervisor

	movl %ecx, lock_door

	movl %edx, back_home

	# quale voce del menu' devo stampare?
    	cmpl $1, %eax

	# la prima
    	je print_string_setting

    	cmpl $2, %eax

	# la seconda
    	je print_string_date

     	cmpl $3, %eax

	# la terza
    	je print_string_time

    	cmpl $4, %eax

	# la quarta
    	je print_string_lock_door

    	cmpl $5, %eax

	# la quinta
    	je print_string_back_home

    	cmpl $6, %eax

	# la sesta
    	je print_string_olio

	cmpl $7, %eax

	# la settima
    	je print_string_frecce_direzione

	cmpl $8, %eax

	# l'ottava
    	je print_string_reset_pressione

print_string_setting:

	# sono in modalita' supervisor?
	cmpl $0, %ebx

	# no, allora stampo user
	je print_string_setting_user

	jmp print_string_setting_supervisor

print_string_setting_user:

	# stampo string_setting_user
	leal string_setting_user, %ecx

    	call printf

    	jmp menu_end

print_string_setting_supervisor:

	# stampo string_setting_supervisor
	leal string_setting_supervisor, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    	call printf

    	jmp menu_end

print_string_date:

	# stampo string_date
	leal string_date, %ecx

    	call printf

    	jmp menu_end

print_string_time:

	leal string_time, %ecx

    	call printf

    	jmp menu_end

print_string_lock_door:

	# riottengo il valore lock_door in eax
	movl lock_door, %eax

	# vale 0 ?
	cmpl $0, %eax

	# si, allora la porta e' bloccata e lo stampo
	je print_string_lock_door_off

	# no, allora la porta non e' bloccata e lo stampo
	jmp print_string_lock_door_on

    	jmp menu_end

print_string_lock_door_off:

	leal string_lock_door_off, %ecx

    	call printf

    	jmp menu_end

print_string_lock_door_on:

	leal string_lock_door_on, %ecx

    	call printf

    	jmp menu_end

print_string_back_home:

	# riottengo il valore back_home in eax
	movl back_home, %eax

	# vale 0?
	cmpl $0, %eax

	# si, allora stampo che non e' attiva questa impostazione
	je print_string_back_home_off

	# no, allora stampo che e' attiva
	jmp print_string_back_home_on

    	jmp menu_end

print_string_back_home_off:

	leal string_back_home_off, %ecx

    	call printf

    	jmp menu_end

print_string_back_home_on:

	leal string_back_home_on, %ecx

   	 call printf

    	jmp menu_end

print_string_olio:

	leal string_olio, %ecx

    	call printf

    	jmp menu_end

print_string_frecce_direzione:

	leal string_frecce_direzione, %ecx

    	call printf

    	jmp menu_end

print_string_reset_pressione:

	leal string_reset_pressione, %ecx

    	call printf

    jmp menu_end

menu_end:

    ret
