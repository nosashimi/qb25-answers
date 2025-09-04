#!/usr/bin/env python3

fname = "/Users/cmdb/qb25-answers/unix-python-scripts/ce11_genes.bed"

my_file = open(fname)

for line in my_file:
    line = line.rstrip()
    line = line.split("\t")
    if line[5] == "-":
        line[4] = - (int(line[4]) * (int(line[2]) - int(line[1])))
    else:
        line[4] = int(line[4]) * (int(line[2]) - int(line[1]))
    print(f"{line[0]}   {line[1]}   {line[2]}   {line[3]}   {line[4]}   {line[5]}")

my_file.close()
