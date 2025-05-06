# Advanced Model Selection Techniques in R

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Statistics](https://img.shields.io/badge/Statistics-FF6B6B?style=for-the-badge)
![Model_Selection](https://img.shields.io/badge/Model_Selection-8E44AD?style=for-the-badge)
![Regression](https://img.shields.io/badge/Regression-3498DB?style=for-the-badge)
![Machine_Learning](https://img.shields.io/badge/Machine_Learning-F39C12?style=for-the-badge)

## Overview

Two robust statistical approaches for optimal linear regression model selection:

1. **Exhaustive Information Criterion Optimization**  
   - Traditional best-subset selection using AIC or adjusted R²
   - Identifies single optimal model balancing fit and complexity

2. **Robust Predictor Selection via Subsampling**  
   - Stability-based selection through repeated subsampling
   - Identifies consistently important predictors across data variations

## Key Features

### Core Functionality
✔ Automatic factor conversion for categorical variables  
✔ Progress tracking during intensive computations  
✔ Comprehensive diagnostic reporting  
✔ Cross-platform compatibility  

### Exhaustive Search Method
🔍 Evaluates all possible predictor combinations  
📊 Optimizes either AIC (default) or adjusted R²  
📝 Provides complete regression summary for best model  
⚖️ Penalizes complexity to prevent overfitting  

### Robust Subsampling Method
🔄 500 iterations of 80% subsampling (configurable)  
📈 Tracks predictor selection frequencies  
🛡️ More resistant to overfitting and data quirks  
🔎 Reveals stable, generalizable predictors  

## Installation

```R
# Required packages
install.packages(c("readxl", "ggplot2", "car"))
