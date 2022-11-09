#!/bin/bash
#Takes all .fasta files from exomes and copies them into exomesCohort following two conditions:
#Condition1: sample is 20-30nm (inclusive)
#condition2: sample is sequenced

mkdir -p ./exomesCohort #Creates directory "exomesCohort" if it doesn't already exist

input= awk -F '\t' '$3 >= 20 && $3 <=30 && $5 == "Sequenced"' ./clinical_data.txt | awk -F '\t' '{ print $6 }' > data.txt 
#looks into clinical_data.txt file and outputs code_names that are only 20-30nm long and are "sequenced", output is stored in data.txt file

while IFS=$'\t' read -r line; #iterates output to be read line by line
do
    
    cp ./exomes/"$line".fasta ./exomesCohort #for each name finds matching file in exomes and adds to new directory "exomesCohort"
    
done < data.txt
