# Generating Data-Driven Map Showing Connectivity to TMS Site Correlating with Antidepressant Response

## Overview
This MATLAB pipeline analyzes the relationship between functional connectivity patterns and changes in depression symptoms. The code performs voxel-wise correlation analysis between brain connectivity maps and clinical outcomes, with comparison to established literature-derived masks (e.g., Siddiqi... Fox, 2021).

Siddiqi, S. H., Schaper, F. L. W. V. J., Horn, A., Hsu, J., Brodtmann, A., Cash, R. F. H., ... Fox, M. D. (2021). Brain stimulation and brain lesions converge on common causal circuits in neuropsychiatric disease. Nature Human Behaviour, 5(12), 1707–1716.(https://doi.org/10.1038/s41562-021-01161-1)


## Key Features
- **Clinical Correlation Analysis**: Computes partial correlations between voxel-wise connectivity to TMS site and depression score changes while controlling for covariates
- **Spatial Validation**: Quantifies similarity between data-driven results and existing depression maps

## Requirements
- MATLAB (version ≥ R2019b)
- NIfTI toolbox (for file I/O)
- Input Data:
  - Preprocessed functional connectivity maps (NIfTI format)
  - Clinical data matrix (MATLAB .mat file)
  - MNI template mask
  - Reference depression map (optional for validation)
- SPM 12

## Expected Outputs
- `depression_correlation_map.nii`: Data-driven map of correlation coefficients demonstrating the relationship between functional connectivity of each voxel to TMS site and antidepressant response.
- Spatial correlation with reference maps (when provided)
