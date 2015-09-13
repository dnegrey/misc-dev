################################################################################
### name:    explore_data
### client:  
### project: farmers_market
### author:  Swift Analytics - Dan Negrey
### date:    2014.10.03
### desc:    Explore data
################################################################################


## source project config
source("./code/project_config.R")


## note: data sourced from USDA via data.gov at:
## https://catalog.data.gov/dataset/farmers-markets-geographic-data


## load workbook
fm <- loadWorkbook("./data/in/2013")
# list sheets
getSheets(fm)


## read sheet
export <- readWorksheet(fm, "Export", startRow = 3)
# some checks
nrow(export) == n_distinct(export$FMID)
sum(is.na(export$FMID))
sum(is.na(export$State))
sum(is.na(export$x))
sum(is.na(export$y))
View(export[is.na(export$x) | is.na(export$y), ])
unique(export[order(export$State), ]$State)
# 55 records: 3 misspellings plus DC and Virgin Islands


## clean up state names
markets <- export %>% 
  mutate(State = ifelse(State == "Calafornia", 
                        "California", 
                        ifelse(State == "Miinesota", 
                               "Minnesota", 
                               ifelse(State == "Virigina", 
                                      "Virginia", 
                                      State))))
# check
unique(markets[order(markets$State), ]$State)


## plot locations using lon and lat
state_map <- map_data("state")
# map
ggplot() + 
  geom_polygon(data = state_map, 
               aes(x = long, 
                   y = lat, 
                   group = group), 
               fill = "white", 
               colour = "darkgray") + 
  geom_point(data = filter(markets, 
                           x >= min(state_map$long), 
                           x <= max(state_map$long), 
                           y >= min(state_map$lat), 
                           y <= max(state_map$lat)), 
             aes(x = x, 
                 y = y), 
             colour = "darkseagreen3") + 
  coord_map("polyconic")


## check for states in map
markets %>% 
  filter(!(tolower(State) %in% state_map$region)) %>% 
  group_by(State) %>% 
  summarise(NumMarkets = n()) %>% 
  arrange(State)
# good, just Alaska, Hawaii and Virgin Islands
states <- markets %>% 
  mutate(state = tolower(State)) %>% 
  filter(state %in% state_map$region) %>% 
  group_by(state) %>% 
  summarise(num_markets = n()) %>% 
  arrange(state)
# check
range(states$num_markets)


## join on market counts to state map data
sm <- state_map %>% 
  left_join(mutate(states, 
                   region = state), 
            by = "region") %>% 
  mutate(num_markets = ifelse(is.na(num_markets), 
                              0, 
                              num_markets))


## create choropleth map based on market count
gg1 <- ggplot() + 
  geom_polygon(data = sm, 
               aes(x = long, 
                   y = lat, 
                   group = group, 
                   fill = num_markets), 
               colour = "gray50") + 
  scale_fill_gradient(low = "white", high = "darkseagreen4") + 
  coord_map("polyconic") + 
  labs(x = "Longitude", 
       y = "Latitude", 
       fill = "Market Count") + 
  theme(axis.title.x = element_text(size = 14, face = "bold"), 
        axis.title.y = element_text(size = 14, face = "bold", vjust = 0.75), 
        legend.title = element_text(size = 10, face = "bold"), 
        legend.key.width = unit(0.75, "in"), 
        legend.position = "bottom", 
        legend.direction = "horizontal")


## write image out to file
png("./graphs/us_farmers_markets.png", 
    width = 1200, 
    height = 600)
gg1 + 
  ggtitle(expression(atop(bold("United States Farmers Market Penetration"), 
                          "https://catalog.data.gov/dataset/farmers-markets-geographic-data"))) + 
  theme(plot.title = element_text(size = 18, vjust = 0.75))
dev.off()


## try to pull data in with code
# download file
download.file(url = "http://www.ams.usda.gov/AMSv1.0/getfile?dDocName=STELPRDC5087258", 
              destfile = "./data/in/2013c")
# read in
fmc <- loadWorkbook("./data/in/2013c")
# list sheets
getSheets(fmc)
# read sheet
exportc <- readWorksheet(fmc, "Export", startRow = 3)
# check same
sum(!(export == exportc), na.rm = TRUE)
# good - 0
file.remove("./data/in/2013c")





