#!/bin/bash

rm -f *_precrispr.fasta

for i in `ls *topmotif.fasta`
do
	exomename=`echo $i | cut -d'_' -f1`
	echo $exomename
	grep 'CGG' $i | awk -F"CGG" '{ print $1 }' | awk '{ print $0,length }' > out.txt

	while read line
	do

	l=`echo "$line" | cut -d' ' -f2`
	d=`echo "$line" | cut -d' ' -f1`

	if [ $l -ge 20 ]
	then
		grep -B 1 "${d}CGG" $i >> ${exomename}_precrispr.fasta
	fi
done < out.txt


done

