# Regression Analysis with VIF Calculation

This R script performs linear regression analysis with multicollinearity diagnostics using Variance Inflation Factors (VIF).

## Description

The script:
1. Reads data from an Excel file
2. Identifies and converts categorical variables to factors
3. Fits a linear regression model
4. Calculates VIF values to detect multicollinearity

## Prerequisites

- R (version 3.6 or higher recommended)
- Excel file containing predictors

## Installation

The script will automatically install required packages if not already present:

```r
install.packages("readxl")   # For reading Excel files
install.packages("car")      # For regression diagnostics