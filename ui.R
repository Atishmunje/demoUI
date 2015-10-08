suppressMessages({library(shiny)
  library(shinythemes)
  library(dplyr)
  library(leaflet)
})

shinyUI(fluidPage(title = "Search Engine",theme = shinytheme("united"),
                  sidebarLayout(
                    sidebarPanel( 
                      selectInput("cityInput",choices = city,label = "choose city",multiple = T),
                      uiOutput("restaurant"),
                      br(),
                     tags$h4( tags$strong("Filters")),
                      uiOutput("daterange"),
                      uiOutput("ratingrange"),
                     actionButton(inputId = "go",label = "update")
                      
                      
                      
                    ),
                    mainPanel(
                      leafletOutput("mymap"),
                      dataTableOutput("data_filter")
                      
                    )
                  )
                  
                  
))
