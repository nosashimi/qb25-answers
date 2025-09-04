#!/usr/bin/env python3

import sys
import fasta
import codons

aas1 = dict()
aas2 = dict()

my_file = open(sys.argv[1])
your_file = open(sys.argv[2])
contigs1 = fasta.FASTAReader(my_file)
contigs2 = fasta.FASTAReader(your_file)

for ident, sequence in contigs1:
    # print(ident)
    for i in range(0,len(sequence),3):
        codon = sequence[i:i+3]
        # print(codon)
        aa = codons.forward[codon]
        if aa in aas1:
            aas1[aa] += 1
        else:
            aas1[aa] = 1

for ident, sequence in contigs2:
    for i in range(0,len(sequence),3):
        codon = sequence[i:i+3]
        aa = codons.forward[codon]
        if aa in aas2:
            aas2[aa] += 1
        else:
            aas2[aa] = 1

alpha_aa = sorted(list(codons.reverse.keys()))

my_file.close()
your_file.close()

for aa in alpha_aa:
    print(f"{aa}\t{aas1[aa]}\t{aas2[aa]}")

# print(aas)
