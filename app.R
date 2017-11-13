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



wd<-getwd()
glue("{wd}/Overview/tests.R") %>% as.character %>% source
#glue("{wd}/all_team_events.R") %>% as.character %>% source


options(stringsAsFactors = FALSE)
# Define UI for application that draws a histogram
ui <- fluidPage(
  
titlePanel("Which site to bet on for your favorite team?"),

helpText('By: Eric Brea and Diederik Ketellapper '),

sidebarPanel(selectInput("team", "Team:",
              list(`Ligue1` = ligue1))),
mainPanel(
  tabsetPanel(
    tabPanel("Plot", tableOutput("data")), 
    tabPanel("Help",  
      h3("FAQ"),
      p("Q: Are all operating systems supported?"), 
      p("A: As of now only windows is supported"),
      p("Q: Will other leagues be added next to Ligue 1"),
      p("A: As of now there are no plans to add other leagues"),
      wellPanel(helpText(a("Still need help?",href="mailto:Eric.Brea-Garcia@polytechnique.edu", target="_blank")))
))))


# Define server logic required to draw a histogram
server <- function(input, output){

  
  output$data <- renderTable(read.csv(glue("{wd}/df.csv")) %>% 
      subset(visitor == input$team | home == input$team))
}

# Run the application 
shinyApp(ui = ui, server = server)

