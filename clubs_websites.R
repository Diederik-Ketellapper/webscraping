
html <- read_html("http://www.espnfc.com/french-ligue-1/9/table")
input <- html %>% html_nodes("#tables-overall a") %>% html_text() %>% tail(20)

