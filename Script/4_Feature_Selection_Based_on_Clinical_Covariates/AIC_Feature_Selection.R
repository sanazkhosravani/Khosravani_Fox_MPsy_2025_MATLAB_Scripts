# ========================================================================
# EXHAUSTIVE FEATURE SELECTION USING AIC CRITERION
# Prepared by Sanaz Khosravani, PhD
# Last updated: May 2025
#
# Performs exhaustive search of all possible linear models to identify:
# 1) Optimal predictor combination minimizing Akaike Information Criterion (AIC)
# 2) Best fitting model while penalizing for complexity
#
# Input Requirements:
# - Dataframe with continuous response variable 'y'
# - Mixed continuous/categorical predictors
# - Properly formatted Excel file with header row (example input file provided in the subfolder named as Example_Input_Data.mlx)
#
# Output:
# - best_model: Final selected lm object with lowest AIC
# - best_aic: Corresponding AIC value
# - Full model summary with coefficients and fit statistics
# ========================================================================

# ========================================================================
# STEP 1: DATA LOADING AND PREPROCESSING
# ========================================================================

# Load required package for reading Excel files
library(readxl)

# --- Data Import ---
# Read data from Excel file - Path should use forward slashes for compatibility
data <- read_excel("your_data_file.xlsx")  # Update path to actual data file

# --- Categorical Variable Handling ---
# Specify which columns represent categorical variables
# Critical for proper factor encoding in regression models
categorical_columns <- c(
  "categorical_variable1",  # Example: "gender" (0,1)
  "categorical_variable2"   # Example: "hospital_site" (0,1)
  # Add additional categorical variables as needed
)

# Convert specified columns to factors
data[categorical_columns] <- lapply(data[categorical_columns], as.factor)

# ========================================================================
# STEP 2: MODEL SELECTION UTILITY FUNCTIONS
# ========================================================================

# --- AIC Calculation Wrapper ---
# Computes Akaike Information Criterion for model comparison
# Lower AIC indicates better model balancing fit and complexity
compute_aic <- function(model) {
  AIC(model)  # Uses stats::AIC() with default k=2 parameter
}

# --- Predictor Selection Helper ---
# Checks if specific predictor exists in current model
is_predictor_chosen <- function(predictors, predictor) {
  predictor %in% predictors  # Returns TRUE if predictor is in current set
}

# ========================================================================
# STEP 3: MODEL SELECTION INITIALIZATION
# ========================================================================

# --- Optimization Tracking Variables ---
best_aic <- Inf          # Initialize with worst possible value
best_model <- NULL       # Will store final selected model object

# --- Predictor Setup ---
# Identify all potential predictors (all columns except response 'y')
# Important: Ensure 'y' matches your actual response variable name
predictor_names <- setdiff(names(data), "y")

# ========================================================================
# STEP 4: EXHAUSTIVE MODEL SEARCH
# ========================================================================

# --- Outer Loop: Model Size Iteration ---
# Tests all possible model sizes from 1 to total predictors
for (i in 1:length(predictor_names)) {
  
  # Generate all unique predictor combinations of size i
  # combn() generates non-repeating combinations
  predictors_combinations <- combn(predictor_names, i, simplify = FALSE)
  
  # --- Inner Loop: Combination Evaluation ---
  for (predictors in predictors_combinations) {
    
    # Construct model formula
    # paste() converts predictor vector to formula syntax
    predictors_formula <- paste("y ~", paste(predictors, collapse = " + "))
    
    # Fit linear model with current predictors
    current_model <- lm(as.formula(predictors_formula), data = data)
    
    # Calculate model AIC
    current_aic <- compute_aic(current_model)
    
    # --- Model Selection Update ---
    if (current_aic < best_aic) {
      best_aic <- current_aic
      best_model <- current_model
      
    }
  }
}

# ========================================================================
# STEP 5: RESULTS AND DIAGNOSTICS
# ========================================================================

# --- Comprehensive Model Summary ---
print(summary(best_model))
