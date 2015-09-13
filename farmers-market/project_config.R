################################################################################
### name:    project_config
### client:  
### project: farmers_market
### author:  Swift Analytics - Dan Negrey
### date:    2014.10.03
### desc:    Project configuration file
################################################################################


## increase java heap space
options(java.parameters = "-Xmx4g")


## load necessary packages
library(XLConnect)
library(mapproj)
library(grid)
library(dplyr)
library(ggplot2)
library(scales)
library(knitr)
library(markdown)


## source project functions
lapply(X = as.list(paste("./lib/r/", 
                         list.files("./lib/r")[
                           substr(list.files("./lib/r"), 
                                  nchar(list.files("./lib/r")) - 1, 
                                  nchar(list.files("./lib/r"))) == ".R"], 
                         sep = "")), 
       FUN = source)
       
       
