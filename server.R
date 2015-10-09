

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
  
  output$info <- renderUI({
    input$go
    if(input$go==0)
    {
      return()
    }
    isolate({
      data_f <- filteredData()
    nam <- paste0(tags$strong("Name: "),unique(data_f$name),collapse = "")
    addr <-paste0(tags$strong("Address: "),unique(data_f$full_address),collapse = "")
    star <-paste0(tags$strong("Stars: "),unique(data_f$stars),collapse = "")
    HTML(paste(nam,addr,star,sep = "<br>"))
    
    })
    
  })
  
  
  output$data_filter <- renderDataTable({
    if(input$go==0){
      return()
    }
    isolate({
    data_filt <- filteredData()
    data_filt<- data_filt %>% select(text,prob) %>% arrange(.,desc(prob)) %>% select(text)
    #head tail loaded when no of text are very low ...same text is coming in both...better to have threshold !!  
    top_pos <- head(data_filt ,5)
    top_neg <- tail(data_filt,5)
    dt <- data.table::data.table(Top_Positive= top_pos,Top_Negative = top_neg)
    return(dt)
    })
  })
})


