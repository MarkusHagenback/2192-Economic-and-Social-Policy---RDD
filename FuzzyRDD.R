--------------------------------------------------------------------
# Part 0 - Set-up: 
--------------------------------------------------------------------
#install.packages("tidyverse")
#install.packages("broom")  
#install.packages("rdrobust")  
#install.packages("estimatr")  
#install.packages("modelsummary")  
#install.packages("kableExtra")  

library(tidyverse)  # ggplot(), %>%, mutate(), and friends
library(broom)  # Convert models to data frames
library(rdrobust)  # For robust nonparametric regression discontinuity
library(estimatr)  # Run 2SLS models in one step with iv_robust()
library(modelsummary)  # Create side-by-side regression tables
library(kableExtra)  # Fancy table formatting
library (readr) #Reading CSV file from Github

# Reading in the data, CSV from Github
urlfile="https://raw.githubusercontent.com/MarkusHagenback/2192-Economic-and-Social-Policy---RDD/main/tutoring_program_fuzzy.csv"

tutoring<-read_csv(url(urlfile))
## --------------------------------------------------------------------
# 1) Create an instrument, which is =true if the entrance exam score is under 70


# 2) Also, create a new centered running variable by subtracting 70 from the running variable


## --------------------------------------------------------------------
# 3) Conduct a Sharp parametric estimation

# a)
model_sans_instrument <- lm(exit_exam ~ entrance_centered + tutoring,
                            data = filter(tutoring_centered,
                                          entrance_centered >= -10 & 
                                            entrance_centered <= 10))
tidy(model_sans_instrument)

# b) Change the bandwidth. 

## --------------------------------------------------------------------
# 4) Conduct a Fuzzy parametric estimation

# a)
model_fuzzy <- iv_robust(
  exit_exam ~ entrance_centered + tutoring | entrance_centered + below_cutoff,
  data = filter(tutoring_centered, 
                entrance_centered >= -10 & 
                  entrance_centered <= 10))
tidy(model_fuzzy)

# b) Change the bandwidth.

## --------------------------------------------------------------------
# 5) Compare the results



## --------------------------------------------------------------------
# 6) Conduct a Non-parametric estimation
# In rdrobust, you do not need to specify an instrument, instead, you need to specify which column that indicates the treatment status
rdrobust(y = , x = , 
         c = 70, fuzzy = "Column with treatment status") %>% 
summary()