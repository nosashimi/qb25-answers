#!/usr/bin/env python3

# Q. 3.1: A01_09, A01_11, A01_23, A01_35, and A01_39 are derived from the lab strain, while the rest are from the wine strain since they enriched for differences.

long = ""
sample_ids = ["A01_62", "A01_39", "A01_63", "A01_35", "A01_31", "A01_27", "A01_24", "A01_23", "A01_11", "A01_09"]
for line in open("/Users/cmdb/qb25-answers/week3/BYxRM_bam/biallelic.vcf"):
    if line.startswith('#'):
        continue
    field = line.rstrip('\n').split('\t')
    chrom = field[0]
    pos = field[1]
    for i in range(9, 18):
        if field[i].split(":")[0] == ".":
            continue
        else:
            long += f"{sample_ids[i - 9]}\t{chrom}\t{pos}\t{field[i].split(":")[0]}\n"


with open("gt_long.txt", "w") as file:
    file.write("Sample_ID\tChromosome\tPosition\tGenotype\n")
    file.write(long)
