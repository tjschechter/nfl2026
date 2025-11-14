## script for data pulling, preparation and initial exploration

## script for setting up Kaggle API for scraping data

## install dev tools from CRAN (comment out after first use)
# install.packages(c("devtools"))

## install necessary packages (comment out after install)
# install.packages("pacman")

## package manager
library(pacman)
## use package manager (pacman) to install, load all packages needed for this script
## tidyverse (readr, magrittr, ggplot2, dplyr, etc), data.table (fast data manipulation)
p_load(tidyverse,data.table)

###########################################################


## read in data as data.table format (faster than tidyverse)


## input data for 2023 week1 - BEFORE pass is thrown
data_23_wk1 <- fread("data/train/input_2023_w01.csv")

## Data Descriptions

## several variables to turn into factors or nominal data (categorical)
## Game ID, Play ID, player to predict, nfl id, frame id, play direction,
## player name, height, weight, birth date, position, side, role


## numeric data: 
## absolute_yardline_number; x (0 - 120); y (0 - 53.3); speed (yds/sec); 
## a (acceleration) (yds/sec^2); o (orientation); dir (direction); 
## num_frames_output; ball land x, ball land y

## output data week 1 2023 - AFTER pass is thrown
data_23_wk1_out <- fread("data/train/output_2023_w01.csv")

## Data Descriptions

## factor/nominal/categorical data
## game id; play id; nfl id, frame id

## numeric
## x (0-120) {PREDICT}; y (0-53.3) {PREDICT}

################################################################

## Exploratory Data Analysis of the week 1 data from 2023 season

## what variables can be used to join the data?
## nfl_id = player id number, unique to player
## game_id = unique game identifier
## play_id = play identifier - NOT UNIQUE ACROSS GAMES

## PLAYER TO PREDICT VARIABLE
## boolean, either true or false
## explore with both ONLY TRUE rows and ALL rows




## INPUT Exploration

## How many observations are true for "player_to_predict"?
sum(data_23_wk1$player_to_predict == TRUE)
## 76399 (209315 FALSE)

## convert the necessary data to factors using lapply
data_23_wk1[,c(1:6,8,12:14)] <- lapply(data_23_wk1[,c(1:6,8,12:14)], factor)


## get a peek into the Ns of categorical, and quartiles of numeric vectors
summary(data_23_wk1)

## take a look at the first rows of data
head(data_23_wk1)

## filter down to one player
## say... Justin Jefferson

jjet <- data_23_wk1 %>% filter(player_name == "Justin Jefferson")

## looking through the data, grouping by play (play_id), what is his avg accel? (a)

jjet %>% group_by(play_id) %>%
  summarise("Avg_accel_during_play" = mean(a)) %>%
  print(n = 39)

## Some plays averaging an acceleration of >3 yds/(s^2)!

## create a metric for the difference in where jj is vs the ball at landing

jjet$difference_x <- jjet[,`x` - `ball_land_x`]
jjet$difference_y <- jjet[,`y` - `ball_land_y`]

## calculate total distance from the ball landing spot in yards
jjet$distance <- jjet[,sqrt(((`ball_land_x` - `x`)^2) + ((`ball_land_y` - `y`)^2))]

## create a linear model to estimate the relationship between acceleration, distance from ball
lm_jj <- lm(data = jjet, distance ~ a)

## create a scatter plot displaying the relationship
jjet %>% filter(player_role == "Targeted Receiver") %>% 
  ggplot(aes(x = a, y = distance)) +
  geom_point(aes(color = as.numeric(frame_id))) +
  scale_color_gradient() +
  theme_bw()

## Not much of a linear relationship apparent in data, BUT
## Justin Jefferson seems to always be closer to the ball later in the play AFTER ball is thrown but
## BEFORE it lands. the color gradient displays time in play, the x axis his acceleration, y his distance from
## the ball's landing location

##########################################################

## Next player should be a different position (Tight End? Running back? Defensive Back?)

## Tight End Kyle Pitts

## Copy the code above and repeat it for Kyle Pitts
kpitt <- data_23_wk1 %>% filter(player_name == "Kyle Pitts")

## Less observations of Pitts in routes (1100 for JJ, 271 for KP)

## looking through the data, grouping by play (play_id), what is his avg accel? (a)

kpitt %>% group_by(play_id) %>%
  summarise("Avg_accel_during_play" = mean(a)) %>%
  print(n = 39)

## Some plays averaging an acceleration of >3 yds/(s^2)!

## create a metric for the difference in where jj is vs the ball at landing

kpitt$difference_x <- kpitt[,`x` - `ball_land_x`]
kpitt$difference_y <- kpitt[,`y` - `ball_land_y`]

## calculate total distance from the ball landing spot in yards
kpitt$distance <- kpitt[,sqrt(((`ball_land_x` - `x`)^2) + ((`ball_land_y` - `y`)^2))]

## create a linear model to estimate the relationship between acceleration, distance from ball
lm_kp <- lm(data = kpitt, distance ~ a)

## create a scatter plot displaying the relationship
kpitt %>% filter(player_role == "Targeted Receiver") %>% 
  ggplot(aes(x = a, y = distance)) +
  geom_point(aes(color = as.numeric(frame_id))) +
  scale_color_gradient() +
  theme_bw()

## Less busy as a chart, we can more clearly see how he's performing in relation to his targets
## On his few targets, pitts seems to struggle getting close to the ball as it comes to him
## the top of the graph with light blue gradient shows he's not very close to the ball when he is targeted

####################################

## check the linear models for jefferson, pitts and compare

summary(lm_jj)
summary(lm_kp)

## neither had acceleration as particularly significant in week 1 of 2023