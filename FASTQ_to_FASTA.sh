#!/usr/bin/env bash

# The purpose of this script is to convert FASTQ into FASTA files
# First I tried Hannons Lab FASTX-Toolkit FASTQ_TO_FASTA program
# but it cannot handle sequences being in lowercase. 
# I thought about swaping the case of the seqeucnes but this proved to
# be an easier solution.

# Script #
# finds all FASTQ files in the directory 
# then preforms a few simple formating tricks to get the Q scores
# into a column it removes before translating the columns back to
# individual lines (i.e. \t to \n)

##Note this will leave the original FASRQ file in place and unchanged.

##This script is a modified version of the Pierre Lindenbaum from (https://www.biostars.org/p/85929/)

read -e -p "Please enter the file extension used (i.e. .fq .fastq .FASTQ .fq.gz etc): " Ending

if [[ "$Ending" != *.gz ]]
then
#For uncompresed files
	for i in *"$Ending" ; do
	cat "$i" | paste - - - - | cut -f 1,2 | sed 's/^/>/' | tr "\t" "\n" > "${i%$Ending}.fa"
	done
else
#For files that are compressed with Gzip, checked with test in if statment
	for i in *"$Ending" ; do
	gunzip -c "$i" | paste - - - - | cut -f 1,2 | sed 's/^/>/' | tr "\t" "\n" > "${i%$Ending}.fa"
	done
fi