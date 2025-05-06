# Primary Outcome: Computing Resting-State Functional Connectivity between TMS Field Distribution Model and SGC Mask.

MATLAB pipeline for computing resting-state functional connectivity between:
1. Subject-specific TMS field distribution models
2. Subgenual cingulate (SGC) mask

This code provides an example of how to compute ROI-to-ROI functional connectivity between a TMS field distribution model and an SGC mask. While the example illustrates the methodology, the connectivity values reported in the manuscript were computed using the Yeo connectome. As an alternative normative connectome, you may use the GSP1000 connectome.

## References
- Yeo Connectome: Yeo et al. (2011) *The organization of the human cerebral cortex estimated by intrinsic functional connectivity* [J Neurophysiol](https://doi.org/10.1152/jn.00338.2011)
- GSP1000 Connectome: Holmes et al. (2015) *Brain Genomics Superstruct Project* [Sci Data](https://doi.org/10.1038/sdata.2015.31)

## Analysis Overview
```mermaid
graph TD
    A[Load TMS Field Model] --> B[Apply MNI Mask]
    C[Load fMRI Timecourses] --> D[Extract TMS ROI Signal]
    E[Load SGC Mask] --> F[Extract SGC Signal]
    B --> D
    D --> G[Compute Pearson Correlation]
    F --> G
    G --> H[Output Connectivity Matrix]

## Overview

The analysis pipeline:
1. Loads individual TMS field distribution models
2. Computes mean timecourses within:
   - Each subject's TMS target field
   - A standard SGC mask (common across subjects)
3. Calculates pairwise ROI-ROI correlations between TMS fields and SGC
4. Outputs individual connectivity values and group-level averages

## Input Requirements

1. **Subject Data**:
   - Individual TMS field models (`Example_TMS_Field_Decay_Spherical_Model.nii.gz`)
   - Preprocessed fMRI timecourses (`Time_Course.nii.gz`)

2. **Masks**:
   - Standard SGC mask (`Example_SGC_Mask_BA25_bilateral.nii`)
   - MNI brain mask (`mni_mask.mat`)

## Output

- `conn_indiv`: Matrix of TMS-SGC connectivity values (rows = TMS models, columns = subjects)
- Group average connectivity for each TMS model across all subjects

## Usage

1. Edit subject list in `SUBJ_Inclusive`
2. Ensure all input files are in correct paths
3. Run script in MATLAB

## Dependencies

- `load_nii` (for NIfTI file handling)
- MATLAB Statistics and Machine Learning Toolbox
- mask_4dfpimg.m


Last updated: May 2025