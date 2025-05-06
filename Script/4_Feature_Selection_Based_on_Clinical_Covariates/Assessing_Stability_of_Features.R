# ========================================================================
# ROBUST PREDICTOR SELECTION VIA SUBSAMPLING, AND AIC OPTIMIZATION
# Prepared by Sanaz Khosravani, PhD
# Last updated: May 2025
#
# Performs repeated subsampling to identify the most robust predictors by:
# 1) Conducting exhaustive model searches on multiple subsamples
# 2) Tracking predictor selection frequencies across iterations
# 3) Identifying consistently important predictors via AIC minimization
#
# Input Requirements:
# - Dataframe with continuous response variable 'BDI_change'
# - Mixed continuous/categorical predictors
# - Properly formatted Excel file with header row (example input file provided in the subfolder named as Example_Input_Data.mlx)
#
# Output:
# - predictor_selection_count: Named vector of selection frequencies
# - Sorted output of most-to-least frequently selected predictors
# ========================================================================

# ========================================================================
# STEP 1: PACKAGE LOADING
# ========================================================================

# Load required package for reading Excel files
library(readxl)

# ========================================================================
# STEP 2: DATA LOADING AND PREPROCESSING
# ========================================================================

# --- Data Import ---
# Read dataset from Excel file 
data <- read_excel("Path_to_your_data.xlsx")  # Replace with actual path

# --- Categorical Variable Handling ---
# Specify columns requiring factor conversion
categorical_columns <- c(
  "categorical_predictor1",  # Example: "gender" (0,1)
  "categorical_predictor2"   # Example: "hospital site" (0,1)
  # Add additional categorical variables as needed
)

# Convert specified columns to factor type
data[categorical_columns] <- lapply(data[categorical_columns], as.factor)

# ========================================================================
# STEP 3: CORE ANALYTIC FUNCTIONS
# ========================================================================

# --- AIC Calculation Function ---
# Computes Akaike Information Criterion for model comparison
compute_aic <- function(model) {
  AIC(model)  # Uses stats::AIC() with default k=2 parameter
}

# ========================================================================
# STEP 4: ANALYSIS PARAMETER INITIALIZATION
# ========================================================================

# --- Predictor Setup ---
# Identify all potential predictors (all columns except response)
predictor_names <- setdiff(names(data), "BDI_change")

# --- Selection Tracking ---
# Initialize named vector to count predictor selections
predictor_selection_count <- setNames(
  rep(0, length(predictor_names)), 
  predictor_names
)

# --- Subsampling Parameters ---
set.seed(123)       # Ensures reproducibility of random sampling
n_iterations <- 500 # Total subsampling iterations (recommended: 500-1000)
subsample_size <- floor(0.8 * nrow(data))  # 80% training samples

# ========================================================================
# STEP 5: SUBSAMPLING ANALYSIS LOOP
# ========================================================================

cat("Beginning subsampling analysis...\n")

# Main analysis loop
for (b in 1:n_iterations) {
  
  # --- Progress Reporting ---
  if (b %% 50 == 0) cat("Completed", b, "iterations...\n")
  
  # --- Subsampling ---
  # Create training subsample (80% of data without replacement)
  subsample_indices <- sample(1:nrow(data), subsample_size, replace = FALSE)
  train_data <- data[subsample_indices, ]
  
  # --- Per-Iteration Tracking ---
  current_best_aic <- Inf      # Initialize with worst possible AIC
  current_best_predictors <- NULL  # Will store optimal predictors
  
  # --- Exhaustive Model Search ---
  for (i in 1:length(predictor_names)) {
    
    # Generate all unique predictor combinations of size i
    predictors_combinations <- combn(predictor_names, i, simplify = FALSE)
    
    # Evaluate each combination
    for (predictors in predictors_combinations) {
      
      # Model specification
      model_formula <- paste("BDI_change ~", paste(predictors, collapse = " + "))
      
      # Model fitting
      current_model <- lm(as.formula(model_formula), data = train_data)
      
      # Model evaluation
      current_aic <- compute_aic(current_model)
      
      # Update best model if improved
      if (current_aic < current_best_aic) {
        current_best_aic <- current_aic
        current_best_predictors <- predictors
      }
    }
  }
  
  # --- Update Global Counts ---
  for (predictor in current_best_predictors) {
    predictor_selection_count[predictor] <- predictor_selection_count[predictor] + 1
  }
}

# ========================================================================
# STEP 6: RESULTS VISUALIZATION AND REPORTING
# ========================================================================

# --- Final Output ---
cat("\nAnalysis complete. Predictor selection frequencies:\n")

# Display predictors sorted by selection frequency
print(sort(predictor_selection_count, decreasing = TRUE))
