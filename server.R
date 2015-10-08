

shinyServer(function(input, output) {
  
  filteredData <- reactive({
  filter(data,city==input$cityInput,name==input$rest,date<= input$dateInput[2],date >= input$dateInput[1],user_star >=as.numeric(input$ratingInput[1]),user_star <= as.numeric(input$ratingInput[2]))
  })
  
  
  output$restaurant <- renderUI({
    selectInput(inputId = "rest","choose Restaurant",choices = data$name[which(data$city%in%input$cityInput)] %>% unique() %>% sort())
     })
  

  
  output$daterange <- renderUI({
  dateRangeInput(inputId = "dateInput",label = "choose date range",start = "2013-01-01",end = "2014-01-01",weekstart = 1,language = "en",separator = "to")
  })
  
  output$ratingrange <- renderUI({
  sliderInput(inputId = "ratingInput",label = "choose ratings range",min = 1,max = 5,value = c(3,5))
  })
  
  output$mymap <- renderLeaflet({
    input$go
    if(input$go==0)
    {
      return()
    }
    isolate({
      data_fil <- filteredData()
    leaflet() %>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMarkers(lng=data_fil$longitude, lat=data_fil$latitude, popup=data_fil$name)
          })
  })
  
  output$data_filter <- renderDataTable({
    if(input$go==0){
      return()
    }
    isolate({
    filteredData()
    })
  })
})


