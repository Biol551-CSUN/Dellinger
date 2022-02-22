
### Lecture: Dyplr ##############
### Created by: Robert Delllinger
### Date: 02/15/2022 ############

## Laod Libraries ###############
library(palmerpenguins)
library(tidyverse)
library(here) 

## Load Data ####################
glimpse(penguins)
head(penguins)

# extract rows with filter()
# arrange/sort rows with arrange()

filter(.data = penguins, 
       sex == "female") #selecting for female penguins within the data frame

filter(.data = penguins, 
       year == "2008") #selecting for penguins measured in the year 2008

filter(.data = penguins, 
       body_mass_g > "5000")  #selecting for penguins that have a body mass greater than 5000
       
filter(.data = penguins, 
       body_mass_g > "5000",
       year == "2008") #selecting for penguins that have a body mass greater than 5000 in the year 2008

filter(.data = penguins, 
       year == 2008 | year == 2009) #selecting for penguins measured in the year 2008 or 2009


filter(.data = penguins, 
       island != "Dream") #selecting for penguins that are not from the island labeled "Dream" (!=)

filter(.data = penguins,
       species == "Adelie" | species == "Gentoo") #selecting for Adelie or Gentoo penguin species 

filter(.data = penguins,
       species %in% c("Adelie", "Gentoo")) #another way to select for Adelie or Gentoo penguin species
       
------
#mutating data: adding new columns using mutate()
penguins2<-mutate(.data=penguins,
                  body_mass_kg = body_mass_g/1000) # adding a column of penguin wieghts in kg 
                                                   # from the existing weights in gram columnn
view(penguins2)

penguins2<-mutate(.data=penguins,
                  body_mass_kg = body_mass_g/1000,
                  bill_length_depth = bill_length_mm/bill_depth_mm)
view(penguins2)

#mutating data with ifelse (use case_when when there are more then two outcomes)

penguins2 <- mutate(.data=penguins,
                  after_2008 = ifelse(year>2008, "After 2008", "Before 2008")) #transforming data into two groups
  
penguins3 <- mutate(.data=penguins,
                    flipper_body_mass_sum = flipper_length_mm + body_mass_g)
view(penguins3)

penguins4 <- mutate(.data = penguins,
                  greater_4000 = ifelse(body_mass_g > 4000, "Large", "Small"))
view(penguins4)

---
### Selecting: extract columns with select() (use command shift + m for the pipe %>% )
  # pipe allows for commands to occur in an organized order 
  
penguins %>% # use penguin data frame
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(species, island, sex, log_mass)

penguins %>% #summarize data into a table 
  summarize(mean_flipper = mean(flipper_length_mm, na.rm=TRUE)) #calculate the mean flipper length and exclude NA

penguins %>% # 
  summarize(mean_flipper = mean(flipper_length_mm, na.rm=TRUE), #mean flipper length summarized 
            min_flipper = min(flipper_length_mm, na.rm=TRUE)) #min flipper length summarized 

---
### Using the group_by() function prior to summarizing data allows us to summarize values by groups 

penguins %>%
  group_by(island) %>% #summarizing penguin data by island (must be placed before summarize) 
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))

---
### Remove NAs

penguins %>%
  drop_na(sex)

### Pipe data into ggplot 
penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()

--- 

library(devtools) # load the development tools library
devtools::install_github("jhollist/dadjoke")

library(dadjoke)
dadjoke()




