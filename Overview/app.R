#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  selectInput("variable", "Variable:",
              list(`Eredivisie` = c("ADO Den Haag",
                                    "AFC Ajax",
                                    "AZ Alkmaar",
                                    "SBV Excelsior",
                                    "Feyenoord",
                                    "FC Groningen",
                                    "SC Heerenveen",
                                    "Heracles Almelo",
                                    "NAC Breda",
                                    "PEC Zwolle",
                                    "PSV Eindhoven",
                                    "Roda JC Kerkrade",
                                    "Sparta Rotterdam",
                                    "FC Twente",
                                    "FC Utrecht",
                                    "Vitesse",
                                    "VVV-Venlo",
                                    "Willem II"),
                   `West Coast` = c("WA", "OR", "CA"),
                   `Midwest` = c("MN", "WI", "IA"))),
  tableOutput("data")
)
# Define server logic required to draw a histogram
server <- function(input, output) {
  output$data <- renderTable({iris
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

