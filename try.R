library(tidyverse)
library(jsonlite)
library(rvest)
library(glue)
library(httr)
library(dplyr)

team <- "ajax"
unibet_url <- glue("https://www.unibet.co.uk/betting#filter/football/all/all/{team}") %>% as.character()
html <- read_html(unibet_url)
events <- html %>% 
  html_nodes('.KambiBC-event-participants__name') %>% 
  html_text()