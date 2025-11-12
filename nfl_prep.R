## script for data pulling, preparation and initial exploration

## script for setting up Kaggle API for scraping data

## install dev tools from CRAN
install.packages(c("devtools"))


## install dev version of kaggler from CRAN
## install kaggler package from github
devtools::install_github("koderkow/kaggler")

## install necessary packages
install.packages("pacman")

## package manager
library(pacman)
## use package manager (pacman) to install, load all packages needed for this script
p_load("tidyverse")

