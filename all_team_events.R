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

## We define the function to gather all the data from the different websites:

#all_team_events <- function(team){
  
  #assertthat this has to be a character
  
  ## Now we are going to use the functions created separately to gather the data from each one:
  "williamhill_events.R" %>% source
  "bwin_events.R" %>% source
  "unibet_events.R" %>% source
  "betstars_events.R" %>% source

  df_williamhill <- williamhill_events()
  df_bwin <- bwin_events()
  df_unibet <- unibet_events()
  df_betstars <- betstars_events()
  
  ## We bind all the dataframes in a unique one:
  
  df <- rbind(df_williamhill,df_bwin,df_unibet,df_betstars)
  
  ## We replace all the scrapped names in the data frame for the correct ones:
  for (i in c(1:20)){
    a <- agrep(as.character(ligue1_teams[i,2]), df[,1], max.distance = 0.1, ignore.case = TRUE)
    for (j in c(1:length(a))){
      df[a[j],1] <- as.character(ligue1_teams[i,1])
    }
  }

  write_csv(df,path = "C:/R Projects/webscraping/df.csv")
  #costs = list(ins=1,del=1,sub=1),
#}
