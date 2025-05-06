# ========================================================================
# EXHAUSTIVE MODEL SELECTION USING ADJUSTED R-SQUARED CRITERION
# Prepared by Sanaz Khosravani, PhD
# Last updated: May 2025
#
# Performs exhaustive search of all possible linear models to identify:
# 1) Optimal predictor combination maximizing adjusted R-squared
# 2) Best fitting model while accounting for number of predictors
#
# Input Requirements:
# - Dataframe with continuous response variable 'y'
# - Mixed continuous/categorical predictors
# - Properly formatted Excel file with header row
#
# Output:
# - best_model: Final selected lm object with highest adjusted R-squared
# - best_adj_r_squared: Corresponding metric value
# - Full model summary with coefficients and fit statistics
# ========================================================================

# Load required package for reading Excel files
# Note: readxl handles both .xls and .xlsx formats across platforms
library(readxl)

# ========================================================================
# STEP 1: DATA IMPORT AND PREPROCESSING
# ========================================================================

# --- Data Import ---
# Read the data from Excel file 
# Requirements:
# - First row must contain variable names
# - Missing values should be properly encoded (NA or blanks)
# - File path should use either:
#   - Forward slashes (/) for cross-platform compatibility
#   - Double backslashes (\\) for Windows paths
data <- read_excel("your_data_file.xls")  # Replace with actual file path

# ========================================================================
# STEP 2: CATEGORICAL VARIABLE HANDLING
# ========================================================================

# --- Categorical Variable Specification ---
# List all columns containing categorical variables
# These will be converted to factors for proper dummy coding in regression
categorical_columns <- c(
  "categorical_variable1",  # Example: "gender" (0,1)
  "categorical_variable2"   # Example: "hospital_site" (0,1)
  # Add additional categorical variables as needed
)

# --- Factor Conversion ---
# Convert specified columns to factor type
# Critical for:
# - Proper handling of categorical variables in lm()
# - Correct calculation of degrees of freedom
data[categorical_columns] <- lapply(data[categorical_columns], as.factor)

# ========================================================================
# STEP 3: MODEL SELECTION FRAMEWORK
# ========================================================================

# --- Model Evaluation Metric ---
# Computes adjusted R-squared from lm model object
# Adjusted R-squared is preferred because it:
# 1) Penalizes model complexity
# 2) Prevents overfitting
# 3) Allows comparison across models with different predictor counts
compute_adj_r_squared <- function(model) {
  summary(model)$adj.r.squared  # Extract from model summary object
}

# --- Optimization Tracking Variables ---
best_adj_r_squared <- -Inf  # Initialize with worst possible value
best_model <- NULL          # Will store final selected model

# --- Predictor Setup ---
# Identify all potential predictors (all columns except response 'y')
# Note: Ensure 'y' matches your actual response variable name
predictor_names <- setdiff(names(data), "y")

# ========================================================================
# STEP 4: EXHAUSTIVE MODEL SEARCH ALGORITHM
# ========================================================================

# --- Outer Loop: Model Size Iteration ---
# Tests all possible model sizes from 1 to maximum predictors
for (i in 1:length(predictor_names)) {
  
  # Generate all unique predictor combinations of size i
  # combn() generates non-repeating combinations (n choose i)
  predictors_combinations <- combn(predictor_names, i, simplify = FALSE)
  
  # --- Inner Loop: Combination Evaluation ---
  for (predictors in predictors_combinations) {
    
    # Construct model formula
    # Converts predictor vector to formula syntax (e.g., "y ~ x1 + x2")
    predictors_formula <- paste("y ~", paste(predictors, collapse = " + "))
    
    # Fit linear model with current predictors
    current_model <- lm(as.formula(predictors_formula), data = data)
    
    # Calculate model's adjusted R-squared
    current_adj_r_squared <- compute_adj_r_squared(current_model)
    
    # --- Model Selection Update ---
    if (current_adj_r_squared > best_adj_r_squared) {
      best_adj_r_squared <- current_adj_r_squared
      best_model <- current_model
      
      # Optional progress tracking (uncomment if needed)
      # cat("New best model with", i, "predictors. Adj R2 =", 
      #     round(current_adj_r_squared, 4), "\n")
    }
  }
}

# ========================================================================
# STEP 5: RESULTS AND MODEL DIAGNOSTICS
# ========================================================================

# --- Comprehensive Model Summary ---
# Displays:
# - Coefficient estimates and statistical significance
# - Residual standard error
# - R-squared and adjusted R-squared
# - F-statistic for overall model significance
print(summary(best_model))
