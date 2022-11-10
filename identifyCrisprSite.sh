 #!/bin/bash
#using genes from exomename_topmotifs.fasta files in the crispr_ready folder identify CRISPR sites
#Find the sequences which contain "NGG", where "N" can be any base, that has at least 20 bps upstream
#output headers and sequences to a new file {exome_name}_precrispr.fasta

rm -f *_precrispr.fasta #removes precrispr.fasta file if it already exists

for i in `ls *topmotif.fasta` #for loop looking at all the topmotif.fasta files
do
	exomename=`echo $i | cut -d'_' -f1` #gets the name of the animal
	echo $exomename #checks animal name that we are working with
	grep '[ATCG]GG' $i | awk -F"[ATCG]GG" '{ print $1 }' | awk '{ print $0,length }' > out.txt #looks for [ATCG]GG pattern and gives the length of basepairs

	while read line #reads line by line of selected topmotif fasta file with crispr site
	do

	l=`echo "$line" | cut -d' ' -f2` #gets length of line with the crispr site
	d=`echo "$line" | cut -d' ' -f1` #takes baspairs left of the [ATCG]GG pattern

	if [ $l -ge 20 ] #if there are 20 bps upstream of the [ATCG]GG pattern, greater or equal to 20
	then
		grep -B 1 "${d}[ATCG]GG" $i >> ${exomename}_precrispr.fasta #outputs header and sequences of genes with crispr sites into new fasta file
	fi
done < out.txt

done

