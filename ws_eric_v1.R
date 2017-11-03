#### SEARCH BAR AND WEB SCRAPPING FUNCTION ####

# Load and install the necessary packages:

library(jsonlite)
library(glue)
library(httr)
library(dplyr)

# Build the function for Unibet:

my_team_events <- function(team){
  url <- glue("https://www.unibet.co.uk/betting#filter/football/all/all/{team}")
  res <- read_html(url)
  if(res$status_code != 200){
    print("API error or team not in the database")
  } else {
    content(res)
  }
}

res <- my_team_events(team = "fc_barcelona")
res %>% class
res %>% length
res %>% names

//*[contains(concat( " ", @class, " " ), concat( " ", "KambiBC-mod-outcome__odds", " " ))]