#!/usr/bin/env python3

import sys
import fasta

my_file = open(sys.argv[1])
contigs = fasta.FASTAReader(my_file)

for ident, sequence in contigs:
    # print(ident)
    for i in range(0,len(sequence),3):
        codon = sequence[i:i+3]
        # print(codon)

my_file.close()
