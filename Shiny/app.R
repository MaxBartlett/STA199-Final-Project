# Load packages
library(shiny)
library(shinythemes)
library(tidyverse)

# Load data
sex_survey <- read_csv("/cloud/project/data/SexSurvey_tidy.csv")

# UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Test UI"),
                sidebarLayout(
                  sidebarPanel(
                    
                    # Select type of trend to plot
                    selectInput(inputId = "x", label = "X Axis:",
                                choices = c("age"),
                                selected = "age"),
                    
                    selectInput(inputId = "y", label = "Y Axis: ",
                                choices = c("partners", "partners_college"),
                                selected = "partners_college"),
                    
                    selectInput(inputId = "z", label = "Color: ",
                                choices = c("gender", "year", "student", "major_one",
                                            "athlete", "greek", "politics", "religious",
                                            "relationship"),
                                selected = "gender")
                  ),
                  
                  # Output: Description, lineplot, and reference
                  mainPanel(
                    plotOutput(outputId = "scatterplot")
                    #textOutput(outputId = "desc")
                    #tags$a(href = "https://www.google.com/finance/domestic_trends", "Source: Google Domestic Trends", target = "_blank")
                  )
                )
)

server <- function(input, output) {
  output$scatterplot <- renderPlot({
    ggplot(data = sex_survey, aes_string(x = input$x, y = input$y, color = input$z)) +
      geom_point()
  })
}

shinyApp(ui = ui, server = server)
  