# load packages ----

library(tidyverse)
library(magrittr)
library(plotly) #3D modeling
library(regclass) #look at what is going on with dataset
library(Boruta) #for determining variable importance

# load data ----
gpaData<- read_delim("http://onlinestatbook.com/2/case_studies/data/sat.txt", delim =" ") 

m1m1 <- lm(univ_GPA ~ high_GPA + math_SAT + verb_SAT, data=gpaData)
  #cannot pipe gpaData into this. Must use data=df

#display coefficients of the variables along with other statistics
summary(m1m1)

#use SAT data to try alternate model for improvement
mlm2 <- lm(univ_GPA ~ verb_SAT + math_SAT, data = gpaData)

#display coefficients of mlm2
summary(mlm2)

#take the coefficients out of mlm2 with coef()
coef.mlr <- coef(mlm2)

#calculate z based on a grid of x and y values (z ~ x + y)
x1.seq <- seq(min(gpaData$verb_SAT), max(gpaData$verb_SAT), length.out =25)
x2.seq <- seq(min(gpaData$math_SAT), max(gpaData$math_SAT), length.out = 25)
z <- t(outer(x1.seq, x2.seq, function(x,y) coef.mlr[1] + coef.mlr[2] * x + coef.mlr[3] * y))
  
?outer() #outer(X, Y, FUN = "*")= make outer product of array X and Y using a specific function
  # where z = function of coef.mlr[1], the intercept, + coef.mlr[2]*x + coef.mlr[3]*y
?t() #t is transposed into a matrix


plot_ly(x = ~x1.seq, y = ~x2.seq, z = ~z, 
        colors = c("#f5cb11", "#b31d83"), type = "surface") %>%
  add_trace(data = gpaData, x = gpaData$verb_SAT, y = gpaData$math_SAT, z = gpaData$univ_GPA, mode = "markers", type = "scatter3d",
            marker = list(opacity = 0.7, symbol = 105)) %>%
  layout(scene = list(
    aspectmode = "manual", aspectratio = list(x = 1, y = 1, z = 1),
    xaxis = list(title = "verb_SAT"),
    yaxis = list(title = "math_SAT"),
    zaxis = list(title = "univ_GPA")))

#add_trace adds the coordinates if you hover over a unit
# not sure what ~ does


# correlation measure?
cor(gpaData$comp_GPA, gpaData$univ_GPA)

  #correlation of computer science gpa with university gpa

mlm3 <- lm(univ_GPA ~ high_GPA + comp_GPA, data = gpaData)
summary(mlm3)
  #88.52% of variance explained (in multiple R-squared)

#the . represents all. so this is a linear regression using all variables
mlm4 <- lm(univ_GPA~., data = gpaData)
summary(mlm4)


# collinearity:
# One good way to identify collinearity among explanatory variables is to use 
# variance inflation factors (VIF)
# 1 is good, higher number bad

# observe collinearity on the linear model mlm4 (all variables)
VIF(mlm4)
  #tells us how much our sample size needs to increase to remove collinearity

#Boruta algorithm can tell us what variable contributes to explain variance most
boruta_output <- Boruta(univ_GPA ~ ., data = na.omit(gpaData), doTrace = 2)

boruta_signif <- names(boruta_output$finalDecision[boruta_output$finalDecision %in% c("Confirmed", "Tentative")])  # collect Confirmed and Tentative variables
print(boruta_signif)  # significant variables
plot(boruta_output, cex.axis = .7, las = 2, xlab = "", main = "Variable Importance")  # plot variable importance

boruta_output
  # tells if any are deemed unimportant
?Boruta
#finalDecision	a factor of three value: Confirmed, Rejected or Tentative, containing final result of feature selection.
#ImpHistory	a data frame of importances of attributes gathered in each importance source run. Beside predictors' importances, it contains maximal, mean and minimal importance of shadow attributes in each run. Rejected attributes get -Inf importance. Set to NULL if holdHistory was given FALSE.

#high VIM and VIF are suggesting that the better performance of the model is because the explanatory variable is too closely associated with what we were trying to predict.

#observe residuals of mlm1
plot(m1m1)