#/bin/bash
#looking at the precrispr.fasta files previously created, insert an A right before the NGG site
#outputs {exomename}_postcrispr.fasta, containing genes and selected sequences.

rm -f *_postcrispr.fasta #removes _postcrispr.fasta files if they exist

for i in `ls *_precrispr.fasta` #looking at all _precrispr.fasta files do the following
do
exomename=`echo $i | cut -d"_" -f1` #gets animal name

cat $i | sed 's/\([ACGT]\{20,\}GG\)/A\1/g' > ${exomename}_postcrispr.fasta #looking at each line, insert an A before the {ATCG]GG pattern and outputs into new fasta file

done
