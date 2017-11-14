#### WEB SCRAPPING FUNCTION FOR UNIBET####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)

# Here we are going to use the javascript scrape_final.js to load the website with the headless browser phantomejs, which will use a delay of 5 seconds before gathering the website to get the info despite the dynamic rendering used.
# We have done it following this tutorial: https://www.r-bloggers.com/web-scraping-javascript-rendered-sites/
# It's important to note that it only works on Windows!! Since only the windows file for running phantomejs is included in this folder project. To make it work in iOS or Linux then the respective phantomjs executable file should be downloaded from the internet and copied in the environment.

## Build the function for Unibet:

unibet_events <- function(){

  options(stringsAsFactors = FALSE)
  require(rvest)
  
  ## Change the target website in the Phantom.js scrape file
  url <- "https://www.unibet.fr/sport/football/ligue-1" %>% as.character()
  lines <- readLines("scrape_final.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape_final.js")
  
  ## Download website using the headless browser PhantomJS:
  system("phantomjs scrape_final.js")
  
  ## Now we scrape matches and odds from the downloaded website:
  html <- read_html("1.html") # The scrapped website is stored under 1.html by the scrape_final.js java function
  matches <- html %>% html_nodes('.cell-event a') %>% html_text() # Get the matches
  odds <- html %>% html_nodes('.odd-price') %>% html_text() # Get the odds
  
  ## Now we create a dataframe with the needed data:
  home <- sapply(strsplit(matches," - "), `[`,1) #First team for each event string in matches is home team, second one visitor team.
  visitor <- sapply(strsplit(matches," - "), tail,1)
  oddh <- odds[seq(1,length(odds),3)] #For odds we webscrapped all in a single vector, corresponding by pairs of 3 to 1 X 2 posible outcomes of the event, we tidy them up in 3 columns for home, draw, visitor
  oddd <- odds[seq(2,length(odds),3)]
  oddv <- odds[seq(3,length(odds),3)]
  website <- rep("unibet", each = length(match)) # Set from which website comes the info from for later sorting purposes.
  
  df <- data.frame(home, visitor, oddh, oddd, oddv,website)
  ## Here we trim the data set to the first 10 rows, the next 10 scrapped are for the next journee:
  df <- df[c(1:10),]
  
  return(df)
}