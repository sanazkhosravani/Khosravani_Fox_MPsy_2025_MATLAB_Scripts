# ========================================================================
# LINEAR REGRESSION MODELING WITH PARTIAL RESIDUAL VISUALIZATION
# Prepared by Sanaz Khosravani, PhD
# Last updated: May 2025
#
# Performs linear regression analysis with visualization of:
# 1) Full model fit with multiple predictors
# 2) Adjusted relationship between primary predictor and outcome
# 3) Two visualization approaches (visreg and manual partial residuals)
#
# Input Requirements:
# - Excel file with:
#   * Continuous response variable (specified in model formula)
#   * Continuous predictors
#   * Categorical predictors (binary variables automatically converted to factors)
# - Properly formatted Excel file with header row
#
# Output:
# - model: Final fitted linear model object
# - model_summary: Detailed summary of model coefficients and fit statistics
# - Visualization plots showing adjusted relationships
# ========================================================================

# ========================================================================
# STEP 1: INITIALIZATION AND DATA LOADING
# ========================================================================

# Load required packages
required_packages <- c("readxl", "ggplot2", "stats", "visreg")
invisible(lapply(required_packages, function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}))

# Load dataset from Excel file
data <- read_excel("Path_to_your_data.xlsx")

# ========================================================================
# STEP 2: DATA PREPROCESSING
# ========================================================================

# Convert binary variables to factors (adjust variable names as needed)
binary_vars <- c("binary_var1", "binary_var2")  # Add your binary variables here
data[binary_vars] <- lapply(data[binary_vars], as.factor)

# ========================================================================
# STEP 3: MODEL SPECIFICATION AND FITTING
# ========================================================================

# Define model formula (adjust according to your variables)
model_formula <- as.formula(
  "y ~ connectivity + continuous_var1 + continuous_var2 + 
   factor_var1 + factor_var2 + interaction_term1:interaction_term2"
)

# Fit linear model
model <- lm(model_formula, data = data)

# Generate model summary
model_summary <- summary(model)
print(model_summary)

# ========================================================================
# STEP 4: VISUALIZATION OF ADJUSTED RELATIONSHIPS
# ========================================================================

# Option 1: Using visreg (recommended for quick visualization)
visreg_plot <- visreg(model, "connectivity", gg = TRUE, 
                      line = list(color = "steelblue"),
                      points = list(size = 3, alpha = 0.6, color = "darkgray")) +
  ggtitle("Adjusted Relationship: Connectivity vs Outcome") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

print(visreg_plot)

# Option 2: Manual partial residual plot (for full control)
if ("connectivity" %in% names(coef(model))) {
  # Create model without primary predictor
  reduced_formula <- update(model_formula, . ~ . - connectivity)
  model_reduced <- lm(reduced_formula, data = data)
  
  # Calculate partial residuals
  data$partial_resid <- residuals(model_reduced) + 
    coef(model)["connectivity"] * data$connectivity
  
  # Create plot
  manual_plot <- ggplot(data, aes(x = connectivity, y = partial_resid)) +
    geom_point(alpha = 0.6, color = "darkgray") +
    geom_smooth(method = "lm", color = "steelblue", se = TRUE) +
    labs(x = "Connectivity Value",
         y = "Partial Residual (Outcome adjusted for covariates)",
         title = "Manual Partial Residual Plot") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
  
  print(manual_plot)
} else {
  warning("Primary predictor not found in model coefficients")
}

# ========================================================================
# STEP 5: SAVE OUTPUT
# ========================================================================

# Save model results
saveRDS(model, "linear_model_results.rds")

# Save plots (adjust paths as needed)
ggsave("visreg_plot.png", visreg_plot, width = 8, height = 6, dpi = 300)
ggsave("manual_partial_residual_plot.png", manual_plot, width = 8, height = 6, dpi = 300)