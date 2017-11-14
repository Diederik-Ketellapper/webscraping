#### WEB SCRAPPING FUNCTION FOR BETSTARS####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)

# Here we are going to use the javascript scrape_final.js to load the website with the headless browser phantomejs, which will use a delay of 5 seconds before gathering the website to get the info despite the dynamic rendering used.
# We have done it following this tutorial: https://www.r-bloggers.com/web-scraping-javascript-rendered-sites/
# It's important to note that it only works on Windows!! Since only the windows file for running phantomejs is included in this folder project. To make it work in iOS or Linux then the respective phantomjs executable file should be downloaded from the internet and copied in the environment.

## Build the function for betstars:

betstars_events <- function(){
  
  options(stringsAsFactors = FALSE)
  require(rvest)
  
  ## Change the target website in the Phantom.js scrape file
  url <- "https://www.betstars.fr/?no_redirect=1#/soccer/competitions/2152298" %>% as.character()
  lines <- readLines("scrape_final.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape_final.js")
  
  ## Download website using the headless browser PhantomJS:
  system("phantomjs scrape_final.js")
  
  ## Now we scrape matches and odds from the downloaded website:
  html <- read_html("1.html") # The scrapped website is stored under 1.html by the scrape_final.js java function
  matches <- html %>% html_nodes('.textLink span') %>% html_text() # Get the matches
  odds <- html %>% html_nodes('.selectionOdds') %>% html_text() %>% as.numeric # Get the odds
  
  # We are getting the matches data with noise, we clean the strings:
  
  matches <- gsub("^(.*?),.*","\\1", matches) # Erase noise behind
  matches <- gsub("\n                ", "", matches, fixed = TRUE) # take out \n and spaces in front

  ## Now we create a dataframe with the needed data:
  home <- sapply(strsplit(matches," vs "), `[`,1) # Take first team from event as home team and clean it.
  home <- home[!is.na(home)]
  visitor <- sapply(strsplit(matches," vs "), tail,1) # Take first team from event as home team and clean it.
  visitor <- visitor[seq(1,length(visitor), by = 2)] %>% as.character
  oddh <- odds[seq(1,length(odds),3)] #For odds we webscrapped all in a single vector, corresponding by pairs of 3 to 1 X 2 posible outcomes of the event, we tidy them up in 3 columns for home, draw, visitor
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("betstars", each = length(match)) # Set from which website comes the info from for later sorting purposes.
  
  df <- data.frame(home, visitor, oddh, oddd, oddv,website)
  
  return(df)
}