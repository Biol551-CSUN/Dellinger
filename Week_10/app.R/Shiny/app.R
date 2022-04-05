# Week 10: Shiny App

library(shiny)
library(tidyverse)


ui<-fluidPage(
    sliderInput(inputId = "num", # ID name for the input
                label = "Choose a number", # Label above the input plot
                value = 25, min = 1, max = 100 # values for the slider bar
    ),
    plotOutput("hist") #creates space for a plot called hist  
)


server<-function(input,output){
    output$hist <- renderPlot({
        # {} allows us to put all our R code in one nice chunk
        data<-tibble(x = rnorm(input$num)) # 100 random normal points
        ggplot(data, aes(x = x))+ # make a histogram graph
            geom_histogram()
    })
}