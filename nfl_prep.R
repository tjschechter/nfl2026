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