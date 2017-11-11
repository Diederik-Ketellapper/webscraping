#### WEB SCRAPPING FUNCTION FOR BWIN ####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(glue)
library(httr)
library(dplyr)
library(assertthat)

## Build the function for Unibet:
team <- "real%20madrid"
#bwin_events <- function(team){
  
  #assert_that(is.character(team))
  
  options(stringsAsFactors = FALSE)
  require(rvest)
  
  ## change Phantom.js scrape file
  url <- glue("https://sports.bwin.com/es/sports/search?query={team}") %>% as.character()
  lines <- readLines("scrape_final.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape_final.js")
  
  ## Download website
  system("phantomjs scrape_final.js")
  
  ## Now we scrape matches and odds from the downloaded website:
  html <- read_html("1.html")
  matches <- html %>% html_nodes(".mb-option-button--3-way .mb-option-button__option-name--odds-4 , .mb-option-button--3-way .highlight , .mb-option-button--3-way .mb-option-button__option-name--odds-5") %>% html_text()
  odds <- html %>% html_nodes(".marketboard-options-row--3-way .mb-option-button__option-odds") %>% html_text()
  
  ## Now we create a dataframe with the needed data:
  match <- 1:1:(length(matches)/2)
  home <- matches[seq(1,length(matches), by = 2)]
  visitor <- matches[seq(2,length(matches), 2)]
  oddh <- odds[seq(1,length(odds),3)]
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("bwin", each = length(match))
  
  df <- data.frame(match, home, visitor, oddh, oddd, oddv,website)
  
  return(df)
#}
