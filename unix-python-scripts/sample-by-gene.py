#!/usr/bin/env python3

fname = "/Users/cmdb/qb25-answers/unix-python-scripts/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_tpm.gct"

fs = open(fname)

_ = fs.readline()
_ = fs.readline()

header = fs.readline().rstrip().split("\t")
data = fs.readline().rstrip().split("\t")

fs.close()

s1_dict = dict()
for i in range(len(header)):
    s1_dict[header[i]] = data[i]

mname = "/Users/cmdb/qb25-answers/unix-python-scripts/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt"

ms = open(mname)

for line in ms:
    line = line.rstrip().split("\t")
    if line[0] in s1_dict:
        print(f"{line[0]}   {s1_dict[line[0]]}  {line[6]}")

ms.close()

# The first three tissues are Brain - Cortex, Adrenal Gland, and Thyroid.
