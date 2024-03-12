# Predicting the Minimum Linear Distance from a Given Pine Tree to the Nearest #
# Tree that is Infected by Pine Beetles                                        #

# Izzy Bedichek #
# use Git to do this
# Make RPubs Account for submitting the assignment
# click the upper right hand icon that says publish on Rmd doc to submit

# do an objective/READ_ME tab, "analytic strategy", "modeling strategy"
# ideas: codebook, left to right and up to down 

# Loading Libraries

library(flexdashboard)
library(tidyverse)
library(readxl)
library(GGally)
library(vip)
library(tidymodels)


# Reading in the Data


pine_tbl <- read_excel("../hgen-612_temp/p1/data/Data_1993.xlsx", sheet = 1)


# Showcasing the Data

ggpairs(pine_tbl, columns = c("DeadDist", 
                              "TreeDiam", 
                              "Infest_Serv1", 
                              "SDI_20th")) 

ggpairs(pine_tbl, columns = c("DeadDist", 
                              "Ind_DeadDist")) # Only need one of these bc highly corr

ggpairs(pine_tbl, columns = c("SDI_20th", 
                              "Neigh_SDI_1/4th", 
                              "BA_20th", 
                              "Neigh_1/4th", 
                              "Neigh_1/2th",
                              "Neigh_1",
                              "Neigh_1.5")) # multicollinearity, only need one

ggpairs(pine_tbl, columns = c("BA_Inf_20th",
                              "BA_Infest_1/4th",
                              "BA_Infest_1/2th",
                              "BA_Infest_1",
                              "BA_Infest_1.5")) # multicollinearity, only need one

ggpairs(pine_tbl, columns = c("IND_BA_Infest_20th",
                              "IND_BA_Infest_1/4th",
                              "IND_BA_Infest_1/2th",
                              "IND_BA_Infest_1",
                              "IND_BA_Infest_1.5")) # multicollinearity, only need one

# Haven't decided which variables to use, but here is the code that will be used

pine_recipe <- pine_tbl %>% 
  recipe(DeadDist ~ TreeDiam + Infest_Serv1 +  SDI_20th + BA_20th) %>% 
  step_sqrt(all_outcomes()) %>% # transforms to make normal
  step_corr(all_predictors()) # gets rid of variables to get rid of multicolinearity



