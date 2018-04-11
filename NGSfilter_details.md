Our demultiplxing strategy differed from the standard operating procedure of 
***ngsfilter***. We used illumina indices without “tag” sequences in our experimental 
design. We ran ***ngsfilter*** with __demultiplex files for each primer__, each containing
 a single primer with tags as “-:-“ (e.g. see ngsfil_file1.txt).

This results in a file with each sequence possessing a single addition to the 
header line, out of three possible.

1. "error:Cannot assign sequence to a sample"
2. "error:No reverse primer match"
3. "error:No primer match"

Each of these messages means

1. Matches forward and reverse primers, but because tag sequences are absent it
cannot sort it to a sample.
2. Matches only the forward primer sequence, but again cannot sort to sample.
3. No matches to either primer, again cannot sort to sample.

So, to demultiplex by primer we run NGSfilter for a single marker, removed 
sequences that possess error messages 1 & 2 using OBIgrep to a file 
(this is demultiplexed now), then pass the file with all sequences with error 
message 3 to the next NGSfilter command with another primer repeating until we 
have processed all the primers. In this way you are working with a smaller file 
each iteration. I wrote this into a bash function, such that multiple files are 
demultiplexed simultaneously, and run with GNUparallel to speed up this process.