###Improved pipeline

#Updates
# Have made the paired end merging parallel this has resulted in a ~4.6 times decrease in that step
# Have made the ngsfiltering step parallel this has resulted in a ~1.6 times decrease 

### MAKE SURE TO CALL OBITOOLS FIRST TO ENTER THE CORRECT ENVIORNMENT

###The find command is used to generate a list of all the fastq files in the current directory.
###The list is then reversed the name cuts all characters up to the _R(1/2)_001.fastq, leaving only the begining of the file.
###then the line reverses again and uniques all the names leaving one per every two files (R1 and R2)
###thus creating a list of names to call for varible {}, which is the sub in place {}R2_001.fastq {}R1_001.fastq.
###The resulting output is redirected to a file, with the ending paired.fq

##Paired end merging##

find . -type f -name "*.fastq" | rev | cut -c 13- | rev | sort | uniq | parallel "illuminapairedend --score-min=40 -r {}R2_001.fastq {}R1_001.fastq > {}paired.fq"

##Making directorys to store files##

mkdir -p raw_unpaired_seqs
mv *R?_*.fastq raw_unpaired_seqs/
mkdir -p P{1,2,3,4,5,6,7,8,9,10}

##NGSFIltering by primer##

#This section will need to be modified to fit the number of primers you have used.
#Right now it is setup to use 10 filter files (i.e. we used 10 primers).
#To Modify just add or delete 

NGSfilterJS() {
	
	i=$1
	
	#Primer1
		ngsfilter $i -t ngsfil_fileP1.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER1.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER1.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp1.fastq
	#Primer2
		ngsfilter ${i%paired.fq}temp1.fastq -t ngsfil_fileP2.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER2.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER2.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp2.fastq
	#Primer3
		ngsfilter ${i%paired.fq}temp2.fastq -t ngsfil_fileP3.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER3.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER3.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp3.fastq
	#Primer4
		ngsfilter ${i%paired.fq}temp3.fastq -t ngsfil_fileP4.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER4.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER4.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp4.fastq
	#Primer5
		ngsfilter ${i%paired.fq}temp4.fastq -t ngsfil_fileP5.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER5.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER5.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp5.fastq
	#Primer6
		ngsfilter ${i%paired.fq}temp5.fastq -t ngsfil_fileP6.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER6.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER6.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp6.fastq
	#Primer7
		ngsfilter ${i%paired.fq}temp6.fastq -t ngsfil_fileP7.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER7.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER7.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp7.fastq
	#Primer8
		ngsfilter ${i%paired.fq}temp7.fastq -t ngsfil_fileP8.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER8.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER8.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp8.fastq
	#Primer9
		ngsfilter ${i%paired.fq}temp8.fastq -t ngsfil_fileP9.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER9.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER9.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp9.fastq
	#Primer10
		ngsfilter ${i%paired.fq}temp9.fastq -t ngsfil_fileP10.txt -u ${i%paired.fq}temp.fastq > ${i%paired.fq}placeholder.fq
			obigrep -a "error:Cannot assign sequence to a sample" ${i%paired.fq}temp.fastq > ${i%paired.fq}PRIMER10.fq
				obigrep -a "error:No reverse primer match" ${i%paired.fq}temp.fastq >> ${i%paired.fq}PRIMER10.fq
					obigrep -a "error:No primer match" ${i%paired.fq}temp.fastq > ${i%paired.fq}temp10.fastq
	
}
export -f NGSfilterJS

find . -type f -name "*paired.fq" | parallel NGSfilterJS

##Removing temp files created during the ngsfiltering process##

rm *temp*.fastq
rm *placeholder.fq

##Moving sorted files to the correct folders##

mv *_PRIMER1.fq P1/
mv *_PRIMER2.fq P2/
mv *_PRIMER3.fq P3/
mv *_PRIMER4.fq P4/
mv *_PRIMER5.fq P5/
mv *_PRIMER6.fq P6/
mv *_PRIMER7.fq P7/
mv *_PRIMER8.fq P8/
mv *_PRIMER9.fq P9/
mv *_PRIMER10.fq P10/

##moving paired sequences to their own folder##

mkdir -p paired_seqs
mv *paired.fq paired_seqs/

##Uniqing samples reads##

for i in P*/*.fq; do
	 obiuniq $i > $$
	 mv $$ $i
done

##Removing annotations and leaving only count##

for i in P*/*uniqed.fq; do
	obiannotate -k count $i > $$
	mv $$ $i 
done

##Removing sequence which have less than 5 reads and are smaller than 120bp##
#Of particular imporatnce in this step is the filter by count it is important to tune this
#to your dataset. In our case we wanted to observe the sources of contamination (even in low amounts) 
#within our negative controls, so we set the read count filter lower than we normally would.
#A sensible place to start is filtering by read counts around 20, as our negative controls had 
#mostly sequences with 'count>=20'.

for i in P*/*uniqed.fq; do
	obigrep -l 50 -p 'count>=5' $i > $$
	mv $$ $i
done

##This part of the will clean the sequences for PCRerrors##

for i in P*/*uniqed.fq; do
	obiclean -r 0.05 -H $i > ${i%_uniqed.fq}_clean_filtered.fasta
done

##Blasting the samples##

find P? -iname "*.fasta" | parallel blastn -db /media/kenizzer/EXT2/ntDB/nt -query {} -out {.}.out