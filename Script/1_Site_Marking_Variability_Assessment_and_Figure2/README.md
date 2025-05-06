# TMS/MT Site Marking Variability Analysis

This repository contains MATLAB scripts for analyzing within- and between-subject variability in Transcranial Magnetic Stimulation (TMS) or Motor Threshold (MT) site markings in MNI space. The pipeline includes computing distance values, statistical modeling for comparing within vs. between-subject variability data, estimating an equidistant point to different site markings, and visualization.

## Code Overview

### 1. `1_Example_Input_Data.mlx`
- **Purpose**: Calculates Euclidean distance-based variability metrics
- **Functionality**:
  - Computes within-subject variability (distance to subject-specific centroid)
  - Computes between-subject variability (distance to group centroid)
  - Handles multiple site markings per subject
- **Output**: Distance measurements for further statistical analysis

### 2. `2_Variability_Site_Markings.mlx`
- **Purpose**: Statistical analysis of variability patterns
- **Functionality**:
  - Linear mixed-effects modeling (accounting for repeated measures)
  - Confidence interval estimation (parametric and bootstrap methods)
  - Comparison across hospital sites
- **Output**: Model results, ANOVA tables, and effect size estimates

### 3. `3_Find_Equidistant_Point.mlx`
- **Purpose**: Geometric calculation for alternative variability assessment
- **Functionality**:
  - Finds the 3D point equidistant to three given site markings (circumcenter)
  - Uses perpendicular bisector planes and geometric constraints
  - Includes solution verification
- **Output**: Equidistant point coordinates for subjects with ≥3 markings

### 4. `4_Plot_Variability_Site_Markings_Within_versus_Between.mlx`
- **Purpose**: Graphical representation of variability patterns
- **Functionality**:
  - Jittered scatter plots of individual measurements
  - Mean values with 95% confidence intervals
  - Statistical comparison annotations
  - Publication-quality figure formatting
- **Output**: Ready-to-use visualization of within vs. between-subject variability

## Typical Workflow
1. Process coordinates with `1_Example_Input_Data.mlx`
2. For subjects with ≥3 markings, optionally use `3_Find_Equidistant_Point.mlx`
3. Analyze results with `2_Variability_Site_Markings.mlx`
4. Visualize findings with `4_Plot_Variability_Site_Markings_Within_versus_Between.mlx`

## Requirements
- MATLAB (tested on R2020b or later)
- Statistics and Machine Learning Toolbox
 
Last updated: May 2025