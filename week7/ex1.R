library(tidyr)
library(dplyr)
library(matrixStats)

mt <- as.matrix(read.table("~/qb25-answers/week7/read_matrix.tsv"))
mt_var <- mt[order(rowSds(mt), decreasing = TRUE)[1:500],]
mt_norm <- mt_var %>% scale() %>% t()

pca_results = prcomp(mt_norm)
pca_data = tibble(PC1=pca_results$x[,1],
                 PC2=pca_results$x[,2],
                 Samples=rownames(mt_norm))
pca_data <- pca_data %>% tidyr::separate(Samples, into = c("Tissue", "Replicate"), sep = "_")
pca_data %>% ggplot(aes(PC1, PC2, color=Tissue, shape=Replicate)) +
  geom_point(size=3) +
  labs(
    title = "PCA of Top 500 Most Variant Genes",
    x = "Principal Component 1",
    y = "Principal Component 2",
   )

rownames(mt_norm)[12] <- "Fe_Rep1"
rownames(mt_norm)[13] <- "LFC.Fe_Rep3"

pca_summary = tibble(PC=seq(1,21,1),
                     sd=summary(pca_results)$sdev) %>%
  mutate(norm_var=sd^2/sum(sd^2))

pca_summary %>% ggplot(aes(x=PC, y=norm_var)) +
  geom_bar(stat = "identity") +
  labs(title = "Scree Plot",
       y="Variance explained") 

combined = mt_var[,seq(1, 21, 3)]
combined = combined + mt_var[,seq(2, 21, 3)]
combined = combined + mt_var[,seq(3, 21, 3)]
combined = combined / 3

row_sd_combined <- rowSds(combined)
filtered_combined <- combined[row_sd_combined > 1, ] %>% scale()

set.seed(42)
kmeans_combined = kmeans(filtered_combined, centers = 12, nstart = 100)
ordering = order(kmeans_combined$cluster)
heatmap(filtered_combined[ordering,], Rowv=NA, Colv=NA, RowSideColors=RColorBrewer::brewer.pal(12,"Paired")[kmeans_combined$cluster[ordering]], ylab="Gene",cexCol=0.75)

rownames(filtered_combined)[kmeans_combined$cluster == 11]
rownames(filtered_combined)[kmeans_combined$cluster == 1]
