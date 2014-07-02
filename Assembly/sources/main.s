.code32

# variabili globali e costanti
.section .data



string_start:
	.string "Starting\n"

string_user_mode:
	.string "USER MODE: ON\n"

string_superuser_mode:
	.string "superuser MODE: ON\n"

string_error:
	.string "ERROR WRONG PASSWORD\n"

# Sezione delle istruzioni
.section .text



.global _start



_start:

	# Carica nel registro ecx l'indirizzo
	# della stringa string_start
	leal string_start, %ecx

	# Chiama la funzione print (stampa la stringa)
	call printf

	# Salta in read_parameters
	jmp read_parameters

read_parameters:

    	# Salva una copia di ESP in EBP 
	# ora punta al numero degli argomenti
	# passati da riga di comando
    movl %esp, %ebp

	# Salta all'etichetta is_user_mode
	jmp is_user_mode

is_user_mode:

    	# Copia in EAX cio' a cui punta esp (numero di argomenti)
	movl (%esp), %eax

   	 # il numero di argomenti e' 1?
	cmp $1, %eax

	# si, allora salta all'etichetta _user_mode
	je _user_mode

	
	# no, allora ho inserito la password
	jmp is_superuser_mode

is_superuser_mode:

    
    	# incremento il puntatore alla cima dello
	# stack di 1 (4), per puntare al primo
	# parametro passato da riga di comando
	addl $4, %esp

    	# recupero la password
	jmp get_password

_user_mode:

	# Carica nel registro ecx l'indirizzo
	# della stringa string_user_mode
	leal string_user_mode, %ecx

	# eseguo la print
	call printf

	# attivo menu' cruscotto
	call user_mode

	# salto alla terminazione del programma
	jmp _end

_superuser_mode:

	# carico l'indirizzo della stringa
	leal string_superuser_mode, %ecx

	# Chiama la funzione per stampare la stringa
	call printf

	# avvio il menu' in modalita' superuser
	call superuser_mode

	# salto alla terminazione del programma
	jmp _end

get_password:

	# incremento di 1 (4) per prendere il primo parametro
	# dello stack
    addl $4, %esp

   # Copia in EAX cio' a cui punta esp (password)
    movl (%esp), %eax

    # eax vale 0?
    testl %eax, %eax

    # si, termino il programma
    jz _end

	# no, converto la stringa in intero
	call atoi

	# la stringa ottenuta è uguale alla password?
	cmpl $2244, %eax

	# si, allora attivo la modalita' superuser
	je _superuser_mode

    # Stampa il carattere \n
	call new_l

	# Carica nel registro ecx l'indirizzo
	# della stringa string_error
	leal string_error, %ecx

	# eseguo la print
	call printf

_end:

	# esco dal programma
	call end
