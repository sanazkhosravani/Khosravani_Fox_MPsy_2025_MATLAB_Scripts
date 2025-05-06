This repository contains the MATLAB and R scripts developed for the study titled:

# Predictive Value of Subgenual Cingulate Normative Connectivity to TMS Treatment Site for Antidepressant Response in Routine Clinical Practice: A Prospective, Multisite Cohort Study

## Authors:  
Sanaz Khosravani, PhD¹², Stephan T. Palm, BA¹², William Drew, BA¹²,  
Summer Frandsen, BA¹², Christopher Lin, BA¹², Eric Tirrell, BA³,  
Lauren Hindley, BA³, Molly Schineller, BA⁴, Arun Garimella, MSc¹²,  
Nicole Chiulli, BA¹⁵, David Lawson, BA¹², Emma Jones, BS¹²,  
Daniel Press, MD⁴, Adam P. Stern, MD⁴, Joshua C. Brown, MD, PhD⁵⁶,  
Tracy A. Barbour, MD⁵⁷, Joseph J. Taylor, MD, PhD¹⁵,  
Linda L. Carpenter, MD³⁸ 

### Senior Authors  
Shan H. Siddiqi, MD¹⁵, and Michael D. Fox, MD, PhD¹²⁵  

## Affiliations
1. Center for Brain Circuit Therapeutics, Brigham and Women's Hospital, Boston, MA
2. Department of Neurology, Harvard Medical School, Boston, MA
3. Butler Hospital, Providence, RI
4. Beth Israel Deaconess Medical Center, Boston, MA
5. Department of Psychiatry, Harvard Medical School, Boston, MA
6. McLean Hospital, Belmont, MA
7. Massachusetts General Hospital, Boston, MA
8. Department of Psychiatry and Human Behavior, Warren Alpert Medical School at Brown University, Providence, RI

## Corresponding Authors
- **Sanaz Khosravani, PhD**  
  Postdoctoral Research Fellow, Center for Brain Circuit Therapeutics  
  Hale Building for Transformative Medicine  
  Brigham and Women's Hospital  
  60 Fenwood Road, Boston, MA 02115  
  Email: skhosravani@mgb.org  

- **Michael D. Fox, MD, PhD**  
  Director, Center for Brain Circuit Therapeutics  
  Hale Building for Transformative Medicine  
  Brigham and Women's Hospital  
  60 Fenwood Road, Boston, MA 02115  
  Email: mdfox@bwh.harvard.edu, foxmdphd@gmail.com  
  Phone: 617-533-0921  

## Software Requirements
To reproduce our analyses, the following software packages are required:

### Core Software
| Software | Version | Installation Guide |
|----------|---------|--------------------|
| MATLAB | R2020a+ | [MathWorks](https://www.mathworks.com) |
| R | ≥4.0.0 | [CRAN](https://cran.r-project.org) |
| SPM12 | r7771 | [FIL](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) |


### Table of Contents:
- 1_Site_Marking_Variability_Assessment_and_Figure2: Assessment of Variability of TMS Site Markings
- 2_Computing_ROI_ROI_Connectivity: Example Script for Generating ROI-ROI Connectivity Values Between the TMS Site and Subgenual Cingulate Region
- 3_VIF_Analysis_on_Clinical_Covariates: Assessment of the Primary Outcome
- 4_Feature_Selection_Based_on_Clinical_Covariates: Feature Selection and Assessment of the Stability of Features
- 5_Code_for_Generating_Figure3: Generating Manuscript Plots
- 6_Analysis_of_Spatial_Topography: Analysis of the Spatial Topography of the Depression Improvement Network Before and After Incorporating Clinical Covariates

As an analogous normative connectome to the one used in this study, researchers may consider using the GSP connectome, which is openly accessible and can be downloaded from Harvard Dataverse. This dataset offers a preprocessed connectome that can be used for comparison and analysis in studies related to brain network analysis.
Reference: Cohen, A., Soussand, L., McManus, P., & Fox, M. (2020). GSP1000 preprocessed connectome. Harvard Dataverse. https://doi.org/10.7910/DVN/ILXIKS