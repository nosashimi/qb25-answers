Exercise 1

bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/A01_01.fq.gz > A01_01.sam

samtools sort -o A01_01.bam A01_01.sam

samtools index A01_01.bam

samtools idxstats A01_01.bam > A01_01.idxstats

Exercise 2

The alignment matches the "RBRRBB" pattern in the GenoData file, where miss-matches come mainly from the first, the third, and the fourth sample.

Exercise 4

minimap2 -a -x map-ont ../genomes/sacCer3.fa ../rawdata/ERR8562478.fastq > longreads.sam

Exercise 5

hisat2 -x ../genomes/sacCer3 -U ../rawdata/SRR10143769.fastq > rnaseq.sam

Most reads occur towards the 3' end of each gene.