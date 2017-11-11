
options(stringsAsFactors = FALSE)
require(rvest)

scrapeJSSite <- function(dfrom, dto, date="2016-03-27"){
  
  ## change Phantom.js scrape file
  url <- paste0("https://www.busliniensuche.de/suche/?From=",dfrom,"&To=",dto,"&When=",date,"&ShowRidesharing=false&Company=Alle+Busunternehmen&Passengers=1&SearchMode=0&Radius=15000")
  lines <- readLines("scrape_final.js")
  lines[1] <- paste0("var url ='", url ,"';")
  writeLines(lines, "scrape_final.js")

  ## Download website
  system("phantomjs scrape_final.js")

  ### use Rvest to scrape the downloaded website.
  pg <- read_html("1.html")
  price <- pg %>% html_nodes(".soldout , .field-price strong") %>% html_text()
  price <- price[nchar(price)>1]
  duration <- pg %>% html_nodes(".field-duration") %>% html_text()
  departure_time <- pg %>% html_nodes(".col-departure .field-time") %>% html_text()
  departure_date <- pg %>% html_nodes(".col-departure .field-date") %>% html_text()
  company <- pg %>% html_nodes(".company-changeover , .company-hover span") %>% html_text()
  company <- company[nchar(company)>1]
  
  df <- data.frame(price, duration, departure_date, departure_time, company)
  df$destination <- dto
  df$departure <- dfrom
  df$date <- date
  df$scrapeDate <- Sys.Date()
  return(df)
}