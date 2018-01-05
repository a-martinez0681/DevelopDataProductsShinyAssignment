Values of Computers By Manufacturer 2010-2016
========================================================
author: Alex Martinez
date: January 5, 2018
width: 1440
height: 900

Background & App Instructions
========================================================

I chose a simple concept for my first Shiny app. The user will select from one of three computer manufacturers and select one calendar year from 2010-2016. with these inputs, the program will display the computer prices for that manufacturer for each quarter of the selected year. Summary statistics are also displayed for reference.

This app provides a drop down list for both inputs: computer manufacturer and calendar year. Use the drop down lists to make your selection and click on the update button. It's that easy!


Code Excerpt - ui.R
========================================================


```r
shinyUI(fluidPage(titlePanel("Computer prices by manufacturer per quarter / year"),
     sidebarLayout(sidebarPanel(selectInput("pc", "Select the computer manufacturer",
        choices=c("Dell PC", "Hewlett Packard PC", "Apple iMac")), hr(),
        selectInput("year", "Select the year to show the sales per year and quarter",
               choices=c("2010", "2011", "2012", "2013", "2014", "2015", "2016")),
        hr(),helpText("Click Update"), hr(),
        submitButton("UPDATE")),
     mainPanel(plotOutput("plot1"),h4("Summary"),verbatimTextOutput("Summary"),
                        h4("Observations"),tableOutput("view"))
                        )
                )
     )
```

Code Excerpt - Server.R
========================================================


```r
pcdata <- read.csv("pcvalue.csv", sep=",", header=TRUE)
colnames(pcdata)[3] <- "Dell PC"; colnames(pcdata)[4] <- "Hewlett Packard PC"; colnames(pcdata)[5] <- "Apple iMac"
@shinyServer(function(input, output) {
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
```

Screen Shot of Shiny App
========================================================
![alt text](screenshot.png)
