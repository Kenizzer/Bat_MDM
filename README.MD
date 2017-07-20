# Bat Multifaceted DNA Metabarcoding (MDM) Pipeline

As always, everything in this pipeline is as is. There will be mistakes so take care to double check your
results!

## Useful commands to know when working in UNIX
man will show the manual for a command in UNIX, these are very detailed and are invaluble.

	$ man some_command

Checks permissions & size
[PHOTO](http://linuxcommand.org/images/file_permissions.png)

	$ ls -lsha    

Give a file execute permission

	$ chmod u+x filename.sh

Nano is a text editor, useable from the command line. It is simple and can get the job done quick.

	$ nano 

If you scripts in more than a simple loop or series of commands go to a real text editor
examples Sublime text, Notepad++, Emacs etc

Be mindful of line endings as these can cause scripts to fail, Notepad ++ on windows the default EOL (End of 
line) is windows format and you must change it to UNIX for the script to run(Don't forget the execution permissions).

## OBITOOLS

It is very wise to consult all the documentaion on the OBITOOLS website before beginning as it will save 
some headaches later. *You were warned!*

[OBITOOLS Website](http://metabarcoding.org/obitools/doc/)

## Parallel pipeline

It is very important to call OBITOOLS, in order to set the right environment before starting the pipeline.

### Required Programs 

[OBITOOLS](https://git.metabarcoding.org/obitools/obitools/wikis/home)

[GNUparallel](https://www.gnu.org/software/parallel/)

[BLAST+ suite](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)

Optional Programs (can make your life easier)

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

[MultiQC](https://github.com/ewels/MultiQC)

[MicNeSs](http://wwwabi.snv.jussieu.fr/public/MicNeSs/)
 -Only needed if you would like to score microsatellites from NGS reads. See documentation on the MicNeSs website and [Marie Suez et al. 2016](http://onlinelibrary.wiley.com/doi/10.1111/1755-0998.12467/full) for more details about how this is conducted.

The parallel pipeline script takes a few basic items to run 

	1. Fastq files from an illumina platform (R1 & R2 files)
	2. Filter files for demultiplexing your reads into seperate primers (See example in the repo)
	3. A database to search against for Taxa annotation (Most public databases can be downloaded through an FTP server)

The pipeline consists of seven main parts

	1. Paired read merging 
	2. Demultiplexing by primer
	3. Dereplicate reads into unique sequences
	4. Removing all annotations in the header line except number of reads
	5. Filtering based on length and number of reads
	6. Cleaning the sequences of PCRerrors and chimeras
	7. Blasting against a local NCBI nt database