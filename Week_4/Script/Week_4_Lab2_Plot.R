### Lab: Tidy ###################
### Created by: Robert Dellinger
### Date: 02/17/2022 ############


## Load Libraries ###############
library(tidyverse)
library(here)
library(beyonce)

## Load Data ####################
ChemData<-read_csv(here("Week_4","data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

## Clean Data #################### 
ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time column and separate into two columns Tide and Time (in order)
           into = c("Tide","Time"), 
           sep = "_", 
           remove= TRUE) # separate by _ and remove the column

head(ChemData_clean) # * come clean by Hilary Duff plays in the background *

##  Pivot Data using pivot_longer()  #################### 

ChemData_long <-ChemData_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. (select the temp to percent SGD colUMS)
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values

View(ChemData_long)



            
## Plot long data using Pivot ###########################

ChemData_long <- ChemData_long %>% 
  distinct(Variables) %>% 
  mutate(Descriptor = c("Temperature in situ (°C)", "Salinity", "Phosphate (umol/L)", "Silicate (umol/L)", "Nitrate & Nitrite (umol/L)", "pH", "Total alkalinity (umol/Kg)",  "Submarine groundwater \n discharge (%)")) %>% 
  right_join(ChemData_long) #adding in descriptor 

##  Summary Statistics (Mean)  #################### 

ChemData_long_mean <- ChemData_long %>%
  group_by(Variables, Descriptor, Time, Tide) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE))

view(ChemData_long)

ChemData_long %>%
  ggplot(aes(x = Tide, y = Values))+
  geom_violin(draw_quantiles = TRUE, show.legend= TRUE, trim= TRUE)+
  geom_point(data=ChemData_long_mean, aes(x=Tide, y=Param_means, shape=Time, color=Time), size=3)+
  scale_color_manual(values = c("gold", "midnightblue"))+
  scale_shape_manual(values = c(16, 8))+
  facet_wrap(~Descriptor, scales = "free")+
  labs(title = "Biogeochemical Parameters for High and Low Tide in Hawaii", #creating labels
     subtitle = "Differences between Day and Night",
     x = "Tide Level", y = "Values", caption = "Source: Silbiger et al. 2020")
  
  

  ##  Summary Statistics  #################### 
  ChemData_long %>%
    group_by(Variables, Time, Tide) %>% # group by everything we want
    summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
              Param_vars = var(Values, na.rm = TRUE),# get variance
              Param_sd = sd(Values, na.rm = TRUE)) # get sd



ChemData_long %>%
  group_by(Variables, Time, Tide) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE),# get variance
            Param_sd = sd(Values, na.rm = TRUE)) # get sd


  pivot_longer(cols = Temp_in:percent_sgd, 
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") %>%  # names of the new column with all the values
  group_by(Variables, Tide, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) 
View(ChemData_clean) %>% 
  pivot_wider(names_from = Variables, 
              values_from = mean_vals) %>% # notice it is now mean_vals as the col name
  write_csv(here("Week_4","output","summary.csv"))  # export as a csv to the right folder

ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free") # free scale