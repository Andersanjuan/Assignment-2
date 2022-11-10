#!/bin/env python3
#generates a summary report of findings in a text file listing the name, diameter, code name
#and the environment that it came from. A final line will also print out all the genes that were
#present in the cohort, as a union of all the genes with no duplicates.

import os
# os.remove("genedetails.txt")

DIR="/home/sanja/week4/exomesCohort" #looking at directory holding script

print ('\nOrganism,DISCOVERER,DIAMETER,ENVIRONMENT') #prints headers of interest

f = open("clinical_data.txt").readlines() #looking at clinical_data, reads each line
firstLine = f.pop(0) #removes the first line, removing headers
for line in f: #looking at each line, do this:

  v=line.split('\t')[2] #separates by tab, looking at diameter
  s=line.split('\t')[4] #looking at status
  if (int(v) >= 20 and int(v) <= 30) and (s == "Sequenced"): #if diameter is 20-30mm and is "Sequenced"
      print(line.split('\t')[5].replace("\n", "") + "," +line.split('\t')[0]+","+line.split('\t')[2]+","+line.split('\t')[3])
#prints discover, code_name, diameter, if condition is met
DIR="/home/sanja"
file_location = os.path.join(DIR,'week4', '*_precrispr.fasta') #looking at precrispr.fasta files
#print(file_location)

import glob #to use the global expression, "for each file"
import re # to use regex operations, regular expression operations
filenames = glob.glob(file_location) 
#print(filenames)

for fi in filenames: # looking at each file that is precrispr.fasta
     outfile = open(fi,'r')
     data = outfile.readlines() #reads line by line
     outfile.close()
     for line in data: #looking at each line of precrispr
         #print(line)
         if re.search('gene',line): #looks for "gene"
             with open('genedetails.txt', 'a') as f:
                     f.write(line.replace(">","").upper()) #removes > from header,gene

lines = open('genedetails.txt', 'r').readlines() #

lines_set = set(lines) #removes duplicates, and captures only needed data

#print(lines_set)
count = sum(1 for line in lines_set) #gives count of number of genes that are the same across cohort
print("\nThe number of the union of genes across the cohort is " + str(count) +". Those genes are:")
out  = open('genedetails.txt', 'r+')
for line in lines_set:
       #print(line.replace("\n",","),end="")
       out.write(line.replace("\n",",")) #adds comma between genes

out = open('genedetails.txt', 'r')
for line in out:
      print(line.rstrip(",")) #removes last comma




