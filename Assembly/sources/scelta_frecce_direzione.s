.code32

.section .data

string_frecce_direzione_attuale:
	.string "          Impostazione corrente: Numero lampeggii: "

string_direction_arrows_set:
	.string "          set Numero lampeggii modalità autostrada: "


string_lamp_set:
	.string "	Numero lampeggii settata\n"

.section .text

.global scelta_frecce_direzione



# stampa il numero di lampeggii delle frecce direzione
# parametro di set ricevuto da eax
# parametro di ret inviato da eax
.type scelta_frecce_direzione, @function



scelta_frecce_direzione:

	# memorizzo il valore di eax
    	pushl %eax

print_string_frecce_direzione_attuale:

	# mi preparo a stampare string_frecce_direzione_attuale
	leal string_frecce_direzione_attuale, %ecx

    	call printf

	# metto in eax il numero di lampegii standard
	#movl $3, %eax

	# stampo eax
	call itoa

# stampa la stringa string_direction_arrows_set
print_string_direction_arrows_set:

	# mi preparo a stampare string_direction_arrows_set
	leal string_direction_arrows_set, %ecx

	call printf

press_key:

	# leggo un numero da tastiera e lo inserisco in eax
    	call atoi_read

control_value:

	# il numero e' < 2?
	cmpl $2, %eax

	# si, allora setto il valore di lampeggii al minimo
	jl set_numero_lampeggii_min

	# il numero e' > 5?
	cmpl $5, %eax

	# si, allora imposto il valore di lampeggii al massimo
	jg set_numero_lampeggii_max

	# no per entrambi i casi, quindi imposto il valore dell'utente
	jmp set_numero_lampeggii

set_numero_lampeggii_min:

	popl %eax

	movl $2, %eax

	# salvo nella variabile numero_lampeggii eax
	pushl %eax

	
	leal string_lamp_set, %ecx
    	call printf

	# fine funzione	
	jmp print_menu_direction_arrows_end

set_numero_lampeggii_max:

	popl %eax

	movl $5, %eax

	pushl %eax

	leal string_lamp_set, %ecx
    	call printf

	# fine funzione
	jmp print_menu_direction_arrows_end

set_numero_lampeggii:

	#cancello il valore precedente
	popl %edx

	pushl %eax

	leal string_lamp_set, %ecx
    	call printf

	# fine funzione
	jmp print_menu_direction_arrows_end

print_menu_direction_arrows_end:

	# Carica nel registro EAX
	# il valore della variabile numero_lampeggii.
	#
	popl %eax

    ret
