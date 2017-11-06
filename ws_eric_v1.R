#### SEARCH BAR AND WEB SCRAPPING FUNCTION ####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(glue)
library(httr)
library(dplyr)

# Build the function for Unibet:

my_team_events <- function(team){
  unibet_url <- glue("https://www.unibet.co.uk/betting#filter/football/all/all/{team}") %>% as.character()
  html <- read_html(unibet_url)
  events <- html %>% 
    html_nodes('.KambiBC-event-participants__name') %>% 
    html_text()
  
  return(unibet_url)
}
