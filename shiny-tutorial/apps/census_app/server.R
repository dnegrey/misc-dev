# server.R


# code that will run only once when app is launched
library(maps)
source("helpers.R")
counties <- readRDS("data/counties.rds")


shinyServer( 
  
  # code that will run each time a new user visits the page
  function(input, output) {  
      
      output$map <- renderPlot({ 
        
        data <- switch(input$var, 
                       "Percent White" = counties$white,
                       "Percent Black" = counties$black,
                       "Percent Hispanic" = counties$hispanic,
                       "Percent Asian" = counties$asian)
        
        color <- switch(input$var, 
                        "Percent White" = "darkgreen",
                        "Percent Black" = "black",
                        "Percent Hispanic" = "darkorange",
                        "Percent Asian" = "darkviolet")
        
        legend <- switch(input$var, 
                         "Percent White" = "% White",
                         "Percent Black" = "% Black",
                         "Percent Hispanic" = "% Hispanic",
                         "Percent Asian" = "% Asian")
        
        # code that will run each time a user changes a widget
        percent_map(var = data, 
                    color = color, 
                    legend.title = legend, 
                    min = input$range[1], 
                    max = input$range[2]) 
        
      })
      
  }
)
