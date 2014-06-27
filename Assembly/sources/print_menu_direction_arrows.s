.code32

.section .data



# DIRECTION ARROWS

msg_direction_arrows_current:
	.string "          Impostazione corrente: Numero lampeggi: "

msg_direction_arrows_set:
	.string "          SET Numero lampeggi modalità autostrada: "

num_lights:
    .long 3



# Sezione delle istruzioni
.section .text



.global print_menu_direction_arrows



# Funzione PRINT_MENU_DIRECTION_ARROWS
#
# Stampa il numero di lampeggi
# delle frecce direzione in base al valore
# della variabile num_lights passato nel registro EAX.
# Inoltre questa funzione permette di impostare
# un nuovo valore per num_lights, che può assumere valori
# compresi tra 2 e 5, inserendolo da tastiera.
# Il nuovo valore di num_lights viene
# restituito nel registro EAX.
#
.type print_menu_direction_arrows, @function



print_menu_direction_arrows:

	# Salva nella variabile num_lights
	# il contenuto del registro EAX.
	#
    movl %eax, num_lights

	# Salta all'etichetta print_msg_direction_arrows_current
	# che stampa il valore di num_lights.
	#
	jmp print_msg_direction_arrows_current

print_msg_direction_arrows_current:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_direction_arrows_current.
	#
	leal msg_direction_arrows_current, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Carica nel registro EAX
	# il valore della variabile num_lights.
	#
	movl num_lights, %eax

	# Chiama la funzione itoa,
	# che dato un numero nel registro EAX
	# lo converte in una stringa e lo stampa.
	#
	call itoa

	# Salta all'etichetta print_msg_direction_arrows_set
	# che stampa la stringa msg_direction_arrows_set.
	#
	jmp print_msg_direction_arrows_set

print_msg_direction_arrows_set:

	# Carica nel registro ECX
	# l'indirizzo della variabile msg_direction_arrows_set.
	#
	leal msg_direction_arrows_set, %ecx

	# Chiama la funzione print
	# che stampa una stringa passata nel registro ECX.
	#
    call print

	# Salta all'etichetta press_key
	# che legge una carattere da tastiera.
	#
    jmp press_key

press_key:

	# Chiama la funzione atoi_read
	# che legge un numero inserito da tastiera
	# e lo restituisce nel registro EAX.
	#
    call atoi_read

	# Salta all'etichetta control_value
	# per controllare il valore inserito da tastiera.
	#
	jmp control_value

control_value:

	# Confronta il valore 2 con il
	# contenuto del registro EAX, che contiene
	# il numero inserito da tastiera.
	#
	cmpl $2, %eax

	# Se il valore inserito da tastiera è minore di 2,
	# allora salta all'etichetta set_num_lights_min,
	# che assegna a num_lights il valore minimo 2.
	#
	jl set_num_lights_min

	# Confronta il valore 5 con il
	# contenuto del registro EAX, che contiene
	# il numero inserito da tastiera.
	#
	cmpl $5, %eax

	# Se il valore inserito da tastiera è maggiore di 5,
	# allora salta all'etichetta set_num_lights_max,
	# che assegna a num_lights il valore massimo 5.
	#
	jg set_num_lights_max

	# Altrimenti, se il valore inserito da tastiera
	# è compreso tra 2 e 5, allora salta all'etichetta
	# set_num_lights, che assegna a num_lights il valore
	# inserito da tastiera.
	#
	jmp set_num_lights

set_num_lights_min:

	# Carica nel registro EAX il valore 2.
	#
	movl $2, %eax

	# Salva nella variabile num_lights
	# il valore contenuto nel registro EAX.
	#
	movl %eax, num_lights

	# Salta all'etichetta print_menu_direction_arrows_end,
	# che restituisce il controllo alla funzione chiamante.
	#	
	jmp print_menu_direction_arrows_end

set_num_lights_max:

	# Carica nel registro EAX il valore 5.
	#
	movl $5, %eax

	# Salva nella variabile num_lights
	# il valore contenuto nel registro EAX.
	#
	movl %eax, num_lights

	# Salta all'etichetta print_menu_direction_arrows_end,
	# che restituisce il controllo alla funzione chiamante.
	#
	jmp print_menu_direction_arrows_end

set_num_lights:

	# Salva nella variabile num_lights
	# il valore contenuto nel registro EAX.
	#
	movl %eax, num_lights

	# Salta all'etichetta print_menu_direction_arrows_end,
	# che restituisce il controllo alla funzione chiamante.
	#
	jmp print_menu_direction_arrows_end

print_menu_direction_arrows_end:

	# Carica nel registro EAX
	# il valore della variabile num_lights.
	#
	movl num_lights, %eax

    ret
