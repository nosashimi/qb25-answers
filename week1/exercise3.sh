#!/bin/bash

bedtools intersect -a nhek-active.bed -b nhek-repressed.bed 
# no output, so mutually exclusive

bedtools intersect -a nhlf_active.bed -b nhlf_repressed.bed
# no output, so mutually exclusive

bedtools intersect -u -a nhek-active.bed -b nhlf_active.bed | wc -l
# 11608 for the first command

bedtools intersect -v -a nhek-active.bed -b nhlf_active.bed | wc -l
# 2405 for the second command. The numbers add up to the original number of lines.

bedtools intersect -f 1 -a nhek-active.bed -b nhlf_active.bed | head -n 1
# chr1	25558413	25559413	1_Active_Promoter	0	.	25558413	25559413
# It finds fractions of nhek-active that are completely in nhlf_active, hence NHLF has broader active range than NHEK.

bedtools intersect -F 1 -a nhek-active.bed -b nhlf_active.bed | head -n 1
# chr1	19923013	19924213	1_Active_Promoter	0	.	19922613	19924613
# It's the opposite in this case, so NHEK has broader active range than NHLF.

bedtools intersect -f 1 -F 1 -a nhek-active.bed -b nhlf_active.bed | head -n 1
# chr1	1051137	1051537	1_Active_Promoter	0	.	1051137	1051537
# They are exactly the same.

bedtools intersect -a nhlf_active.bed -b nhek-active.bed | head -n 1
# chr1	1309537	1311537	1_Active_Promoter	0	.	1309537	1311537
# Mostly active promoters with some regions of weak promoters, also one region of strong enhancers each for K562 and HUVEC.

bedtools intersect -a nhlf_repressed.bed -b nhek-active.bed | head -n 1
# chr1	24513013	24513413	12_Repressed	0	.	244848124513413
# Nearly half are fully repressed; NHEK and HepG2 are fully active; and a mixer of enhancer and weak promoter for the rest.

bedtools intersect -a nhlf_active.bed -b nhek-repressed.bed | head -n 1
# chr1	12227613	12228213	1_Active_Promoter	0	.	12226813	12228213
# A mixer of states exist in this case, 2 fully active, 2 fully repressed, 2 strong enhancers, 1 heterochrom, 1 poised, and a mixer of weak promoter, enhancer, and txn for the last.



