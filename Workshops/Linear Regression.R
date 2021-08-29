# load packages ----

library(tidyverse)
library(magrittr)

# load data ----
gpaData<- read_delim("http://onlinestatbook.com/2/case_studies/data/sat.txt", delim =" ") 

# EDA ----
gpaData

gpaData %>% 
  ggplot(aes(x=high_GPA, y=univ_GPA)) +
  geom_point()

### find out how correlated uni and high school gpas are:

cor(gpaData$high_GPA, gpaData$univ_GPA)









# Build a Linear model ----

slm <- lm(univ_GPA ~ high_GPA, data=gpaData)
  #fit the a linear model and assign it to slm

coef(slm)
  #tells you slope and intercept

# plot your linear model:

gpaData %>% 
  ggplot(aes(x=high_GPA, y=univ_GPA)) +
  geom_point() +
  geom_smooth(method="lm")
    #you need to use method lm or else it will use a fitted curve

    #you can use geom_abline if you need to do something sneaky

# learn how good the fit is:
summary(slm)

# residual analysis:
plot(slm)

  # note: labeled points on the residuals are clues to look at

gpaData %>% 
  slice(91)






# Assess its accuracy ----

# Residual Standard Error (almost Residual Sum of Squares)

summary(slm)$sigma
  #take out sigma value from the table made by summary

  #simga = residual standard error

  #RSE measures lack of fit of model to data

  #RSE gives an estimation of the error in our fit
  #the standard deviation


summary(slm)$r.squared
  #takes the R squared value from summary

  #R^2 shows the proportion of the variance explained by the model
  #always 0-1

# Assess relationships between variables ----

summary(slm)$coefficients





# Make predictions using the linear model ----

predict(slm, newdata=data.frame(high_GPA = c(3.89, 4.8, 1.9)))

predict(slm, newdata=data.frame(high_GPA = c(3.89, 4.8, 1.9)), interval = "confidence")
  #specify interval to give you confidence interval








# more EDA ----

pairs(gpaData)

library(corrplot)

corrplot(cor(gpaData), method="number")
corrplot(cor(gpaData), method="ellipse")








# Factor Analysis ----

# figure out which variables are redundant. some may have high correlation
# and contributes to model the same. called collinearity

library(psych)

threefactor <- fa(gpaData, nfactors=3, rotate='oblimin', fm='minres')


print(threefactor)

print(threefactor$loadings, cutoff=0.3)





