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
  unibet_url <- glue("https://www.unibet.co.uk/betting#filter/football/all/all/{team}") %>% as.character(unibet_url)
  read_html(unibet_url)
  events <- unibet_url %>% 
    html_nodes('.KambiBC-event-groups-list') %>% 
    html_text()
  
  return(unibet_url)
}
