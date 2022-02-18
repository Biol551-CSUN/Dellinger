
### Practicing Tidy with Biogeochemistry Data from Hawaii ##############
### Created by: Robert Dellinger #######################################
### Date: 02/17/2022 ###################################################


######################### Load Libraries ###############################

library(tidyverse)
library(here)


############################# Load Data ################################

ChemData<-read_csv(here("Week_4","data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

############################# Clean Data ################################

ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) #filters out everything that is not a complete row 

View(ChemData_clean) # *come clean by Hilary Duff plays in the background*

########################## Clean Data and Separate #######################

ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate into two columns Tide and Time (in order)
           sep = "_" ) # separate by _
head(ChemData_clean)

###################### Clean Data, Separate, and Unite ####################

ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>% # keep the original tide_time column
  unite(col = "Site_Zone", # the name of the NEW column
        c(Site,Zone), # the columns being used to unite into one
        sep = ".", # lets put a "." in the middle
        remove = FALSE) # keep the original
head(ChemData_clean)

###################### Pivot Data using pivot_longer() ###################

ChemData_long <-ChemData_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values

View(ChemData_long)

ChemData_long %>%
  group_by(Variables, Site, Zone, Tide) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE),# get variance
            Param_sd = sd(Values, na.rm = TRUE)) # get sd


########### Example using facet_wrap with long data #######################

ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free") # free scale

########### Example using facet_wrap with wide data #######################

ChemData_wide<-ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns
              values_from = Values) # column with the values

###########  calculating summary statistics and export csv file ###########

ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") %>%  # names of the new column with all the values
group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE)) 
View(ChemData_clean) %>% 
  pivot_wider(names_from = Variables, 
              values_from = mean_vals) %>% # notice it is now mean_vals as the col name
  write_csv(here("Week_4","output","summary.csv"))  # export as a csv to the right folder


