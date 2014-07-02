FILE=`ls`

for i in $FILE; do

	#primo carattere del nome file
	FIRST=`echo $i | head -c 1 | tr '[:lower:]' '[:upper:]'`

	#ottengo i nomi delle variabili sis
	VAR=`cat $i | grep .input`

	echo variabili= $VAR;

	for j in $VAR; do
		if [[ $j != ".inputs"  ]]; then
			OUTPUT=`echo $FIRST$j`
			echo cambio $j con $OUTPUT
			sed "s/$j/$OUTPUT/g" "$i" > "$i".p1
			i+=".p1"
		fi
	done;

	FINAL_FILE=`echo $i | cut -d '.' -f -1`
	cat $i > $FINAL_FILE.done1
	rm -f *.p1*

done;

FILE=`ls *.done1`

for i in $FILE; do

	#primo carattere del nome file
	FIRST=`echo $i | head -c 1 | tr '[:lower:]' '[:upper:]'`

	#ottengo i nomi delle variabili sis
	VAR=`cat $i | grep .output`

	echo variabili= $VAR;

	for j in $VAR; do
		if [[ $j != ".outputs"  ]]; then
			OUTPUT=`echo $FIRST$j`
			echo cambio $j con $OUTPUT
			sed "s/$j/$OUTPUT/g" "$i" > "$i".p2
			i+=".p2"

		fi
	done;


	FINAL_FILE=`echo $i | cut -d '.' -f -1`
	cat $i > $FINAL_FILE.done2
	rm -f *.p2*

done;

rm -f *.done1

rm -f *.blif

FILE=`ls *.done2`

for i in $FILE; do

	FINAL_FILE=`echo $i | cut -d '.' -f -1`
	cat $i > $FINAL_FILE.blif
done

rm -f *.done2

	


