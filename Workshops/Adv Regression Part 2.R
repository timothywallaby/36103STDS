# Load your packages
library(tidyverse)
library(magrittr)
library(here)
library(Amelia)
library(dplyr)
library(AER)

# Load data

cancerData <- read_delim("http://data.princeton.edu/wws509/datasets/smoking.raw",  delim = "\t", col_names = c("age", "smoke", "pop", "dead"))

head(cancerData)

cancerData %>% mutate(age=as.factor(age), smoke=as.factor(smoke))

ggplot(data=cancerData) + geom_bar(aes(x=age, y=pop, fill=smoke),stat='identity')

ggplot(data = cancerData) + geom_bar(aes(x = age, y = dead, fill = smoke), stat = "identity") 



# fit a linear model (why wouldn't you usea linear model?)

lm.cancer <- lm(dead ~ age + smoke, data = cancerData)
summary(lm.cancer)

plot(lm.cancer)

  #the amount of people dead.. is that a count? should you use poisson?

  #dead... or not dead. That is the question.

  # so then would you use a binomial?



# the answer is quasipoisson!!!

glmqpo.cancer <- glm(dead ~ age + smoke + offset(log(pop)), data = cancerData, family = quasipoisson(link = "log"))
summary(glmqpo.cancer)

predicted <- predict(glmqpo.cancer, type = "response")

ggplot(cancerData)+
  geom_point(aes(x = age, y = dead, color = smoke)) +
  geom_point(aes(x = age, y = predicted, color = smoke), shape =0)
