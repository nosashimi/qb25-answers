#!/usr/bin/env python3

import sys
import fasta

my_file = open(sys.argv[1])
assemblies = fasta.FASTAReader(my_file)

len_list = list()
i = 0
tot_len = 0
for ident, sequence in assemblies:
    i += 1
    tot_len += len(sequence)
    len_list.append(len(sequence))

my_file.close()

len_list.sort(reverse = True)
cu_len = 0
for leng in len_list:
    if cu_len > 0.5 * tot_len:
        print(f"The sequence length of the shortest contig at 50% of the total assembly length is {leng}.")
        break
    else:
        cu_len += leng

    
print(f"Number of contigs: {i}")
print(f"Total length: {tot_len}")
print(f"Average length: {int(tot_len / i)}")