#### WEB SCRAPPING FUNCTION FOR BWIN ####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)

## Build the function for William Hill, here we will webscrapp all the matches for the Ligue 1:

bwin_events <- function(){
  
  html<- read_html("https://sports.bwin.fr/fr/sports/search?query=Ligue%201")
  
  matches <- html %>% html_nodes('.mb-option-button--3-way .mb-option-button__option-name') %>% html_text() # Get the matches
  odds <- html %>% html_nodes('.marketboard-options-row--3-way .mb-option-button__option-odds') %>% html_text() %>% as.numeric # Get the odds
  
  ## Now we create a dataframe with the needed data:
  home <- matches[seq(1,length(matches), by = 2)] #First team for each event string in matches is home team, second one visitor team.
  visitor <- matches[seq(2,length(matches), 2)]
  oddh <- odds[seq(1,length(odds),3)] #For odds we webscrapped all in a single vector, corresponding by pairs of 3 to 1 X 2 posible outcomes of the event, we tidy them up in 3 columns for home, draw, visitor
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("bwin", each = length(matches)) # Set from which website comes the info from for later sorting purposes.
  
  df <- data.frame(home, visitor, oddh, oddd, oddv,website)
  ## Here we trim the data set to the first 10 rows, because after those we are webscrapping future journees and other competitions events and since here are focusing on only Ligue 1 events for next journée we will disregard them:
  df <- df[c(1:10),]
  
  return(df)
}