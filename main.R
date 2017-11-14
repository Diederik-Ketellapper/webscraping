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
  
df <- rbind(df_williamhill,df_bwin,df_unibet,df_betstars) #We bind everything into one only dataset we will work in from now.
rm(df_betstars,df_bwin,df_unibet,df_williamhill) # We remove the previous datasets to keep the environment clean.

## We take out accents from the webscrapped names (we use a loop since it's easier than other procedures due particularities of the iconv function):

for (i in c(1:40)){
  for (j in c(1,2)){
    df[i,j] <- iconv(df[i,j],from = 'UTF-8', to = 'ASCII//TRANSLIT')
  }
}

## We replace all the scrapped names in the data frame for the correct ones:
ligue1_teams <- read.csv("ligue1_teams.csv") # Read files with Ligue 1 official team names

for (i in c(1:40)){
  website <- agrep(df[i,6],colnames(ligue1_teams[1,]), max.distance = 0, ignore.case = TRUE)
  for (j in c(1,2)){
  b <- agrep(df[i,j],as.character(ligue1_teams[,website]), max.distance = 0, ignore.case = TRUE)
  df[i,j] <- ligue1_teams[b,1]
  }
}

write_csv(df,path = "C:/R Projects/webscraping/df.csv")