# Data Tramsformation

# 1. Load packages and data
library(nycflights13)
library(tidyverse)

# 2. Explore Data
flights
View(flights)

# 3. dplyr functions
# filter() - pick observations by value
# arrange() - reorder rows
# select() - pick variable by name
# mutate() - create new variables using old ones
# summarize() - collapse many values into a single summary

# args: 1. data frame, 2. what to do to data frame 3. variable names

# 4. filter() ----
# example: select all flights on January 1st

filter(flights, month == 1, day == 1)

# 5. comparisons ----
# do not use == for precision arithmetic
# instead use near()

near(1/49 * 49, 1)

# 6. logical operators ----
# & for and; | for or; ! for not
# examples, flights departing in november or december

filter(flights, month == 11 | month == 12)

  #another way to write this is using %in%

filter(flights, month %in% c(11, 12))

  #select every row where x is in one of the values in y
  # x = month, y = [11, 12]

# 7. NA's
# to determine if a value is missing, use is.na()

is.na()

  # filter() only includes rows that are TRUE
  # it excludes NA values.

  # to include NAs..
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)


# arrange() ----
# works similarly to filter() but reorders your data by a column type
# arranges by ascending by default, use desc(column) to change
arrange(flights, desc(dep_delay))
  #missing values are always at the end
  #add more variables as tiebreaks






# select() ----
#selects the variables (columns)
select(flights, year:day)
  #selects flights, then selects all columns between year and day, inclusive
  # use -(year:day) to exclude all those columns





# mutate() ----
# creates new variables out of your existing
mutate(data, newvar = x + y)

transmute(data, newvar = x + y)  #will only keep new variable


  #tips:, %/% is integer division, %% is modulus (remainder)

