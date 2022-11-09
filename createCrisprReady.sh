#!/bin/bash
#Looking at motif_list.txt identify the top 3 most occuring motifs in each exome of exomesCohort folder
#output the headers and corresponding sequences to a new folder and file as {exomename}_topmotifs.fasta

motifs_file=./motif_list.txt #looking at motif_list.txt file
cohort_folder=./exomesCohort #looking at exomesCohort folder made from previous script, copyExomes.sh

echo "Executing with $motifs_file $cohort_folder" #making sure we are using the correct files

mkdir -p top_exomes #creates temp folder top_exomes to store top motifs

rm -f  top_exomes/* #clears folder in case it already exists, 

#looks into the motif list and goes line by line
cat $motifs_file | while read -r motif; do

    #looks at each file in the cohort_folder 
    ls $cohort_folder | while read -r exome_file; do
        
        declare -i count #necessary for integer value for variable count
        
        count=`grep -c $motif $cohort_folder/$exome_file` #counts number of motifs in each exome
        
        animal=`echo $exome_file | cut -d '.' -f1` #gets name of animal from exome file in cohort folder

        echo "$count $motif" >> top_exomes/"$animal-topmotif.txt" #adds count and motif file for each exome to top_exomes directory
    done

done

mkdir -p crispr_ready #makes directory crispr_ready
rm -f crispr_ready/*

ls top_exomes | while read -r top_file; do  #reads the motif counts files for each exome
    cat top_exomes/$top_file | sort -nr | head -3 | while read -r motif_count; do #outputs the top 3 motifs for each exome
        
        animal=`echo $top_file | cut -d '-' -f1` #gets the name of the animal from the top_exomes folder
        echo "$animal $motif_count" 
        motif=`echo $motif_count | cut -d ' ' -f2` #gets the motif pattern
        #finds the occurances of the motif and the line before to get the gene number
        #grep -v '\-' removes separator of the first grep command
        #creates file animal name_topmotifs.fasta
        grep -B 1 $motif $cohort_folder/"$animal.fasta" | grep -v '\-' >> crispr_ready/${animal}_topmotifs.fasta
    done
    
done
