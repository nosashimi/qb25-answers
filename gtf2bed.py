#!/usr/bin/env python3

fname = "/Users/cmdb/Data/References/hg38/gencode.v46.basic.annotation.gtf"

fs = open(fname)

for line in fs:
    line = line.rstrip()
    if line.startswith("#"):
        continue
    else:
        line = line.split("\t")
        if line[2] == "gene":
            print(f"{line[0]}   {int(line[3]) - 1}  {line[4]}   {line[8]}")