# My Project

To measure codon usage.

The result of running codon-usage.py on subset.fa looks like: 
NP_001077862.1 {"type": "CDS", "gene": "DDTL", "product": "D-dopachrome decarboxylase-like protein", "locus": ""}
ATG
CCG
TTC
CTG
GAG
CTG
...
The output looks correct because the first codon for each contig is ATG, the start codon.

The result of running codon-usage.py (codons.py imported) on subset.fa looks like: 
{'M': 3, 'P': 13, 'F': 7, 'L': 17, 'E': 10, 'D': 5, 'T': 11, 'N': 5, 'A': 17, 'R': 9, 'V': 8, 'G': 12, 'K': 6, 'C': 4, 'S': 13, 'I': 7, 'Q': 3, 'H': 3, 'Y': 1, '*': 1}
The output looks correct because there is only one stop codon.

Cytoplasm: {'M': 988, 'P': 2762, 'F': 1610, 'L': 4769, 'E': 3544, 'D': 2252, 'T': 2633, 'N': 1704, 'A': 3183, 'R': 2622, 'V': 2525, 'G': 2663, 'K': 2570, 'C': 954, 'S': 3808, 'I': 1907, 'Q': 2166, 'H': 1273, 'Y': 1201, '*': 100, 'W': 535}
Membrane: {'M': 1010, 'A': 3364, 'E': 2953, 'S': 4272, 'R': 2511, 'G': 3143, 'L': 5044, 'Y': 1438, 'W': 595, 'C': 1031, 'F': 1961, 'V': 2921, 'I': 2365, 'K': 2207, 'P': 3053, 'T': 3468, 'H': 1224, 'Q': 1879, 'N': 1797, 'D': 2039, '*': 100}
There are variation in the abundance of some amino acids like Glu and Tyr. This is probably due to different chemical environments and different functional requirements.