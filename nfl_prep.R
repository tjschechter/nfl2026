## script for data pulling, preparation and initial exploration

## script for setting up Kaggle API for scraping data

## install dev tools from CRAN (comment out after first use)
# install.packages(c("devtools"))

## install necessary packages
install.packages("pacman")

## package manager
library(pacman)
## use package manager (pacman) to install, load all packages needed for this script
## tidyverse (readr, magrittr, ggplot2, dplyr, etc), data.table (fast data manipulation)
p_load(tidyverse,data.table)

## read in data as data.table format (faster than tidyverse
