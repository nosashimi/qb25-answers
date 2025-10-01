library(tidyverse)

df <- read_delim("~/qb25-answers/week3/BYxRM_bam/gt_long.txt", delim = "\t") 

# chrII of sample A01_62
df %>%
  filter(Sample_ID == "A01_62" & Chromosome == "chrII") -> df622

gen_622 <- factor(df622$Genotype)

ggplot(df622, aes(x = Position, y = 0, color = gen_622)) +
  geom_point() +
  scale_color_brewer(palette = "Set2", name = "Genotype") +
  labs(x = "chrII Position",
       y = "") +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        panel.grid = element_blank())
# Q. 3.2
# There are large blocks of same color, indicating regions of the chromosome 
# inherited from one parent. Transitions mark the breakpoints of recombination.

# Extension to all chr of sample A01_62
df %>%
  filter(Sample_ID == "A01_62") -> df62

gen_62 <- factor(df62$Genotype)

ggplot(df62, aes(x = Position, y = 0, color = gen_62)) +
  geom_point() +
  scale_color_brewer(palette = "Set2", name = "Genotype") +
  labs(x = "chr Position",
       y = "") +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        panel.grid = element_blank()) +
facet_grid(Chromosome ~ ., scales = "free_x", space = "free_x")

# Extension to all samples
gen_all <- factor(df$Genotype)

ggplot(df, aes(x = Position, y = 0, color = gen_all)) +
  geom_point() +
  scale_color_brewer(palette = "Set2", name = "Genotype") +
  labs(x = "chr Position",
       y = "") +
  theme_minimal() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        panel.grid = element_blank()) +
  facet_grid(Chromosome ~ Sample_ID, scales = "free_x", space = "free_x")
