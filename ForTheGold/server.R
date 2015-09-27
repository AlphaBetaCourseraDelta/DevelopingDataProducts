library(shiny)
library(dplyr)
library(ggplot2)

base <- read.csv("data/ALLMEDALISTS.csv",skip=4)
base <- base %>% mutate(country = as.character(NOC))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    basesub <- filter(base, Edition>=input$year[1]) %>%
      filter(Edition<=input$year[2])
    
    if(input$sport!="ALL"){
      basesub<- filter(basesub,Sport==input$sport)}
    
    if(input$color!="ALL"){
      basesub<- filter(basesub,Medal==input$color)
      gcol=c(input$color)}else{
        gcol=c("#cd7f32","#ffd700","#C0C0C0")
      }
    gcol <- switch(input$color,
                   "Gold"= c("#ffd700"),
                   "Silver"=c("#C0C0C0"),
                   "Bronze"=c("#cd7f32"),
                   "ALL"=c("#cd7f32","#ffd700","#C0C0C0"))
    
    
    tb <- table(basesub$Medal, basesub$country)
    if(nrow(basesub)>0){
      ggplot(data=basesub,aes(x=factor(country),fill=factor(Medal)))+
        geom_bar(stat="bin",position="dodge")+
        theme(axis.text.x=element_text(angle=30))+
        xlab("Country Code")+
        ylab("Medal Count")+
        ggtitle("Olympic Medal Count")+
        scale_fill_manual(values=gcol, name="Medal")
    }else{
      par(mar = c(0,0,0,0))
      plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
      text(x = 0.5, y = 0.5,
           paste("No medals were awarded in this sport for these years"))}
})
})