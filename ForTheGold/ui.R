library(shiny)
library(dplyr)
library(ggplot2)

# For some reason, I had to put this in BOTH ui.R and server.R otherwise, my code wouldn't work.

base <- read.csv("data/ALLMEDALISTS.csv",skip=4)
base <- base %>% mutate(country = as.character(NOC))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Olympic Medal Count"),

  
  # Sidebar- create 3 inputs, one for year, one for sport and one for medal type
  
  sidebarLayout(
    sidebarPanel(
      p("The graph on the right shows the number of gold, silver, and/or bronze medals won by each country in a particular sport over a particular time period"),
      p("Use the controls below to choose what years you'd like to see, which sports you're interested in (pick 'ALL' to see all sports), and whether you'd like to look at the distribution of gold, silver, bronze, or all medals "),
      p("The data is from",
      a(em("The Guardian's"),"datasets.", href="http://www.theguardian.com/sport/datablog/2012/jun/25/olympic-medal-winner-list-data#data"),
      "It includes medal winner data from 1896 to 2008."),
      sliderInput("year", label = "Years",
                  min=min(base$Edition), max=max(base$Edition), step=4, value=c(1992,1996)),
      selectInput("sport", label="Sport",
                  choices=c("ALL",as.character(unique(base$Sport))),
                  selected="Aquatics"),
      radioButtons("color", label="Medal",
                   choices=c("ALL","Gold","Silver","Bronze"),
                   selected="ALL")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))