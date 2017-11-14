#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(tidyverse)
library(shiny)
library(glue)
library(DT)


options(stringsAsFactors = FALSE)
wd<-getwd()

glue("{wd}/Overview/tests.R") %>% as.character %>% source




# UI
ui <- fluidPage(
  
titlePanel("Which site to bet on for your favorite team?"),

helpText('By: Eric Brea and Diederik Ketellapper '),
 ### Input is here. The source of the names is FIFA
sidebarPanel(selectInput("team", "Team:",
              list(`Ligue1` = ligue1))),
mainPanel(
  tabsetPanel(
    # The main plot is here
    tabPanel("Plot", dataTableOutput("data"),
    # Links to the websites are here
             helpText(a("Bet on: Williamhill",href="http://sports.williamhill.com/bet/fr-fr/betting/t/312/France+-+Ligue+1.html", target="_blank")),
             helpText(a("Bet on: Bwin",href="https://sports.bwin.fr/fr/sports/search?query=Ligue%201", target="_blank")),
             helpText(a("Bet on: Unibet",href="https://www.unibet.fr/sport/football/ligue-1", target="_blank")),
             helpText(a("Bet on: Betstars",href="https://www.betstars.fr/?no_redirect=1#/soccer/competitions/2152298", target="_blank"))
                ) , 
    # Here we have the FAQ just some text boxes and an htlml link to an email adress
    tabPanel("Help",  
      h3("FAQ"),
      p("Q: Are all operating systems supported?"), 
      p("A: As of now only windows is supported"),
      p("Q: Will other leagues be added in addition to Ligue 1?"),
      p("A: As of now there are no plans to add other leagues"),
      wellPanel(helpText(a("Still need help?",href="mailto:Eric.Brea-Garcia@polytechnique.edu?subject=Ligue 1 Webscraping Question", target="_blank")))
))))

server <- function(input, output,session){
# First reactively subselect the teams
    df<-reactive({read.csv(glue("{wd}/df.csv")) %>% 
      subset(visitor == input$team | home == input$team)})
# Find out the unique max 2nd values (we colour till those white) we need unique because otherwise the file will not work for similiar values which happens a lot in betting    
    oddh2<-function(){df()$oddh %>% unique() %>% sort(decreasing = TRUE) %>% nth(2)}
    oddd2<-function(){df()$oddd %>% unique() %>% sort(decreasing = TRUE) %>% nth(2)}
    oddv2<-function(){df()$oddv %>% unique() %>% sort(decreasing = TRUE) %>% nth(2)}
### Render the datatable here because of the fact that DT R integration is not 100% perfect slight work around    
    output$data <- renderDataTable({
     datatable(df(),options = list(dom = 't'),rownames = FALSE) %>% 
      formatStyle('oddh', backgroundColor = styleInterval(oddh2(), c('white', 'green')))  %>% 
      formatStyle('oddd', backgroundColor = styleInterval(oddd2(), c('white', 'green'))) %>% 
      formatStyle('oddv', backgroundColor = styleInterval(oddv2(), c('white', 'green'))) %>% 
      formatStyle(c('home','visitor','website'), backgroundColor = 'white') 
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

