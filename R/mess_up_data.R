library(dplyr)
library(tidyr)
library(readr)

# Download the data if it hasn't been downloaded so far
source("R/setup.R")

# Read in the original data
species_data <- read_csv("data/species.csv")
survey_data <- read_csv("data/surveys.csv")  
plots_data <- read_csv("data/plots.csv")

# Following the example from Garrett Grolemund's, we need 3 different types of
# data:
# 1. Wide table
# 2. Pivot table
# 3. Long table
# 
# survey_data is already wide. Let's create a pivot table of observations per
# year:

pivot_survey_data <- survey_data %>%
  select(species_id, year) %>% 
  filter(species_id != "") %>% 
  group_by(species_id, year) %>% 
  summarize(
    count = n()
  ) %>% 
  spread(year, count)

# Write the created pivot table
  write_csv(pivot_survey_data, "data/pivot_survey_data.csv")

# Task: pivot to wide
wide_survey_data <- pivot_survey_data %>% 
  gather(year, count, -species_id) %>% 
  arrange(species_id, year)

# Next, let's create a long table for a single species (DM, Dipodomys merriami)
# that has the largest amount of observations
dm_long_data <- survey_data %>% 
  filter(species_id == "DM" & plot_id == 1 & sex != "") %>% 
  mutate(date = paste0(year, "-", month, "-", day)) %>% 
  group_by(time, sex) %>% 
  sample_n(1, replace=FALSE) %>% 
  ungroup() %>% 
  select(time, sex, hindfoot_length) %>% 
  arrange(time, sex)

# Write the created pivot table
write_csv(dm_long_data, "data/dm_long_data.csv")

# Task: long to wide
dm_wide_data <- dm_long_data %>% 
  spread(sex, hindfoot_length)

messy_survey_data <- survey_data %>% 
  filter(species_id != "" & sex != "") %>% 
  mutate(date = paste0(year, "-", month, "-", day)) %>%
  gather(variable, measurement, -record_id, -month, -day, -year, -plot_id, 
         -species_id, -sex, -date) %>% 
  select(record_id, species_id, date, sex, variable, measurement) %>% 
  arrange(record_id, species_id, date, sex, variable)

# Write the created pivot table
write_csv(messy_survey_data, "data/messy_survey_data.csv")

  # Task: make mesurements independent variables
tidy_survey_data <- messy_survey_data %>% 
  spread(variable, measurement)
