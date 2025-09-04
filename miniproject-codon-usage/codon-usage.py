#!/usr/bin/env python3

import sys
import fasta
import codons

aas = dict()

my_file = open(sys.argv[1])
contigs = fasta.FASTAReader(my_file)

for ident, sequence in contigs:
    # print(ident)
    for i in range(0,len(sequence),3):
        codon = sequence[i:i+3]
        # print(codon)
        aa = codons.forward[codon]
        if aa in aas:
            aas[aa] += 1
        else:
            aas[aa] = 1

my_file.close()

print(aas)
