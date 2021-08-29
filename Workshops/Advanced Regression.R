# Load your packages
library(tidyverse)
library(magrittr)
library(here)
library(Amelia)
library(dplyr)
library(AER)

# Load your data
titanicData <- read_csv("https://biostat.app.vumc.org/wiki/pub/Main/DataSets/titanic3.csv")
titanicData$id <- 1:nrow(titanicData)

titanic.train <- titanicData %>% dplyr::sample_frac(0.75)
titanic.test <- dplyr::anti_join(titanicData, titanic.train, by='id')

missmap(titanic.train, main="Missing Values vs Observed")

# Set our outcome variable to be survivors. Then make a generalized linear model
glm1 = glm(survived~pclass + sex, family=binomial(logit),
           data=titanic.train)

summary(glm1)




# Validate with our test data

pred  <- predict(glm1, newdata = titanic.test)
head(pred)

prob <- 1/(1+exp(-pred))
head(prob)

probability <- predict(glm1, newdata = titanic.test, type='response')
head(probability)
  #gives the same without having to explicitly call the function


# Predict probability of survival that a male in 3rd class survived sinking

(probM3 <- predict(glm1, newdata = data.frame(sex='male', pclass=3), type='response'))

probability




# Confusion matrices, comparing predicted to actual

prediction <- ifelse(probability > 0.5, 1, 0)
confusion <- table(titanic.test$survived, prediction)

View(titanic.test)
confusion

#true positive
#false positive
#precision
#recall
#accuracy

####### Using a different logistic model ----

glm2 = glm(survived ~  pclass * sex + age, family = binomial(logit), data = titanic.train)
summary(glm2)



gpaData <- read_delim("http://onlinestatbook.com/2/case_studies/data/sat.txt", delim = " ")
mlm1 <- lm(univ_GPA ~high_GPA + math_SAT + verb_SAT, data = gpaData)
summary(mlm1)
  #this is the original way we learned how to do linear regressions

glm1 <- glm(univ_GPA ~ high_GPA + math_SAT + verb_SAT, data = gpaData, family = gaussian(link = "identity"))
summary(glm1)

# How to determine how fast the regression runs
system.time(lm(univ_GPA ~ high_GPA + math_SAT + verb_SAT, data = gpaData))
system.time(glm(univ_GPA ~ high_GPA + math_SAT + verb_SAT, data = gpaData, family = gaussian(link = "identity")))

  #glm runs faster for me lol





##### Counting Data ----
# Poisson is used to describe events where you may want to count in discrete increments

awardData <- read_csv("https://stats.idre.ucla.edu/stat/data/poisson_sim.csv")
glimpse(awardData)

awardData %<>% mutate(id = as.factor(id), prog = as.factor(prog))
  #change id and prog into categorical variables
glimpse(awardData)

ggplot(awardData) + geom_bar(aes(x=num_awards))

summary(awardData)

var(awardData$num_awards)

glm.awards <- glm(num_awards ~ prog+math, awardData, family=poisson)
summary(glm.awards)

predict(glm.awards, newdata = data.frame(prog = factor(2), math = 54), type="response")





##### Overdispersion ----

dispersiontest(glm.awards)
  # A dispersion of 0 is the ideal, but we are not too far away. So our data is a bit messy, but we are probably sitting ok









