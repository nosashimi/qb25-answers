#!/bin/bash

bedtools intersect -c -a hg19-kc.bed -b snps-chr1.bed | sort -k 5 | tail
# chr1	173384836	173409596	ENST00000778987.1_2	99
# chr1	233086356	233119628	ENST00000366628.10_4	99
# chr1	29063451	29096287	ENST00000373812.8_8	99
# chr1	36235694	36272545	ENST00000786197.1_1	99
# chr1	87794562	87814606	ENST00000370544.10_4	99
# chr1	88751141	88776966	ENST00000737208.1_2	99
# chr1	83368865	83632498	ENST00000452901.5_3	992
# chr1	92145899	92351708	ENST00000212355.9_11	992
# chr1	247108848	247242038	ENST00000465049.6_8	993
# chr1	23037331	23247993	ENST00000374630.8_7	995
# Systematic name: ENST00000374630.8_7, human readable name: EPHB2, position: hg19 chr1:23,037,332-23,247,993, size: 210,662, exon count: 16.
# This gene has the most SNPs in chr1 possibly because it has a large number of bases and exons, hence more likely to vary.

bedtools sample -n 20 -seed 42 -i snps-chr1.bed > snps-chr1-sample.bed

bedtools sort -i snps-chr1-sample.bed > snps-chr1-sorted.bed

bedtools sort -i hg19-kc.bed > hg19-kc-sorted.bed

bedtools closest -d -t first -a snps-chr1-sorted.bed -b hg19-kc-sorted.bed | cut -f 11
# 0
# 15658
# 0
# 0
# 1664
# 4407
# 0
# 0
# 0
# 0
# 0
# 0
# 6336
# 0
# 22944
# 0
# 0
# 0
# 0
# 0
# 15 SNPs are inside of a gene, for the 5 out side of a gene, the range of their distance is 22944-1664=21280.