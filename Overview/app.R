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

source("tests.R")
options(stringsAsFactors = FALSE)
# Define UI for application that draws a histogram
ui <- fluidPage(
  
titlePanel("Which site to bet on for your favorite team?"),

helpText('By: Eric Brea and Diederik Ketellapper '),

sidebarPanel(selectInput("Paris Saint-Germain", "Team:",
              list(`Ligue1` = ligue1))),
mainPanel(
  tabsetPanel(
    tabPanel("Plot", tableOutput("data")), 
    tabPanel("Link"), wellPanel(helpText(a("Click here to bet for your best odds",href="http://www.google.com", target="_blank")))
)))

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$data <- renderTable({iris
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

