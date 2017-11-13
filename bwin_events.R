#### WEB SCRAPPING FUNCTION FOR BWIN ####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)
library(assertthat)

## Build the function for William Hill, here we will webscrapp all the matches for the Ligue 1:

bwin_events <- function(){
  
  html<- read_html("https://sports.bwin.fr/fr/sports/search?query=Ligue%201")
  
  matches <- html %>% html_nodes('.mb-option-button--3-way .mb-option-button__option-name') %>% html_text()
  odds <- html %>% html_nodes('.marketboard-options-row--3-way .mb-option-button__option-odds') %>% html_text() %>% as.numeric
  
  ## Now we create a dataframe with the needed data:
  home <- matches[seq(1,length(matches), by = 2)]
  visitor <- matches[seq(2,length(matches), 2)]
  oddh <- odds[seq(1,length(odds),3)]
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("bwin", each = length(matches))
  
  df <- data.frame(home, visitor, oddh, oddd, oddv,website)
  return(df)
}