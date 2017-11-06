
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
  odds <- html %>% html_nodes(".KambiBC-mod-outcome__odds") %>% html_text()
  
  #visitor <- html %>% html_nodes(".KambiBC-event-item--type-match:nth-child(1) .KambiBC-event-participants__name") %>% html_text()

  ## Now we create a dataframe with the needed data:
  match <- [1:1:(length(matches)/2)]
  df$home <- matches[1]
  
  df <- data.frame(matches, home, visitor, oddh, oddd, oddv)
  df$match <- [1:1:(length(matches)/2)]
  df$home <- matches[1]
  
  df <- data.frame(price, duration, departure_date, departure_time, company)
  df$destination <- dto
  df$departure <- dfrom
  df$date <- date
  df$scrapeDate <- Sys.Date()
  return(df)