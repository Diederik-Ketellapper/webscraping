# Webscrape File 
library(rvest)
library(tidyverse)

html<- read_html("http://sports.williamhill.es/bet_esp/es/betting/t/295/Inglaterra+-+Premier+League.html")
matches<- html %>% 
  html_nodes('.rowOdd a span') %>% 
  html_text()

prices<- html %>% 
html_nodes('.eventprice') %>% 
html_text()
prices


html <- read_html("https://www.10bet.com/sports/football/england-premier-league/")
bet_10 <- html %>% 
  html_nodes('#bra_1 span') %>% 
html_text()
bet_10

tix_link = paste("https://seatgeek.com/new-york-knicks-tickets#events")
tix_info = tix_link %>% read_html() %>%
  html_nodes(".event-listing-title span")
link_date = read_html(tix_link)
link_date = html_nodes(link_date, ".event-listing-date")
link_time = read_html(tix_link)
link_time = html_nodes(link_time, ".event-listing-time")
link_price = read_html(tix_link)
link_price = html_node(link_price, ".event-listing-button")
link_info = read_html(tix_link)
link_info = html_node(link_info, "span")

#convert to data frame
ticket_deals = data.frame(deals = html_text(tix_info),
                          date = html_text(link_date),
                          time = html_text(link_time),
                          price = html_text(link_price),
                          correpsonding_link = html_attr(link_info,"href"))

head(ticket_deals)
