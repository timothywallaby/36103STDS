# loading packages
library(dplyr)

# loading data
cars <- mtcars

# explaining pipes
summarise(cars, avg = mean(mpg))

cars %>% 
  summarise(avg = mean(mpg))

# summary

summary(cars)

summarise(cars, across(everything(), min))


# build pipes

cars_base <- cars %>% 
  tibble::rownames_to_column(var = "Make")
  #take your row names and put it into a column!!

cars_1 <- cars_base %>% 
  rename(horse_power = hp) %>% 
          #new name = old name
  mutate(gallons_per_mile = 1/mpg)

View(cars_1)




# example
    # group_by is usually followed by summarise

summary_cyl <- cars_1 %>% 
  group_by(cyl) %>% 
  summarise(cylinder_count = n_distinct(cyl),
            trans_count = n()) %>% 
  arrange(desc(trans_count))






# joining tables

combined_f <- left_join(cars_1, summary_cyl)

combined_f

?n()
?count()



summary_cars <- cars_base %>% 
  summarise(min = min(cyl))

summary_cars

?summarise()

vignette('dplyr')

dim(starwars)
View(starwars)
