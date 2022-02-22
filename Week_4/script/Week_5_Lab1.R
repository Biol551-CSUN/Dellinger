### Lab: Becker & Silbiger Journal of Experimental Biology ##############
### Created by: Robert Delllinger #######################################
### Date: 02/22/2022 ####################################################


## Laod Libraries ###############
library(tidyverse)
library(here)

### Load Data ####

# Environmental data from each site
EnviroData<-read_csv(here("Week_5","data", "site.characteristics.data.csv"))
#Thermal performance data
TPCData<-read_csv(here("Week_5","data","Topt_data.csv"))

view(EnviroData)
view(TPCData)


### Pivot Data #####
#arrange() deals with rows 
#relocate() deals with columns
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, # pivot the data wider
              values_from = values) %>%
  arrange(site.letter) # arrange the dataframe by site
View(EnviroData_wide)


### Join data ###

FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) # relocate all the numeric data after the character data

head(FullData_left)

FullData_left %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE)



