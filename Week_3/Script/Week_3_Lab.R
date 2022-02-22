---
title: "Week_3_Lab"
author: "Robert Dellinger"
date: "2/8/2022"
output: 
---

#Install Packages
install.packages("palmerpenguins")
install.packages("tidyverse")

#Load Libraries
library(palmerpenguins)
library(tidyverse)

#Data Visualization
glimpse(penguins)
ggplot(data=penguins, 
       mapping=aes(x=bill_depth_mm, #xaxis
                   y=bill_length_mm)) #yaxis

ggplot(data=penguins, 
       mapping=aes(x=bill_depth_mm,
                   y=bill_length_mm)) + #adds layer
  geom_point()

ggplot(data=penguins, 
       mapping=aes(x=bill_depth_mm,
                   y=bill_length_mm,
                   color=species)) + #species
  geom_point()+
  labs(title = "Bill Depth and Length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", y = "Bill Length (mm)",
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package")+
  scale_color_viridis_d()




