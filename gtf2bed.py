#!/usr/bin/env python3

fname = "/Users/cmdb/Data/References/hg38/gencode.v46.basic.annotation.gtf"

fs = open(fname)

for line in fs:
    line.rstrip()
    if line.startswith("#"):
        continue
    else:
        