library(tidyverse)

df <- read.table("~/qb25-answers/week3/BYxRM_bam/AF.txt") 

ggplot(df, aes(x = V1)) +
  geom_histogram(bins = 11, position = "dodge") +
  labs(
    x = "Allele Frequency",
    y = "Counts"
  )

# This is roughly the shape of a binomial distribution, which is expected since each variant 
# is either from the lab strain or the wine strain, with a 50% chance to be either one 
# during sporulation. Therefore, for enough variants, the allele frequency should scatter
# around 0.5.

df2 <- read.table("~/qb25-answers/week3/BYxRM_bam/DP.txt") 

ggplot(df2, aes(x = V1)) +
  geom_histogram(bins = 21, position = "dodge") +
  labs(
    x = "Read Depth",
    y = "Counts"
  ) +
  xlim(0,20)

# It is a right skewed distribution with most read depths around 5, which is somewhat surprising
# since normal Illumina read depths are >15X.