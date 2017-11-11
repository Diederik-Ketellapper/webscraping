#### WEB SCRAPPING FUNCTION FOR BETSTARS ####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)
library(assertthat)

## Build the function for William Hill, here we will webscrapp all the matches for the Ligue 1:

#betstars_events <- function(){
  
  html<- read_html("https://www.betstars.fr/?no_redirect=1#/soccer/competitions/2152298")
  
  matches <- html %>% html_nodes('.textLink span') %>% html_text()
  odds <- html %>% html_nodes('.selectionOdds') %>% html_text() %>% as.numeric
  
  ## Now we create a dataframe with the needed data:
  home <- matches[seq(1,length(matches), by = 2)]
  visitor <- matches[seq(2,length(matches), 2)]
  oddh <- odds[seq(1,length(odds),3)]
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("bwin", each = length(matches))
  
  df <- data.frame(home, visitor, oddh, oddd, oddv,website)
  return(df)
#}
