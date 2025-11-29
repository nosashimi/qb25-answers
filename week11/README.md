Question 1.1: 1000000 * 3 / 100 = 30000.  
Question 1.4: Use the unix command sort 3x_coverage.txt | uniq -c. 49806 bps have 0x coverage. Overall, the distribution matches the Poisson distribution better than the normal distribution.  
Question 1.5: Use the unix command sort 10x_coverage.txt | uniq -c. Only 32 bps have 0x coverage. Again, the overall distribution matches the Poisson distribution better than the normal distribution.  
Question 1.6: Use the unix command sort 30x_coverage.txt | uniq -c. Only 5 bps have 0x coverage. The distribution matches the Poisson and the normal distribution almost equally well, although Poisson is slightly better.  
Question 2.4: dot -Tpng edges.dot -o ex2_digraph.png  
Question 2.5: TCTTATTCTTATTAATTTTGATTGATTTG.  
Question 2.6: Accurate reconstruction requires sufficient read length and high coverage to resolve repeats in the de Bruijn graph. In practice, low sequencing error rates are also important to ensure the validity of each reads.