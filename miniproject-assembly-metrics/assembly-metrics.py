#!/usr/bin/env python3

import sys
import fasta

my_file = open(sys.argv[1])
assemblies = fasta.FASTAReader(my_file)

i = 0
tot_len = 0
for ident, sequence in assemblies:
    i += 1
    tot_len += len(sequence)

my_file.close()
    
print(f"Number of contigs: {i}")
print(f"Total length: {tot_len}")
print(f"Average length: {int(tot_len / i)}")