#/bin/bash

rm -f *_postcrispr.fasta

for i in `ls *_precrispr.fasta`
do
exomename=`echo $i | cut -d"_" -f1`

cat $i | sed '/CGG/ s/^/A/g' > ${exomename}_postcrispr.fasta

done
