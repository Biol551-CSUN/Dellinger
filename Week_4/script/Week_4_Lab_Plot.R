
### Lab: Dyplr ##############
### Created by: Robert Delllinger
### Date: 02/15/2022 ############


## Laod Libraries ###############

library(palmerpenguins)
library(tidyverse)
library(here) 
library(beyonce)
library(devtools)
devtools::install_github("dill/beyonce")

## Load Data ####################
glimpse(penguins)
head(penguins)

## Part 1 ####################
penguins %>%
  drop_na(species, island, sex) %>% 
  group_by(species, island, sex) %>% 
  summarize(mean_body_mass_g = mean(body_mass_g, na.rm = TRUE), 
            variance_body_mass_g = var(body_mass_g, na.rm = TRUE))
                      
## Part 2 ####################

plot <-penguins %>% # use penguin data frame
  filter(sex != "male") %>% #filter out males
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(species, island, sex, log_mass) %>% # select species, island, sex, and log biomasss
  ggplot(aes(x = species, y = log_mass, fill = species)) + # plot log biomass per species of female penguins 
  geom_boxplot(outlier.shape = NA) +
  labs(title = "Log Body Mass of Female Penguins", #creating labels
       subtitle = "Differences for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Species", y = "Log Body Mass (g)", fill = "Species",caption = "Source: Palmer Station LTER / palmerpenguins package")+
     scale_fill_manual(values= beyonce_palette(18))+
  theme_linedraw()+
  theme(title = element_text(size = 15), axis.title = element_text(size = 15),
        panel.background = element_rect(fill = "lightcyan1")) 
  
plot 

ggsave(here('Week_4/Output', "Box_Plot_Figure.png"), plot) #save plot to an output folder
  
  

