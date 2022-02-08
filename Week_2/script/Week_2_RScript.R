##################
#Importing Data into R
#Created by Robert Dellinger
#Created on 2022-02-03
##################

####Load Library########
library(here)
library(tidyvers)

####Read in Data########
weightdata<-read.csv(here("Week_2", "data", "weightdata.csv"))

####Data Analysis########
head(weightdata)
tail(weightdata)
View(weightdata)
