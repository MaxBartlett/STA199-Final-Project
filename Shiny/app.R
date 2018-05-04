# Load packages
library(shiny)
library(shinythemes)
library(tidyverse)

# Load data
sex_survey <- read_csv("/cloud/project/data/SexSurvey_tidy.csv")

# UI
ui <- fluidPage(theme = shinytheme("lumen"),
                titlePanel("Sexual Partners based on Demographic Factors"),
                sidebarLayout(
                  sidebarPanel(
                    
                    # Select type of trend to plot
                    #selectInput(inputId = "x", label = "X Axis:",
                    #            choices = c("age"),
                    #            selected = "age"),
                    
                    selectInput(inputId = "w", label = "Group X Axis By: ",
                                choices = c("gender", "year",
                                            "athlete", "greek", "politics", "religious", 
                                            "relationship"),
                                selected = "year"),
                    
                    selectInput(inputId = "y", label = "Y Axis: ",
                                choices = c("partners", "partners_college"),
                                selected = "partners_college"),
                    
                    selectInput(inputId = "z", label = "Color: ",
                                choices = c("gender", "year",
                                            "athlete", "greek", "politics", "religious",
                                            "relationship"),
                                selected = "gender")
                  ),
                  
                  # Output: Description, lineplot, and reference
                  mainPanel(
                    plotOutput(outputId = "barplot")
                    #textOutput(outputId = "desc")
                    #tags$a(href = "https://www.google.com/finance/domestic_trends", "Source: Google Domestic Trends", target = "_blank")
                  )
                )
)

server <- function(input, output) {
  
  #sex_survey_subset <- reactive({
  #  sex_survey %>%
    #filter(!is.na(input$w) & !is.na(input$y) & !is.na(input$z)) %>%
    #group_by(input$w)
  #  req(!is.na(input$w) | !is.na(input$y) | !is.na(input$z)) %>%
  #  group_by(input$w)
  #})
  
  # https://stackoverflow.com/questions/48673842/using-shiny-interactive-input-to-filter-na-values-not-working
  
  output$barplot <- renderPlot({
    #ggplot(data = sex_survey_subset(), aes_string(x = input$w, y = input$y, fill = input$z)) +
    #  geom_bar(stat = "summary", position = "dodge", fun.y = "mean")
    sex_survey %>%
      #filter(!is.na(input$w) | !is.na(input$y) | !is.na(input$z | !is.null(input$w) | is.null(input$y) | is.null(input$z))) %>%
      filter_(sprintf("!is.na(%s)", input$w)) %>%
      filter_(sprintf("!is.na(%s)", input$y)) %>%
      filter_(sprintf("!is.na(%s)", input$z)) %>%
      #filter_(sprintf("%s == Yes", input$))
      filter(student == "Yes") %>%
      group_by(input$w) %>%
      ggplot(aes_string(x = input$w, y = input$y, fill = input$z)) +
      geom_bar(stat = "summary", position = "dodge", fun.y = "mean")
  })
}

shinyApp(ui = ui, server = server)
  