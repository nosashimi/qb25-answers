library(tidyverse)
library(broom)

dnm <- read.csv("~/qb25-answers/week5/aau1043_dnm.csv") %>% as_tibble()
pc_count <- dnm %>% group_by(Proband_id, Phase_combined) %>% summarize(n = n()) %>% filter(Phase_combined != "") %>% pivot_wider(names_from = Phase_combined, values_from = n)

prt <- read.csv("~/qb25-answers/week5/aau1043_parental_age.csv") %>% as_tibble()

dnm_joined <- pc_count %>% left_join(prt, by = "Proband_id")

ggplot(dnm_joined, aes(x = Mother_age, y = mother)) + 
  geom_point() +
  labs(
    x = "Maternal Age",
    y = "Maternal DNMs",
  )

ggplot(dnm_joined, aes(x = Father_age, y = father)) + 
  geom_point() +
  labs(
    x = "Paternal Age",
    y = "Paternal DNMs",
  )

lm(data = dnm_joined, 
   formula = mother ~ Mother_age) %>%
  summary()

lm(data = dnm_joined, 
   formula = father ~ Father_age) %>%
  summary()

df_long <- data.frame(
  DNM = c(dnm_joined$father, dnm_joined$mother),
  Age = c(dnm_joined$Father_age, dnm_joined$Mother_age),
  Parent = factor(c(rep("Father", nrow(dnm_joined)), rep("Mother", nrow(dnm_joined))))
)

ggplot(df_long, aes(x = DNM, fill = Parent)) +
  geom_density(alpha = 0.5) +
  labs(x = "# of DNMs",
       y = "Density",
       fill = "Parent") +
  theme_minimal()

t.test(dnm_joined$mother, dnm_joined$father, paired = TRUE)

lm(father - mother ~ 1, data = dnm_joined)%>%
  summary()

exped_tidy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-21/exped_tidy.csv')
peaks_tidy <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-01-21/peaks_tidy.csv')

ggplot(peaks_tidy,aes(x = PYEAR)) +
  geom_density() +
  labs(x = "Year",
       y = "Density")

att_dis <- peaks_tidy %>% group_by(PYEAR) %>% summarize(n=n())
att_clean <- na.omit(att_dis)
lm(n ~ PYEAR, data = att_clean)%>%
  summary()
