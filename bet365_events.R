#### WEB SCRAPPING FUNCTION FOR BET365 ####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)
library(assertthat)

## Build the function for William Hill, here we will webscrapp all the matches for the Ligue 1:

#bet365_events <- function(team){
  
  #assert_that(is.character(team))

  options(stringsAsFactors = FALSE)
  require(rvest)

  ## change Phantom.js scrape file
  url <- "https://www.bet365.es/#/AC/B1/C1/D13/E33754893/F2/R1/"
  lines <- readLines("scrape_final.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape_final.js")

  ## Download website
  system("phantomjs scrape_final.js")

  ## Now we scrape matches and odds from the downloaded website:
  html <- read_html("1.html")
  matches <- html %>% html_nodes('.sl-CouponParticipantWithBookCloses_Name') %>% html_text()
  odds <- html %>% html_nodes('.gl-ParticipantOddsOnly_Odds') %>% html_text() %>% as.numeric
  
  ## Now we create a dataframe with the needed data:
  home <- sapply(strsplit(matches," "), `[`,1)
  visitor <- sapply(strsplit(matches," "), tail,1)
  oddh <- odds[seq(1,length(odds),3)]
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("william hill", each = length(matches))
  
  df <- data.frame(home, visitor, oddh, oddd, oddv,website)
  return(df)
#}
