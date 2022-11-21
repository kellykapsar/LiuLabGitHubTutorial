################################################################################
# TITLE: Tips and tricks for project organization using RStudio and GitHub
# PURPOSE: The purpose of this script is to demonstrate one way to organize projects
# involving lots of data and multiple steps so that they are as reproducible as 
# possible. 
# AUTHOR: Kelly Kapsar
# CREATED: 2022-11-20
# LAST UPDATED: 2022-11-20
################################################################################

# Load Libraries 
library(dplyr)
library(tidyr)

# Load in toy data the come pre-installed with R
data(mtcars)

# Save to the raw data folder 
write.csv(mtcars, "../Data_Raw/cardata.csv")

# Remove toy data object
rm(mtcars)

# Read in csv you just saved 
cars <- read.csv("../Data_Raw/cardata.csv")

# Count number of car types by cylinder
cyls <- cars %>% group_by(cyl) %>% summarize(numcars=n())

# Generate directory for intermediate data 
dirname <- paste0("../Data_Processed/Prelim_Results_", Sys.Date())

if (!file.exists(dirname)){
  dir.create(dirname)
}

# Save intermediate data 
write.csv(cys, paste0(dirname,"/carcyls.csv"))

# Iteratively name figures within a loop using the paste0 function
for(i in 1:length(unique(cars$cyl))){
  temp <- cars %>% filter(cyl == unique(cars$cyl)[i])
  write.csv(temp, paste0(dirname, "/cars_",unique(cars$cyl)[i],"cyls.csv"))
}



