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
