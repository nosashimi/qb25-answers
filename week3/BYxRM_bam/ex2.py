#!/usr/bin/env python3

af = ""
for line in open("/Users/cmdb/qb25-answers/week3/BYxRM_bam/biallelic.vcf"):
    if line.startswith('#'):
        continue
    line = line.rstrip('\n').split('\t')
    field = line[7].split(";")
    af += f"{field[3].split("=")[1]}\n"

with open("AF.txt", "w") as file:
    file.write(af)

dp = ""
for line in open("/Users/cmdb/qb25-answers/week3/BYxRM_bam/biallelic.vcf"):
    if line.startswith('#'):
        continue
    line = line.rstrip('\n').split('\t')
    for i in range(9,19):
        dp += f"{line[i].split(":")[2]}\n"

with open("DP.txt", "w") as file:
    file.write(dp)