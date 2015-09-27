library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Olympic Medal Count"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
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
