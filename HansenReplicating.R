## hansen.R --------------------------------------------------------------------
## Source: Kyle Butts, CU Boulder Economics
## Modified and extended by Markus Hagenbäck, WU
##
--------------------------------------------------------------------
# Part I - Set-up
--------------------------------------------------------------------
## 1a) Install the packages if you do not have them already installed

#install.packages("fixest")
#install.packages("ggplot2")
#install.packages("rdrobust")
#install.packages("rddensity")
#install.packages("binsreg")

library(fixest)
library(ggplot2)
library(rdrobust)
library(rddensity)
library(binsreg)

# Load the data from github
df <- haven::read_dta("https://github.com/scunning1975/causal-inference-class/raw/master/hansen_dwi.dta")
## --------------------------------------------------------------------
## 1b) Run the summary() on your data



## --------------------------------------------------------------------
## 1c) Creating a treatment variable

# Run the code below:
# Creating dui treatment variable for bac1>=0.08
df$dui = (df$bac1 >= 0.08)

# Re-center our running variable at bac1=0.08
df$bac1_orig = df$bac1
df$bac1 = df$bac1 - 0.08

# Explore the data after creating the treatment variable, and make sure your 
# treatment variable is valid, i.e. equals 1 if the BAC-level is above the legal limit.



## --------------------------------------------------------------------
# Part II - Controlling for possible manipulation of the running variable
## --------------------------------------------------------------------

## Template code for histogram ---
ggplot(data = "Your data here", aes(x = "Your x-variable here")) +
  geom_histogram(binwidth = 0.001 ,color = "steelblue", alpha = 0.7) +
  geom_vline(xintercept = "your value here", linetype = "dashed", color = "red", size = 1) +
  labs(
    x = "Values",
    y = "Frequency",
    title = "Histogram Example"
  ) +
  theme_bw()
## --- --- --- --- --- --- --- ---

#2) Construct a histogram, with frequency on the y-axis and BAC-level on the x-axis


## --------------------------------------------------------------------
## Part III - Controlling for possible manipulation of the data around the cutoff
## --------------------------------------------------------------------

## Template code for RD regressions using a local-linear estimator
feols(
  c("dependent variable 1", "dependent variable 2", ...) ~ "Independent variable 1" + ... , 
  df[df$bac1_orig >= "lower limit value" & df$bac1_orig <= "upper limit value", ], vcov = "hc1"
) |> 
  etable()
## --- --- --- --- --- --- --- ---

#3) Run RD regressions using a local-linear estimator on white, male, age (aged) and accident (acc) as dependent variables (equation 1)




## --------------------------------------------------------------------
## Part IV - Test of robustness using a more narrow bandwidth
## --------------------------------------------------------------------

#4) Run RD regressions using a local-linear estimator on white, male, age (aged) and accident (acc) as dependent variables (equation 1)
# Employ a more narrow bandwidth than in 3).


## --------------------------------------------------------------------
## Part V - Main results
## --------------------------------------------------------------------

## Template code --- --- --- ---
#Do not change the "c = 0", it is correct
summary(rdrobust(y =, x = , c = 0))

## ---
#Do not change the "c = 0", it is correct
rdplot(
  y = , x = , c = 0,
  binselect = "esmv"
  ,x.label = "", y.label = "")
# A lot of options for binselect, esmv being the default

# Remember, you can use ?rdplot() 
## --- --- --- --- --- --- --- ---

# 5) Estimating the effect of getting a DUI on recidivism 


# 5a) RD plot with default settings


# 5b) RD Plot Using 40 Bins of Equal Length, using esmv


# 5c) IMSE RD Plot with Evenly-Spaced Bins

