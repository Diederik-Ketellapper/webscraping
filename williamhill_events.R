#### WEB SCRAPPING FUNCTION FOR WILLIAMHILL ####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)
library(assertthat)

## Build the function for William Hill, here we will webscrapp all the matches for the Ligue 1:

williamhill_events <- function(team){

#assert_that(is.character(team))

html<- read_html("http://sports.williamhill.es/bet_esp/es/betting/t/312/Francia+-+Ligue+1.html")

matches <- html %>% html_nodes('.rowOdd a span') %>% html_text()
odds <- html %>% html_nodes('.eventprice') %>% html_text() %>% as.numeric

## Now we create a dataframe with the needed data:
home <- sapply(strsplit(matches," "), `[`,1)
visitor <- sapply(strsplit(matches," "), tail,1)
oddh <- odds[seq(1,length(odds),3)]
oddd <- odds[seq(2,length(odds),3)]
oddv <- odds[seq(3,length(odds),3)]
website <- rep("william hill", each = length(match))

df_williamhill <- data.frame(match, home, visitor, oddh, oddd, oddv,website)
return(df)
}