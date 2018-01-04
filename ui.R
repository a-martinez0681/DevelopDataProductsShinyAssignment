library(shiny)
library(ggplot2)
## UI
shinyUI(
        fluidPage(
                titlePanel("Computer prices by manufacturer per quarter / year"),
                sidebarLayout(
                        sidebarPanel(
                                selectInput("pc", "Select the computer manufacturer",
                                            choices=c("Dell PC", "Hewlett Packard PC", "Apple iMac")),
                                hr(),
                                selectInput("year", "Select the year to show the sales per year and quarter",
                                            choices=c("2010", "2011", "2012", "2013", "2014", "2015", "2016")),
                                hr(),
                                helpText("Click Update"),
                                hr(),
                                submitButton("UPDATE")),
                mainPanel(
                        plotOutput("plot1"),
                        h4("Summary"),
                        verbatimTextOutput("Summary"),
                        h4("Observations"),
                        tableOutput("view"))
                        )
                )
        )


