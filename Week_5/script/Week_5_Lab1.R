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

summary <- FullData_left %>% 
  group_by(site.letter) %>% 
  summarise_if(is.numeric, list(mean=mean, var=var), na.rm = TRUE)

summary


### Making a Tibble ###

T1 <- tibble(Site.ID = c("A", "B", "C", "D"), 
                   Temperature = c(14.1, 16.7, 15.3, 12.8))
T1

T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))
T2

#left_join() versus right_join()

left_join(T1, T2)

right_join(T1, T2)

#inner_join() keeps the data that is complete in both data sets.

inner_join(T1, T2)

#full_join() keeps all data from data sets 

full_join(T1, T2)



## package of the day 
install.packages("cowsay")
library(cowsay)

say("hello", by = "shark")
