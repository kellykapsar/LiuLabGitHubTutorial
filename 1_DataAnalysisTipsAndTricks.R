################################################################################
# TITLE: Tips and tricks for project organization using RStudio and GitHub
# PURPOSE: The purpose of this script is to demonstrate one way to organize projects
# involving lots of data and multiple steps so that they are as reproducible as 
# possible. 
# AUTHOR: Kelly Kapsar
# CREATED: 2022-11-20
# LAST UPDATED: 2022-11-20
################################################################################

# TIP #1: Have a header for ALL of your R files explaining what they do. See above for example. 

# TIP #2: Number your scripts in the order that the data should move through them. 
## Example: 1_DataCleaning.R, 2_DataAnalysis.R

# TIP #3: Use the same file structure for all projects 

# Load Libraries 
library(dplyr)
library(tidyr)

# TIP #4: Use relative file paths to read in and save data.

# Load in toy data the come pre-installed with R
data(mtcars)

# Save to the raw data folder 
write.csv(mtcars, "../Data_Raw/cardata.csv")
# Remove toy data
rm(mtcars)

# Read in csv you just saved 
cars <- read.csv("../Data_Raw/cardata.csv")

# TIP #5: Always store raw and processed data separately and NEVER touch raw data. 
cyls <- cars %>% group_by(cyl) %>% summarize(numcars=n())
write.csv(cys, "../Data_Processed/carcyls.csv")

# TIP #6: If you are going to be re-running data a lot and want to keep track of different data versions, 
# can put them in new folders for each day that you work on them (or give each figure new names)
dirname <- paste0("../Data_Processed/Prelim_Results_", Sys.Date())

if (!file.exists(dirname)){
  dir.create(dirname)
}

# TIP #7: You can iteratively name figures within a loop using the paste0 function
for(i in 1:length(unique(cars$cyl))){
  temp <- cars %>% filter(cyl == unique(cars$cyl)[i])
  write.csv(temp, paste0("../Data_Processed/cars_",unique(cars$cyl)[i],"cyls.csv"))
}



