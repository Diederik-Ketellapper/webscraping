library(DT)

datatable(iris, options = list(pageLength = 5)) %>%
  formatStyle('Sepal.Length', backgroundColor = styleInterval(5, c('white', 'yellow')), fontWeight = 'bold')

b<-iris$Sepal.Length %>% sort(decreasing = TRUE) %>% nth(2)


wd<-getwd()
df<-read.csv(glue("{wd}/df.csv"))

### Make values

df<- df %>% subset(visitor == "AS Monaco"| home == "AS Monaco") 
oddh2<-df$oddh %>% sort(decreasing = TRUE) %>% nth(2)
oddd2<-df$oddd %>% sort(decreasing = TRUE) %>% nth(2)
oddv2<-df$oddv %>% sort(decreasing = TRUE) %>% nth(2)
df%>% datatable(options = list(dom = 't'),rownames = FALSE) %>% 
  formatStyle('oddh', backgroundColor = styleInterval(oddh2, c('white', 'green'))) %>% 
  formatStyle('oddd', backgroundColor = styleInterval(oddd2, c('white', 'green'))) %>% 
  formatStyle('oddv', backgroundColor = styleInterval(oddv2, c('white', 'green'))) 
  
