#!/usr/bin/env python3

import numpy as np
import random

# 3x coverage
g_size = 1000000
num_reads_3x = 30000
genome_coverage = np.zeros(g_size, dtype = int)
f = open("3x_coverage.txt", "a")

for i in range(num_reads_3x):
    start_pos = random.randrange(0, g_size - 100 + 1)
    end_pos = start_pos + 100
    genome_coverage[start_pos:end_pos] += 1

for i in range(len(genome_coverage)):
    f.write(str(genome_coverage[i]) + "\n")

# 10x coverage
num_reads_10x = 100000
genome_coverage = np.zeros(g_size, dtype = int)
f = open("10x_coverage.txt", "a")

for i in range(num_reads_10x):
    start_pos = random.randrange(0, g_size - 100 + 1)
    end_pos = start_pos + 100
    genome_coverage[start_pos:end_pos] += 1

for i in range(len(genome_coverage)):
    f.write(str(genome_coverage[i]) + "\n")

# 30x coverage
num_reads_30x = 300000
genome_coverage = np.zeros(g_size, dtype = int)
f = open("30x_coverage.txt", "a")

for i in range(num_reads_30x):
    start_pos = random.randrange(0, g_size - 100 + 1)
    end_pos = start_pos + 100
    genome_coverage[start_pos:end_pos] += 1

for i in range(len(genome_coverage)):
    f.write(str(genome_coverage[i]) + "\n")

# De Bruijn
reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']
f = open("edges.dot", "a")
f.write("digraph {\n")

graph = dict()

for read in reads:
    for i in range(len(read) - 3):
        kmer1 = read[i: i + 3]
        kmer2 = read[i + 1: i + 4]
        if not kmer1 in graph:
            graph[kmer1] = kmer2

for keys in graph:
    f.write(keys + " -> " + graph[keys] + ";\n")

f.write("}\n")
