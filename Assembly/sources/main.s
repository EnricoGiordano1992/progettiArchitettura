.code32

# variabili globali e costanti
.section .data



msg_start:
	.string "Starting...\n"

msg_user_mode:
	.string "USER MODE: ON\n"

msg_supervisor_mode:
	.string "SUPERVISOR MODE: ON\n"



# Sezione delle istruzioni
.section .text



.global _start



_start:

	# Carica nel registro ecx l'indirizzo
	# della stringa msg_start.
	#
	leal msg_start, %ecx

	# Chiama la funzione per stampare la stringa.
	#
    call print

	# Salta all'etichetta read_parameters.
	#
    jmp read_parameters

read_parameters:

    # Salva una copia di ESP in EBP per poter
    # modificare ESP senza problemi.
    # In questo punto dell'esecuzione ESP contiene
    # l'indirizzo di memoria della locazione in cui
    # si trova il numero di argomenti passati alla
    # riga di comando del programma.
	#
    movl %esp, %ebp

	# Salta all'etichetta check_user_mode.
	#
    jmp check_user_mode

check_user_mode:

    # Copia in EAX il contenuto della locazione
    # di memoria puntata da ESP, cioè copia in EAX
    # il puntatore all'indirizzo di memoria della locazione in cui
    # si trova il numero di argomenti passati alla
    # riga di comando del programma.
	#
    movl (%esp), %eax

    # Controlla il numero di parametri
    # passati alla riga di comando.
	#
    cmp $1, %eax

	# Se è stato passato un solo parametro
	# corrispondente al nome del programma,
	# allora salta all'etichetta _user_mode.
	#
    je _user_mode

	# Altrimenti, se il numero di parametri
	# è maggiore di 1, allora salta all'etichetta
	# check_supervisor_mode per controllare il parametro
	# inserito a linea di comando.
	#
    jmp check_supervisor_mode

check_supervisor_mode:

    # Somma 4 al valore di ESP. In tal modo ESP
    # punta al prossimo elemento sulla cima dello
    # stack, che contiene l'indirizzo di memoria
    # del prossimo parametro della riga di comando.
    # Alla prima iterazione, dopo questa
    # istruzione, ESP punta all'elemento dello
    # stack che contiene l'indirizzo della
    # locazione di memoria che contiene il
    # primo parametro del programma.
	#
    addl $4, %esp

    # Salta all'etichetta per recuperare
    # il parametro contenente un probabile codice.
	#
    jmp get_parameter

_user_mode:

	# Carica nel registro ecx l'indirizzo
	# della stringa msg_user_mode.
	#
    leal msg_user_mode, %ecx

	# Chiama la funzione per stampare la stringa.
	#
    call print

	# Chiama la funzione user_mode
	# che avvia il menù del cruscotto
	# in modalità utente.
	#
    call user_mode

	# Alla fine dell'esecuzione del menù
	# del cruscotto in modalità utente
	# salta alla fine del programma.
	#
    jmp _end

_supervisor_mode:

	# Carica nel registro ecx l'indirizzo
	# della stringa msg_supervisor_mode.
	#
    leal msg_supervisor_mode, %ecx

	# Chiama la funzione per stampare la stringa.
	#
    call print

	# Chiama la funzione supervisor_mode
	# che avvia il menù del cruscotto
	# in modalità supervisor.
	#
    call supervisor_mode

	# Alla fine dell'esecuzione del menù
	# del cruscotto in modalità supervisor
	# salta alla fine del programma.
	#
    jmp _end

get_parameter:

    # Somma 4 al valore di ESP. In tal modo ESP
    # punta al prossimo elemento sulla cima dello
    # stack, che contiene l'indirizzo di memoria
    # del prossimo parametro della riga di comando.
    # Alla prima iterazione, dopo questa
    # istruzione, ESP punta all'elemento dello
    # stack che contiene l'indirizzo della
    # locazione di memoria che contiene il
    # primo parametro del programma.
    addl $4, %esp

    # Copia in EAX il contenuto della locazione
    # di memoria puntata da ESP, cioè copia in EAX
    # il puntatore al prossimo parametro della riga
    # di comando (oppure NULL se non ci sono altri
    # parametri).
    movl (%esp), %eax

    # Controlla se EAX contiene NULL (cioè 0). In
    # tal caso significa che ho già recuperato
    # tutti i parametri.
    testl %eax, %eax

    # Esce dal ciclo se non ci sono altri parametri
    # da recuperare.
    jz _end

	# Chiama la funzione atoi
	# che converte in un intero
	# il parametro passato alla linea di comando
	# restituendolo nel registro eax.
	#
    call atoi

	# Controlla che il parametro corrisponda
	# al codice 2244, il quale corrisponde
	# alla modalità supervisor di avviamento
	# del menù del cruscotto.
	#
    cmpl $2244, %eax

	# Se il codice corrisponde a 2244,
	# allora salta all'etichetta _supervisor_mode.
	#
    je _supervisor_mode

    # Richiama la funzione per stampare il
    # parametro. ESP punta alla locazione di memoria
    # che contiene l'indirizzo del parametro da
    # considerare. Al posto di tale funzione si
    # potrebbe inserire il codice che elabora il dato,
    # invece di stamparlo.
    movl (%esp), %ecx
    call print

    # Stampa il carattere di new line.
	#
    call new_line

    # Ricomincia il ciclo per recuperare gli altri
    # parametri.
	#
    jmp get_parameter

_end:

	# Chiama la funzione end
	# permette di uscire dal programma.
	#
	call end