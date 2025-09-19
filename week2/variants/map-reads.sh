#!/bin/bash

 for sample in A01_01 A01_02 A01_03 A01_04 A01_05 A01_06
 do
     echo "***" $sample
     ls -l ~/Data/BYxRM/fastq/$sample.fq.gz
     # mapping command e.g. bowtie2 path/to/$sample.fq.gz
     bowtie2 -p 4 -x ../genomes/sacCer3 -U ~/Data/BYxRM/fastq/$sample.fq.gz > $sample.sam
     # sort command
     samtools sort -o $sample.bam $sample.sam
     # index command
     samtools index $sample.bam
     samtools idxstats $sample.bam > A01_01.idxstats
 done