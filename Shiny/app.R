# Load packages
library(shiny)
library(shinythemes)
library(tidyverse)

# Load data
sex_survey <- read_csv("data/SexSurvey_tidy.csv")

# UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Test UI"),
                sidebarLayout(
                  sidebarPanel(
                    
                    # Select type of trend to plot
                    selectInput(inputId = "y", label = "Y Axis:",
                                choices = c("major_one", "gender", "year"),
                                selected = "major_one"),
                    
                    selectInput(inputId = "x", label = "X Axis: ",
                                choices = c("partners", "partners_college"),
                                selected = "partners_college")
                    # Select date range to be plotted
                    #dateRangeInput("date", strong("Date range"), 
                     #              start = "2007-01-01", end = "2017-07-31",
                     #              min = "2007-01-01", max = "2017-07-31"),
                    
                    # Select whether to overlay smooth trend line
                    #checkboxInput(inputId = "smoother", 
                      #            label = strong("Overlay smooth trend line"), 
                       #           value = TRUE),
                    
                    # Display only if the smoother is checked
                    #conditionalPanel(condition = "input.smoother == true",
                     #                sliderInput(inputId = "f", label = "Smoother span:",
                      #                           min = 0.01, max = 1, value = 0.67, step = 0.01,
                       #                          animate = animationOptions(interval = 100)),
                       #              HTML("Higher values give more smoothness.")
                    #)
                  ),
                  
                  # Output: Description, lineplot, and reference
                  mainPanel(
                    plotOutput(outputId = "scatterplot", height = "300px")
                    #textOutput(outputId = "desc")
                    #tags$a(href = "https://www.google.com/finance/domestic_trends", "Source: Google Domestic Trends", target = "_blank")
                  )
                )
)
