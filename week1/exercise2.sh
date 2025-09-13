#!/bin/bash

wc -l hg19-kc.bed
# 80270
# There are 80270 genes in hg19.

wc -l hg16-kc.bed
# 21365
# There are 21365 genes in hg16.

bedtools intersect -v -a hg19-kc.bed -b hg16-kc.bed | wc -l
# 42717
# There are 42717 genes in hg19 but not in hg16.

bedtools intersect -v -a hg16-kc.bed -b hg19-kc.bed | wc -l
# 3460
# There are 3460 genes in hg16 but not in hg19.

# Since hg19 is a newer version, more advanced sequencing tools allowed the discovery of much more genes that were not noted in hg16.
# On the other hand, genes that were included in hg16 but excluded in hg19 may be due to improved gene prediction algorithms. So some genes in hg16 maybe artefacts due to less advanced prediction tools.
