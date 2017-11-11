#### WEB SCRAPPING THE DIFFERENT WEBSITES ####

# When we first tried to webscrapp the betting websites we struggled because they are using a delayed Java-Script-based rendering.
# To deal with this we have used a headless browser called PhantomJS and a java script to load the website using the headless browser, and then we use rvest to gather the data.
# We have done it following this tutorial: https://www.r-bloggers.com/web-scraping-javascript-rendered-sites/

## Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(rvest)
library(httr)
library(dplyr)
library(assertthat)

## We define the function to gather all the data from the different websites:

#all_team_events <- function(team){
  
  #assertthat this has to be a character
  
  ## Now we are going to use the functions created separately to gather the data from each one:
  
  df_williamhill <- williamhill_events()
  df_bwin <- bwin_events()
  df_unibet <- unibet_events()
  df_betstars <- betstars_events()
  
  ## We bind all the dataframes in a unique one:
  
  df <- rbind(df_williamhill,df_bwin,df_unibet,df_betstars)
  
  
#}
