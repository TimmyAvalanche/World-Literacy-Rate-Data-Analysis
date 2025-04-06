
# 📊 Education Data Analysis Script (R)

# Load Required Libraries
install.packages("openxlsx")    # For reading Excel files
install.packages("mice")        # For multiple imputation
install.packages("dplyr")       # For data manipulation

library(openxlsx)
library(mice)
library(dplyr)

# Load Dataset
file_path <- "C:/Users/hp/Downloads/world-education-data.xlsx"
education_data <- read.xlsx(file_path, sheet = "world-education-data")

# View structure
str(education_data)

# Replace zeros in numeric columns with NA
education_data <- education_data %>%
  mutate(across(where(is.numeric), ~na_if(., 0)))

# Impute missing values using Predictive Mean Matching (PMM)
imputed_data <- mice(education_data, method = 'pmm', m = 5)

# Extract the first completed dataset
completed_data <- complete(imputed_data, 1)

# Save Imputed Data to Excel
write.xlsx(completed_data, "completed_education_data.xlsx")

#Repeat same process for "Gender-gap-education-levels"