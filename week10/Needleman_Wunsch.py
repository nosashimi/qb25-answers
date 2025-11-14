#!/usr/bin/env python3

import sys
import numpy as np
from fasta import readFASTA


#====================#
# Read in parameters #
#====================#
gap_penalty = int(sys.argv[3])

# The scoring matrix is assumed to be named "sigma_file" and the 
# output filename is assumed to be named "out_file" in later code

# Read the scoring matrix into a dictionary
fs = open(sys.argv[2])
sigma = {}
alphabet = fs.readline().strip().split()
for line in fs:
	line = line.rstrip().split()
	for i in range(1, len(line)):
		sigma[(alphabet[i - 1], line[0])] = float(line[i])
fs.close()

# Read in the actual sequences using readFASTA
input_sequences = readFASTA(open(sys.argv[1]))

seq1_id, sequence1 = input_sequences[0]
seq2_id, sequence2 = input_sequences[1]

#=====================#
# Initialize F matrix #
#=====================#
f_matrix = np.zeros((len(sequence1) + 1, len(sequence2) + 1), dtype = int)

#=============================#
# Initialize Traceback Matrix #
#=============================#
t_matrix = np.zeros((len(sequence1) + 1, len(sequence2) + 1), dtype = int)

#===================#
# Populate Matrices #
#===================#
for j in range(1, len(sequence2) + 1):
    f_matrix[0, j] = f_matrix[0, j - 1] + gap_penalty
for i in range(1, len(sequence1) + 1):
    f_matrix[i, 0] = f_matrix[i - 1, 0] + gap_penalty
for i in range(1, len(sequence1) + 1):
	for j in range(1, len(sequence2) + 1):
		h_score = f_matrix[i, j - 1] + gap_penalty
		v_score = f_matrix[i - 1, j] + gap_penalty
		f_matrix[i, j] = max(h_score, v_score, f_matrix[i - 1, j - 1] + sigma[sequence1[i - 1], sequence2[j - 1]])
		if f_matrix[i, j] == f_matrix[i - 1, j - 1] + sigma[sequence1[i - 1], sequence2[j - 1]]:
			t_matrix[i, j] = 1
		elif f_matrix[i, j] == h_score:
			t_matrix[i, j] = 2
		else:
			t_matrix[i, j] = 3

#========================================#
# Follow traceback to generate alignment #
#========================================#
sequence1_alignment = ""
sequence2_alignment = ""
i = len(sequence1)
j = len(sequence2)
while i > 0 or j > 0:
	if t_matrix[i, j] == 1:
		sequence1_alignment = sequence1[i - 1] + sequence1_alignment
		sequence2_alignment = sequence2[j - 1] + sequence2_alignment
		i -= 1
		j -= 1
	elif t_matrix[i, j] == 2:
		sequence1_alignment = "-" + sequence1_alignment
		sequence2_alignment = sequence2[j - 1] + sequence2_alignment
		j -= 1
	else:
		sequence1_alignment = sequence1[i - 1] + sequence1_alignment
		sequence2_alignment = "-" + sequence2_alignment
		i -= 1

# The aligned sequences are assumed to be strings named sequence1_aligment
# and sequence2_alignment in later code


#=================================#
# Generate the identity alignment #
#=================================#

# This is just the bit between the two aligned sequences that
# denotes whether the two sequences have perfect identity
# at each position (a | symbol) or not.

identity_alignment = ''
for i in range(len(sequence1_alignment)):
	if sequence1_alignment[i] == sequence2_alignment[i]:
		identity_alignment += '|'
	else:
		identity_alignment += ' '


#===========================#
# Write alignment to output #
#===========================#

# Certainly not necessary, but this writes 100 positions at
# a time to the output, rather than all of it at once.

output = open(sys.argv[4], "w")
info = open(sys.argv[5], "a")

for i in range(0, len(identity_alignment), 100):
	output.write(sequence1_alignment[i:i+100] + '\n')
	output.write(identity_alignment[i:i+100] + '\n')
	output.write(sequence2_alignment[i:i+100] + '\n\n\n')


#=============================#
# Calculate sequence identity #
#=============================#
info.write(f"{sys.argv[6]} alignment\n")
info.write(f"Number of gaps in Sequence 1: {sequence1_alignment.count("-")}\n")
info.write(f"Number of gaps in Sequence 2: {sequence2_alignment.count("-")}\n")
info.write(f"Sequence 1 percent identity: {identity_alignment.count('|') / len(sequence1) * 100}%\n")
info.write(f"Sequence 2 percent identity: {identity_alignment.count('|') / len(sequence2) * 100}%\n")
info.write(f"Alignment score: {f_matrix[len(sequence1), len(sequence2)]}\n\n\n")

#======================#
# Print alignment info #
#======================#

# You need the number of gaps in each sequence, the sequence identity in
# each sequence, and the total alignment score
