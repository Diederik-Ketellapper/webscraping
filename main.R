#### WEB SCRAPPING THE DIFFERENT WEBSITES ####

# In this script we run the different functions developed to webscrappe each website, we clean the data and generate the dataframe used to display the results shinyapp.
# The main package used to webscrappe the websites is rvest, but it wasn't enough to get the job done. We managed to webscrappe William Hill and Bwin, but where unable to webscrappe Unibet and betstars.
# With the latter 2, we struggled because they use a delayed Java-Script-based rendering.
# To deal with this we have used a headless browser called PhantomJS and a java script to load the website using the headless browser, and then we use rvest to gather the data.
# We have done it following this tutorial: https://www.r-bloggers.com/web-scraping-javascript-rendered-sites/
# It's important to note that it only works on Windows!! Since only the windows file for running phantomejs is included in this folder project. To make it work in iOS or Linux then the respective phantomjs executable file should be downloaded from the internet and copied in the environment.

## Load and install the necessary packages:

library(tidyverse)
library(jsonlite)
library(dplyr)

## Now we are going to use the functions created separately to gather the data from each one:

# Load the functions:
"williamhill_events.R" %>% source
"bwin_events.R" %>% source
"unibet_events.R" %>% source
"betstars_events.R" %>% source

# Run them to get the data:
df_williamhill <- williamhill_events()
df_bwin <- bwin_events()
df_unibet <- unibet_events()
df_betstars <- betstars_events()
  
## We bind all the dataframes in a unique one:
  
df <- rbind(df_williamhill,df_bwin,df_unibet,df_betstars) #We bind everything into one only dataset we will work in from now.
rm(df_betstars,df_bwin,df_unibet,df_williamhill) # We remove the previous datasets to keep the environment clean.

#### CLEANING THE DATASET ####

## We take out accents from the webscrapped names (we use a loop since it's easier than other procedures due particularities of the iconv function):

for (i in c(1:40)){
  for (j in c(1,2)){
    df[i,j] <- iconv(df[i,j],from = 'UTF-8', to = 'ASCII//TRANSLIT')
  }
}

## We replace all the scrapped names in the data frame for the correct ones:
ligue1_teams <- read.csv("ligue1_teams.csv") # Read file with Ligue 1 official team names and equivalent in each website

## We apply a loop in which by measuring the generalized Levenshtein distance we identify to which team corresponds the scrapped name in the home and visitor columns, and replaces it with the official UEFA name.
## This was an strong issue to overcome due to webscrapped team names differ across websites.

for (i in c(1:40)){
  website <- agrep(df[i,6],colnames(ligue1_teams[1,]), max.distance = 0, ignore.case = TRUE)
  for (j in c(1,2)){
  b <- agrep(df[i,j],as.character(ligue1_teams[,website]), max.distance = 0, ignore.case = TRUE)
  df[i,j] <- ligue1_teams[b,1]
  }
}

## we write in a csv file the final clean data frame to be used by the shiny app:

write_csv(df,path = "C:/R Projects/webscraping/df.csv")