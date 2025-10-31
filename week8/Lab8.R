library(tidyverse)
library(broom)
library(DESeq2)

# Exercise 1
# Step 1.1
counts_df <- read_delim("./gtex_whole_blood_counts_downsample.txt") %>% as_tibble()
metadata_df <- read_delim("./gtex_metadata_downsample.txt") %>% as_tibble()
counts_df <- column_to_rownames(counts_df, var = "GENE_NAME")
metadata_df <- column_to_rownames(metadata_df, var = "SUBJECT_ID")

# Step 1.2
table(colnames(counts_df) == rownames(metadata_df))
dds <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = metadata_df,
                              design = ~ SEX + AGE + DTHHRDY)

# Step 1.3
vsd <- vst(dds)
plotPCA(vsd, intgroup = "SEX") +
  labs(title = "PCA based on sex")
plotPCA(vsd, intgroup = "AGE") +
  labs(title = "PCA based on age")
plotPCA(vsd, intgroup = "DTHHRDY") +
  labs(title = "PCA based on death circumstances")
# 48% and 7% of variance is explained by the first two PCs. PC1 seems to be associated with death circumstances,
# while PC2 seems to be weakly associated with sex. So death circumstances seem to be associated with differential
# expression while other factors seem to be less correlated.

# Exercise 2
# Step 2.1
vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()
vsd_df <- bind_cols(metadata_df, vsd_df)
m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
# WASH7P does not have a significant sex-differential expression given its ~0.28 p-value.
m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
# SLC25A47 has a significant sex-differential expression (p-value = ~0.025), with males having 0.51832893 more counts
# than females on average.

# Step 2.2
dds <- DESeq(dds)

# Step 2.3
res <- results(dds, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")
filtered_res <- res %>%
  filter(padj < 0.1)
# 262 genes exhibit significant differential expression between males and females at a 10% FDR.
location_df <- read_delim("./gene_locations.txt") %>% as_tibble()
ordered_res <- filtered_res %>% left_join(location_df, by = "GENE_NAME") %>% arrange(padj)
# The Y chromosome contains most up-regulated genes in males, whereas the X chromosome contains that in females.
# There are more male up-regulated genes than female ones. 

# WASH7P is no longer in the filtered list, which is consistent with the linear regression model showing a insignificant
# sex-differential expression. On the other hand, SLC25A47 is still present with a Q-value of 8.322385e-07, indicating a
# significant sex-differential expression similar to the linear regression model.

# By decreasing the FDR threshold we would get less hits and a decreased false positive probability, but also increases
# the probability of false negative errors since we might miss some truly differentially expressed genes. Small sample 
# sizes or small effect sizes reduce the analysis power, since chance plays a bigger role for small sample sizes and small
# effec sizes make detecting differences in gene expression harder.

# Step 2.4
new_res <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes")  %>%
  as_tibble(rownames = "GENE_NAME")
filtered_new_res <- new_res %>%
  filter(padj < 0.1)
# 16069 genes are differentially expressed according to death classification at a 10% FDR.

# Step 2.5
metadata_df$SEX <- sample(metadata_df$SEX, replace = FALSE)
dds_rd <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = metadata_df,
                              design = ~ SEX + AGE + DTHHRDY)
dds_rd <- DESeq(dds_rd)
res_rd <- results(dds_rd, name = "SEX_male_vs_female")  %>%
  as_tibble(rownames = "GENE_NAME")
filtered_res_rd <- res_rd %>%
  filter(padj < 0.1)
# 46 genes are still "significant". Compared to the 262 genes from the real analysis, the false positive rate indicates an adequate
# ability of the FDR threshold since it keeps the false discovery rate near the expected threshold.

# Exercise 3
res_clean <- res %>%
  na.omit() %>%
  mutate(significant = ifelse(padj < 0.1 & abs(log2FoldChange) > 1, "Significant", "Not Significant"))
ggplot(data = res_clean, aes(x = log2FoldChange, y = -log10(pvalue), color = significant)) +
  geom_point() +
  scale_color_manual(values = c("grey", "red"),
                     labels = c("Not Significant", "Significant")) +
  labs(title = "Volcano plot for sex-differential expression", x = "log2FoldChange (Male vs Female)", color = "Significance")
