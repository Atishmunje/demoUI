suppressMessages({library(shiny)
  library(shinythemes)
  library(dplyr)
  library(leaflet)
})

shinyUI(fluidPage(title = "Search Engine",theme = shinytheme("united"),
                  sidebarLayout(
                    sidebarPanel( 
                      selectInput("cityInput",choices = city,label = "choose city",multiple = F),
                      uiOutput("restaurant"),
                      br(),
                     tags$h4( tags$strong("Filters")),
                      uiOutput("daterange"),
                      uiOutput("ratingrange"),
                     actionButton(inputId = "go",label = "update")
                      
                      
                      
                    ),
                    mainPanel(
                      leafletOutput("mymap",width = 600,height = 400),
                      uiOutput("info",inline = T),
                      br(),
                      dataTableOutput("data_filter")
                    
                      
                    )
                  )
                  
                  
))
