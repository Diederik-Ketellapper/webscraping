#### WEB SCRAPPING FUNCTION FOR BETSTARS####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)
library(assertthat)

## Build the function for betstars:

betstars_events <- function(){
  
  options(stringsAsFactors = FALSE)
  require(rvest)
  
  ## change Phantom.js scrape file
  url <- "https://www.betstars.fr/?no_redirect=1#/soccer/competitions/2152298" %>% as.character()
  lines <- readLines("scrape_final.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape_final.js")
  
  ## Download website
  system("phantomjs scrape_final.js")
  
  ## Now we scrape matches and odds from the downloaded website:
  html <- read_html("1.html")
  matches <- html %>% html_nodes('.textLink span') %>% html_text()
  odds <- html %>% html_nodes('.selectionOdds') %>% html_text() %>% as.numeric
  
  ## We are getting the matches data with noise, we clean the strings:
  
  matches <- gsub("^(.*?),.*","\\1", matches) # Erase noise behind
  matches <- gsub("\n                ", "", matches, fixed = TRUE) # take out \n

  ## Now we create a dataframe with the needed data:
  home <- sapply(strsplit(matches," vs "), `[`,1)
  home <- home[!is.na(home)]
  visitor <- sapply(strsplit(matches," vs "), tail,1)
  visitor <- visitor[seq(1,length(visitor), by = 2)] %>% as.character
  oddh <- odds[seq(1,length(odds),3)]
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("betstars", each = length(match))
  
  df <- data.frame(home, visitor, oddh, oddd, oddv,website)
  
  return(df)
}