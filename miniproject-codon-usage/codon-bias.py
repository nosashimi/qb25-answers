#!/usr/bin/env python3

import sys
import fasta
import codons

my_file = open(sys.argv[1])
contigs = fasta.FASTAReader(my_file)
counts = dict()
usr_codon = codons.reverse[sys.argv[2]]
usr_count = 0

for ident, sequence in contigs:
    for i in range(0,len(sequence),3):
        codon = sequence[i:i+3]
        if codon in counts:
            counts[codon] += 1
        else:
            counts[codon] = 1

my_file.close()

for codon in usr_codon:
    usr_count += counts[codon]

print(f"{usr_codon}\t{usr_count}")