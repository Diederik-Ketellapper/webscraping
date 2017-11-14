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

sidebarPanel(selectInput("team", "Team:",
              list(`Ligue1` = ligue1))),
mainPanel(
  tabsetPanel(
    # The main plot is here
    tabPanel("Plot", dataTableOutput("data")), 
    # Here we have the FAQ just some text boxes and an htlml link
    tabPanel("Help",  
      h3("FAQ"),
      p("Q: Are all operating systems supported?"), 
      p("A: As of now only windows is supported"),
      p("Q: Will other leagues be added in addition to Ligue 1?"),
      p("A: As of now there are no plans to add other leagues"),
      wellPanel(helpText(a("Still need help?",href="mailto:Eric.Brea-Garcia@polytechnique.edu?subject=Ligue 1 Webscraping Question", target="_blank")))
))))

server <- function(input, output,session){
#output$
    df<-reactive({read.csv(glue("{wd}/df.csv")) %>% 
      subset(visitor == input$team | home == input$team)})
    
    oddh2<-function(){df()$oddh %>% unique() %>% sort(decreasing = TRUE) %>% nth(2)}
    oddd2<-function(){df()$oddd %>% unique() %>% sort(decreasing = TRUE) %>% nth(2)}
    oddv2<-function(){df()$oddv %>% unique() %>% sort(decreasing = TRUE) %>% nth(2)} 
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

