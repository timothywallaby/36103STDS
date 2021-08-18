### Chapter 3 of R4DS

# 1. Load your packages ----
library(tidyverse)

# 2. Load your data ----
mpg

# 3. Plot Data/EDA ----
mpg %>% 
  ggplot() +
  geom_point(aes(x=displ, y=hwy))

mpg %>% 
  ggplot(aes(x=cyl, y=hwy)) +
  geom_point()

mpg %>% 
  ggplot(aes(x=drv, y=class)) +
  geom_point()

# 4. Aesthetics ----
mpg %>% 
  ggplot(aes(x=displ, y=hwy, color=class)) +
  geom_point()

# 4a. class aesthetic
mpg %>% 
  ggplot(aes(x=displ, y=hwy, size=class)) +
  geom_point()

# 4b. alpha aesthetic
mpg %>% 
  ggplot(aes(x=displ, y=hwy, alpha=class)) +
  geom_point()

# 4c. shape aesthetic
mpg %>% 
  ggplot(aes(x=displ, y=hwy, shape=class)) +
  geom_point()
  # note. ggplot can only use 6 shapes at a time

# 5. Global aesthetics ----
mpg %>% 
  ggplot(aes(x=displ, y=hwy)) +
  geom_point(color="red", shape=4)
  # note. set the argument inside your geom function rather than with the
  # aesthetics

  # R has 25 different built-in shapes


# 6. Facet Wrapping ----
mpg %>% 
  ggplot(aes(x=displ, y=hwy, color=class)) +
  geom_point() +
  facet_wrap(~class, nrow=2)

# if you are trying to facet on a combination of variables:
mpg %>% 
  ggplot(aes(x=displ, y=hwy, color=class)) +
  geom_point() +
  facet_grid(drv~cyl)
  # note, this breaks them up by drive train on y axis
  # and number of cyl on x axis

# 7. Using other geoms like smooth
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = TRUE
  )

# 8. Display multiple geoms
mpg %>% 
  ggplot(aes(x=displ, y=hwy)) +
  geom_point() +
  geom_smooth()

# Use local mappings for each type of geom layer
mpg %>% 
  ggplot(aes(x=displ, y=hwy)) +
  geom_point(aes(color=class)) +
  geom_smooth()

mpg %>% 
  ggplot(aes(x=displ, y=hwy)) +
  geom_point(aes(color=class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se=FALSE)
  #note you can use filter on the geom to override the global data argument

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)


# 9 Adding Jitter

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_jitter() + 
  geom_smooth(se = FALSE)
  #geom_jitter() = geom_point(position="jitter")

  # other positions include 'dodge, fill, identity, stack'

