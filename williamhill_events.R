#### WEB SCRAPPING FUNCTION FOR WILLIAMHILL ####

# Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)

## Build the function for William Hill, here we will webscrapp all the matches for the next journée ofor the Ligue 1:

williamhill_events <- function(){

html<- read_html("http://sports.williamhill.com/bet/fr-fr/betting/t/312/France+-+Ligue+1.html")

matches <- html %>% html_nodes('.rowOdd a span') %>% html_text() #Get the matches
odds <- html %>% html_nodes('.eventprice') %>% html_text() %>% as.numeric #Get the odds

## Now we create a dataframe tidying up the webscrapped data:
home <- sapply(strsplit(matches," "), `[`,1) #First team for each event string in matches is home team, second one visitor team.
visitor <- sapply(strsplit(matches," "), tail,1) %>% gsub(pattern = "[[:space:]]",replacement = "") #We take out the whitespaces we get in the webscrape
oddh <- odds[seq(1,length(odds),3)]  #For odds we webscrapped all in a single vector, corresponding by pairs of 3 to 1 X 2 posible outcomes of the event, we tidy them up in 3 columns for home, draw, visitor
oddd <- odds[seq(2,length(odds),3)]
oddv <- odds[seq(3,length(odds),3)]
website <- rep("williamhill", each = length(matches)) # Set from which website comes the info from for later sorting purposes.

df <- data.frame(home, visitor, oddh, oddd, oddv,website) # Generate the df.
return(df)
}