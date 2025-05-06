# Generating Data-Driven Map Showing Connectivity to TMS Site Correlating with Antidepressant Response

## Overview
This MATLAB pipeline analyzes the relationship between functional connectivity patterns and changes in depression symptoms. The code performs voxel-wise correlation analysis between brain connectivity maps and clinical outcomes, with comparison to established literature-derived masks (e.g., Siddiqi... Fox, 2021).

*"Brain stimulation and brain lesions converge on common causal circuits..."*  
*Nature Human Behaviour* (2021) | DOI:10.1038/s41562-021-01161-1

## Key Features
- **Clinical Correlation Analysis**: Computes partial correlations between connectivity patterns and symptom changes while controlling for covariates
- **Spatial Validation**: Quantifies similarity between data-driven results and existing depression maps
- **Standardized Processing**: Uses MNI space normalization for cross-study compatibility
- **Automated Output Generation**: Produces publication-ready statistical maps in NIfTI format


## Requirements
- MATLAB (version ≥ R2019b)
- NIfTI toolbox (for file I/O)
- Input Data:
  - Preprocessed functional connectivity maps (NIfTI format)
  - Clinical data matrix (MATLAB .mat file)
  - MNI template mask
  - Reference depression map (optional for validation)
- SPM 12

## Workflow
1. **Data Preparation**: Loads individual connectivity maps and applies brain mask
2. **Statistical Modeling**: Computes partial correlations with clinical outcomes
3. **Results Generation**: Saves statistical maps for visualization
4. **Spatial Validation**: Compares results with literature maps (optional)

## Expected Outputs
- `depression_correlation_map.nii`: Statistical map of symptom correlations
- Spatial correlation metrics with reference maps (when provided)

## Customization
Users can modify:
- Subject selection criteria
- Covariate sets in partial correlation
- Statistical thresholds
- Output naming conventions

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)