#### WEB SCRAPPING FUNCTION FOR UNIBET####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(glue)
library(httr)
library(dplyr)
library(assertthat)

# When we first tried to webscrapp the betting websites we struggled because they are using a delayed Java-Script-based rendering.
# To deal with this we have used a headless browser called PhantomJS and a java script to load the website using the headless browser, and then we use rvest to gather the data.
# We have done it following this tutorial: https://www.r-bloggers.com/web-scraping-javascript-rendered-sites/

## Build the function for Unibet:

unibet_events <- function(team){
  
  options(stringsAsFactors = FALSE)
  require(rvest)
  
  ## change Phantom.js scrape file
  url <- glue("https://www.unibet.co.uk/betting#filter/football/all/all/{team}") %>% as.character()
  lines <- readLines("scrape_final.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape_final.js")
  
  ## Download website
  system("phantomjs scrape_final.js")
  
  ## Now we scrape matches and odds from the downloaded website:
  html <- read_html("1.html")
  matches <- html %>% html_nodes(".KambiBC-event-participants__name") %>% html_text()
  odds <- html %>% html_nodes(".KambiBC-bet-offer--outcomes-3 .KambiBC-mod-outcome__odds") %>% html_text()
  
  ## Now we create a dataframe with the needed data:
  match <- 1:1:(length(matches)/2)
  home <- matches[seq(1,length(matches), by = 2)]
  visitor <- matches[seq(2,length(matches), 2)]
  oddh <- odds[seq(1,length(odds),3)]
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  
  df <- data.frame(match, home, visitor, oddh, oddd, oddv)
  
  return(df)
}
