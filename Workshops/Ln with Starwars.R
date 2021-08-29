# Load packages ----

library(tidyverse)
library(magrittr)
library(dplyr)

# load data
starwars

newStarwars <- starwars %>% 
  mutate(BMI:=mass/((height/100)^2))

# create linear model
model <- lm(BMI~height + mass, data =filter(newStarwars,BMI<440))


# review linear model
coef(model)

summary(model)

plot(model)




# look at height model:

heightmodel <- lm(BMI~height, data=filter(newStarwars,BMI<440))

summary(heightmodel)

plot(heightmodel)



# look at mass model

massmodel <-lm(BMI~mass, data=filter(newStarwars, BMI<440))

summary(massmodel)

plot(massmodel)




# make predictions
predict(model, newdata=data.frame(mass=35, height=60))
