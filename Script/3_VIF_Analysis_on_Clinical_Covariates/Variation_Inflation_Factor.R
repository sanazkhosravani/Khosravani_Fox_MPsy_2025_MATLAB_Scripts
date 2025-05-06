# Install and load required packages
install.packages("readxl")   # For reading Excel files
install.packages("car")      # For variance inflation factor (VIF) calculation and other regression tools

# Load libraries
library(readxl)  # For reading Excel files
library(car)     # For regression diagnostics including VIF

# Read the data from Excel file
# Replace "Path_to_your_data.xls" with your actual file path
data <- read_excel("Path_to_your_data.xls")

# Define categorical columns explicitly
# Replace with your actual categorical column names (e.g., hospital site (0,1), history of ECT (0,1), etc)
categorical_columns <- c(
  "categorical_predictor1",
  "categorical_predictor2"
  # Add more categorical columns as needed
)

# Convert categorical columns to factors
data[categorical_columns] <- lapply(data[categorical_columns], as.factor)

# Fit a linear regression model with all predictors included
# Replace with actual predictor names and response variable (y)
model <- lm(y ~ predictor1 + predictor2 + 
            categorical_predictor1 + categorical_predictor2 + 
            ...,  # Replace ... with additional predictors
            data = data)

# Calculate Variance Inflation Factors (VIF) to check for multicollinearity
# VIF > 5 suggests potential multicollinearity issues
# VIF > 10 indicates serious multicollinearity
vif_values <- car::vif(model)
print(vif_values)