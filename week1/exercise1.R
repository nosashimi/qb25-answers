library(tidyverse)

header <- c( "chr", "start", "end", "count" )
         
df_kc <- read_tsv( "~/qb25-answers/week1/hg19-kc-count.bed", col_names=header )

e1 <- ggplot(df_kc, aes( x = start, y = count)) +
            geom_point(size = 0.5) +
           geom_line() +
         scale_y_log10() +
         facet_wrap(~ chr, scales = "free") +
         labs(
           x = "start",
           y = "count"
         )

ggsave( "~/qb25-answers/week1/exercise1.png", plot = e1)
