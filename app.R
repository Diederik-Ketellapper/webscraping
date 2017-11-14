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
    tabPanel("Plot", dataTableOutput("data")), 
    tabPanel("Help",  
      h3("FAQ"),
      p("Q: Are all operating systems supported?"), 
      p("A: As of now only windows is supported"),
      p("Q: Will other leagues be added in addition to Ligue 1?"),
      p("A: As of now there are no plans to add other leagues"),
      wellPanel(helpText(a("Still need help?",href="mailto:Eric.Brea-Garcia@polytechnique.edu?subject=Ligue 1 Webscraping Question", target="_blank")))
))))


# Define server logic required to draw a histogram
server <- function(input, output){

  
  output$data <- renderDataTable(read.csv(glue("{wd}/df.csv"), col.names = c("Home","Visitor","1","X","2","Website"), check.names = FALSE) %>% 
      subset(Visitor == input$team | Home == input$team)
      
      , options = list(dom = 't'),rownames = FALSE)
}

# Run the application 
shinyApp(ui = ui, server = server)

