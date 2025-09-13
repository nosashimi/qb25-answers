library(tidyverse)

header <- c( "chr", "start", "end", "count" )

dfA <- read_tsv( "~/qb25-answers/week1/hg19-kc-count.bed", col_names=header )
dfB <- read_tsv( "~/qb25-answers/week1/hg16-kc-count.bed", col_names=header )

dfcom <- bind_rows( hg19=dfA, hg16=dfB, .id="assembly" )

e1 <- ggplot(dfcom, aes( x = start, y = count, color = assembly)) +
  geom_point(size = 0.5) +
  geom_line() +
  scale_y_log10() +
  facet_wrap(~ chr, scales = "free") +
  labs(
    x = "start",
    y = "count"
  )

ggsave( "~/qb25-answers/week1/exercise1.png", plot = e1)