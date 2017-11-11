options(stringsAsFactors = FALSE)
library(tidyverse)
wd<- getwd()
ligue1<- read.csv(glue("{wd}/overview/ligue1_teams.csv")) %>%  as.matrix
