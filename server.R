library(shiny)
library(ggplot2)
# DATASET
pcdata <- read.csv("pcvalue.csv", sep=",", header=TRUE)
colnames(pcdata)[3] <- "Dell PC"; colnames(pcdata)[4] <- "Hewlett Packard PC"; colnames(pcdata)[5] <- "Apple iMac"

## SERVER
shinyServer(function(input, output) {
        pcdataInput <- reactive({
                subset(pcdata, select=c(input$pc), subset=(substring(pcdata$Date,1,4) == input$year))
        })
        ## PLOT
        output$plot1 <- renderPlot({
                ## RENDER
                barplot(pcdataInput()[,input$pc],
                        main=paste(input$pc, "in", input$year),
                        ylab="Values USD",xlim=c(0,6), ylim=c(0,1000),
                        xlab="Quarter PC Values")
        })
        # DATASET SUMMARY
        output$Summary <- renderPrint({
                dataset <- pcdataInput()
                summary(dataset)
        })
        
        # SHOW 4 QUARTER OBSERVATIONS
        output$view <- renderTable({
                head(pcdataInput(), n = 4)
        })
})


