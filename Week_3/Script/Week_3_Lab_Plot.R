---
  title: "Week_3_Lab_HW"
author: "Robert Dellinger"
date: "2/10/2022"
---
  
  
#Install Packages
install.packages("palmerpenguins")
install.packages("tidyverse")
install.packages("here")
install.packages("devtools")
devtools::install_github("dill/beyonce")

#Load Libraries
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)

#Data Visualization
glimpse(penguins)
penguins<-na.omit(penguins)

plot <- ggplot(data=penguins, 
       mapping=aes(x=species,
                   y=body_mass_g,
                   fill=sex)) + #sex
  geom_boxplot(outlier.shape = NA)+
  labs(title = "Body Mass & Biological Sex of Penguins",
       subtitle = "Differences for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Species", y = "Body Mass (g)",
       fill = "Sex",
       caption = "Source: Palmer Station LTER / palmerpenguins package")+
  theme_bw()+
  theme(axis.title = element_text(size = 20),
        panel.background = element_rect(fill = "white")) 
  ggsave(here('Week_3/output', "Box_Plot_Figure.png"), plot) #save plot to an output folder
