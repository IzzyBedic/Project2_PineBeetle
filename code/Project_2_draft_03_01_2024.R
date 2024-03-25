# Predicting the Minimum Linear Distance from a Given Pine Tree to the Nearest #
# Tree that is Infected by Pine Beetles                                        #

# Izzy Bedichek #
# use Git to do this
# Make RPubs Account for submitting the assignment
# click the upper right hand icon that says publish on Rmd doc to submit

# do an objective/READ_ME tab, "analytic strategy", "modeling strategy"
# ideas: codebook, left to right and up to down 

# Loading Libraries

library(reprex)
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
                              "SDI_20th",
                              "BA_Inf_20th")) 

pine_fact_tbl <- pine_tbl %>% 
  mutate(IND_BA_Infest_20th_fac = factor(IND_BA_Infest_20th,
                              levels = 0:1,
                              labels = c("No", "Yes")))

ggpairs(pine_fact_tbl, columns = c("DeadDist", 
                                   "TreeDiam", 
                                   "Infest_Serv1", 
                                   "SDI_20th"), ggplot2::aes(color = IND_BA_Infest_20th_fac))


# ggpairs(pine_tbl, columns = c("DeadDist", 
#                               "Ind_DeadDist")) # DeadDist is given in homework desc

ggpairs(pine_tbl, columns = c("SDI_20th", 
                            # "Neigh_SDI_1/4th", 1/20th pref
                              "BA_20th")) # comes down to SDI or basal area, multicollinearity. Decided on SDI!
                            #  "Neigh_1/4th", 1/20th pref
                            #  "Neigh_1/2th", 1/20th pref
                            #  "Neigh_1")), 1/20th pref
                            # "Neigh_1.5")) smaller acreage always 
                            # multicollinearity, only need one

# ggpairs(pine_tbl, columns = c("BA_Inf_20th", --> winner, closest to pine beetle range
                              # "BA_Infest_1/4th", 1/20th pref
                              # "BA_Infest_1/2th", 1/20th pref
                              # "BA_Infest_1", 1/20th pref
                              # "BA_Infest_1.5")) 1/20th pref

# ggpairs(pine_tbl, columns = c("IND_BA_Infest_20th", --> winner
                             # "IND_BA_Infest_1/4th", 1/20th pref
                             # "IND_BA_Infest_1/2th", 1/20th pref
                             # "IND_BA_Infest_1", 1/20th pref
                             # "IND_BA_Infest_1.5")) 1/20th pref

# how to compare "IND_BA_Infest_20th" and "BA_Inf_20th"? 
# Binary is harder to see a normal dist for, so I'll use the non-binary one
        
        
# Haven't decided which variables to use, but here is the code that will be used
# Use 1/20th when possible, and factor in TreeDiam


# verify Ridge Regression performance with standard linear regression approach
lm(sqrt(DeadDist) ~ TreeDiam + Infest_Serv1 + BA_20th, data = pine_tbl) %>% 
  glance()


