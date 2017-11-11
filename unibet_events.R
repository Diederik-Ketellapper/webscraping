#### WEB SCRAPPING FUNCTION FOR UNIBET####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)
library(assertthat)

## Build the function for Unibet:

unibet_events <- function(){

  options(stringsAsFactors = FALSE)
  require(rvest)
  
  ## change Phantom.js scrape file
  url <- "https://www.unibet.co.uk/betting#filter/football/france/ligue_1" %>% as.character()
  lines <- readLines("scrape_final.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape_final.js")
  
  ## Download website
  system("phantomjs scrape_final.js")
  
  ## Now we scrape matches and odds from the downloaded website:
  html <- read_html("1.html")
  matches <- html %>% html_nodes('.KambiBC-event-participants__name') %>% html_text()
  odds <- html %>% html_nodes('.KambiBC-bet-offer--outcomes-3 .KambiBC-mod-outcome__odds') %>% html_text() #%>% as.numeric
  
  ## We got the odds scrapped in fractional format from this website, we change it to decimal:
  
  odds <- sapply(odds, function(x) round(eval(parse(text = x))+1, digits = 2))
  
  ## Now we create a dataframe with the needed data:
  home <- matches[seq(1,length(matches), by = 2)]
  visitor <- matches[seq(2,length(matches), 2)]
  oddh <- odds[seq(1,length(odds),3)]
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("unibet", each = length(match))
  
  df <- data.frame(home, visitor, oddh, oddd, oddv,website)
  
  return(df)
}