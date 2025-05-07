# TMS/MT Site Marking Variability Analysis

This repository contains MATLAB scripts for analyzing within- and between-subject variability in Transcranial Magnetic Stimulation (TMS) or Motor Threshold (MT) site markings in MNI space. The pipeline includes computing distance values, statistical modeling for comparing within vs. between-subject variability data, estimating an equidistant point to different site markings, and visualization.

## Code Overview

### `1_Example_Input_Data.mlx`
- **Purpose**: Calculates Euclidean distance-based variability metrics
- **Functionality**:
  - Computes within-subject variability input data (distance to subject-specific centroid)
  - Computes between-subject variability input data (distance to group centroid)

### `2_Find_Equidistant_Point.mlx`
- **Functionality**:
  - Finds the 3D point equidistant to three given site markings (circumcenter)

### `3_PlotEquidistantPoint.mlx`
- **Functionality**:
  - Visualization of the equidistant point relative to the 3 input data points.

### `4_Variability_Site_Markings.mlx`
- **Purpose**: Statistical analysis of within- vs. between-individual TMS site variability data
- **Functionality**:
  - Linear mixed-effects modeling (accounting for repeated measures)
  - Confidence interval estimation (parametric and bootstrap methods)
- **Output**: Model results, ANOVA tables, and effect size estimates

### `5_Plot_Variability_Site_Markings_Within_versus_Between.mlx`
- **Purpose**: Graphical representation of variability patterns
- **Functionality**:
  - Jittered scatter plots of within- versus between-subject variability data
  - Mean values with 95% confidence intervals

## Typical Workflow
1. Process coordinates with `1_Example_Input_Data.mlx`
2. For subjects with ≥3 markings, optionally use `2_Find_Equidistant_Point.mlx` and visualize the estimated location using `3_VisualizeEquidistantPoint.mlx`
3. Contrast within- versus between-subject variability data using `4_Variability_Site_Markings.mlx`
4. Visualize findings with `5_Plot_Variability_Site_Markings_Within_versus_Between.mlx`

## Requirements
- MATLAB (tested on R2020b or later)
- Statistics and Machine Learning Toolbox
 
Last updated: May 2025