#!/usr/bin/env python3

import sys

sfile = open(sys.argv[1])

chcount = dict()
mcount = dict()

for line in sfile:
    line = line.rstrip()
    if line.startswith("@"):
        continue
    line = line.split("\t")
    if line[2] in chcount:
        chcount[line[2]] += 1
    else:
        chcount[line[2]] = 1
    for field in line:
        if field.startswith('NM:i:'):
            if field.split(":")[2] in mcount:
                mcount[field.split(":")[2]] += 1
            else:
                mcount[field.split(":")[2]] = 1

for key, value in chcount.items():
    print(key, value)

for key, value in sorted(mcount.items()):
    print(key, value)

sfile.close()

