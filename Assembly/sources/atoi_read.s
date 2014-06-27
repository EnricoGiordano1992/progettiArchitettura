# per convertire i caratteri in numero si utilizza la formula ricorsiva
# 
# 10*(10*(10*d    + d   ) + d   ) + d
#             N-1    N-2     N-3     N-4
#


.section .data
	
car:
  .byte 0   # la variabile car e' dichiarata di tipo byte

.section .text
.global atoi_read

.type atoi_read, @function # dichiarazione della funzione atoi_read
                      # la funzione converte una stringa di caratteri
		      # proveniente da tastiera e delimitata da '\n'
		      # in un numero che viene restituito nel registro eax
atoi_read:   

  pushl %ebx          # salvo il valore corrente di ebx sullo stack
  pushl %ecx          # salvo il valore corrente di ecx sullo stack
  pushl %edx          # salvo il valore corrente di edx sullo stack

  xorl %eax, %eax
  
inizio:

  pushl %eax
  
  movl  $3, %eax      # carica in eax il codice della chiamata di sistema read
  xorl  %ebx, %ebx    # azzera ebx (0=tastiera)
  leal  car, %ecx     # carica in ecx l'indirizzo di car in cui verra' salvato
                      # il carattere letto
  mov   $1, %edx      # comanda di leggere un solo carattere
  int   $0x80         # chiamata di sistema

  cmp   $10, car      # vedo se e' stato letto il carattere '\n'
  je    fine
	
  subb  $48, car      # converte il codice ASCII della cifra nel numero corrisp.
  popl  %eax
  movl  $10, %ebx
  mull  %ebx          # eax = eax * 10 + car

  # sto trascurando i 32 bit piu' significativi del risultato 
  # della moltiplicazione che sono in edx 
  # quindi il numero introdotto da tastiera deve essere minore di 2^32
  
  addl  car, %eax 
  jmp   inizio

fine:

  popl %eax  

                      # ripristino dei registri salvati sullo stack
		      # l'ordine delle pop deve essere inverso delle push
  popl %edx           # ripristino il valore di edx all'inizio della chiamata  
  popl %ecx           # ripristino il valore di ecx all'inizio della chiamata  
  popl %ebx           # ripristino il valore di ebx all'inizio della chiamata  

  ret             # fine della funzione atoi
                  # l'esecuzione riprende dall'istruzione sucessiva
                  # alla call che ha invocato atoi
