library(tidyverse)

coverage <- read.table("~/qb25-answers/week11/3x_coverage.txt")
xs = 0:max(coverage$V1)
poisson_estimate <- dpois(xs, 3) * 1000000
normal_estimate <- dnorm(xs, mean = 3, sd = 1.73) * 1000000
tx_df <- data.frame(
  x = xs,
  poisson = poisson_estimate,
  norm = normal_estimate)
ggplot(coverage,aes(x=V1))+
  geom_histogram(bins = 13)+
  geom_line(data=tx_df,aes(x=x, y=poisson), color = "red")+
  geom_line(data=tx_df,aes(x=x, y=norm), color = "blue")+
  labs(title = "Simulated 3x coverage (grey) overlaid with Poisson distribution (red) and Normal distribtuion (blue)", x = "Read counts", y = "Counts")

coverage <- read.table("~/qb25-answers/week11/10x_coverage.txt")
xs = 0:max(coverage$V1)
poisson_estimate <- dpois(xs, 10) * 1000000
normal_estimate <- dnorm(xs, mean = 10, sd = 3.16) * 1000000
tx_df <- data.frame(
  x = xs,
  poisson = poisson_estimate,
  norm = normal_estimate)
ggplot(coverage,aes(x=V1))+
  geom_histogram(bins = 27)+
  geom_line(data=tx_df,aes(x=x, y=poisson), color = "red")+
  geom_line(data=tx_df,aes(x=x, y=norm), color = "blue")+
  labs(title = "Simulated 10x coverage (grey) overlaid with Poisson distribution (red) and Normal distribtuion (blue)", x = "Read counts", y = "Counts")

coverage <- read.table("~/qb25-answers/week11/30x_coverage.txt")
xs = 0:max(coverage$V1)
poisson_estimate <- dpois(xs, 30) * 1000000
normal_estimate <- dnorm(xs, mean = 30, sd = 5.47) * 1000000
tx_df <- data.frame(
  x = xs,
  poisson = poisson_estimate,
  norm = normal_estimate)
ggplot(coverage,aes(x=V1))+
  geom_histogram(bins = 61)+
  geom_line(data=tx_df,aes(x=x, y=poisson), color = "red")+
  geom_line(data=tx_df,aes(x=x, y=norm), color = "blue")+
  labs(title = "Simulated 30x coverage (grey) overlaid with Poisson distribution (red) and Normal distribtuion (blue)", x = "Read counts", y = "Counts")
