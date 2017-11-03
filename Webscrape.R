# Webscrape File 
library(rvest)
library(tidyverse)

b365<- read_html("https://www.bet365.com/#/AC/B1/C1/D13/E122/F16/R1/")

uk_b365 <- html_nodes(b365,".cm-CouponModule")

html <- read_html("http://www.imdb.com/title/tt1490017/")
cast <- html_nodes(html, "#titleCast .itemprop")
length(cast)