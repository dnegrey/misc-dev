library(shiny)
library(maps)
library(mapproj)
source("apps/census_app/helpers.R")
counties <- readRDS(file = "apps/census_app/data/counties.rds")

# run examples
runExample(example = "01_hello")
runExample(example = "02_text")
runExample(example = "03_reactivity")
runExample(example = "04_mpg")
runExample(example = "05_sliders")
runExample(example = "06_tabsets")
runExample(example = "07_widgets")
runExample(example = "08_html")
runExample(example = "09_upload")
runExample(example = "10_download")
runExample(example = "11_timer")

# run app from tutorial 2
runApp(appDir = "./apps/app_1", 
       display.mode = "showcase")

# run first app from tutorial 3
runApp(appDir = "./apps/app_2", 
       display.mode = "showcase")

# run final app from tutorial 3
runApp(appDir = "./apps/app_3", 
       display.mode = "showcase")

# run census app from tutorial 4
runApp(appDir = "./apps/app_4", 
       display.mode = "showcase")
 
# test percent_map function for creating a choropleth map
percent_map(var = counties$white, 
            color = "darkgreen", 
            legend.title = "% white")

# run census app from tutorial 5
runApp(appDir = "./apps/census_app", 
       display.mode = "showcase")
