function unmask = NiiWrite(mat, filename, UnmaskOnly, AlreadyMasked)
% NiiWrite - Write a matrix to a NIfTI file, with optional masking/unmasking.
%
% This function is designed and customized for neuroimaging data in MNI space, leveraging 
% the NIfTI toolbox by Jimmy Shen. It handles both masked and unmasked data,
% reshaping it into the standard 91x109x91 MNI volume.
%
% Inputs:
%   mat           - Data matrix (voxels x features) or (voxels x timepoints)
%   filename      - Output NIfTI filename (e.g., 'output.nii')
%   UnmaskOnly    - 1: Return unmasked 3D/4D volume without saving
%                  0: Save as NIfTI file (default)
%   AlreadyMasked - 1: Input is already masked (no unmasking needed)
%                  0: Input needs unmasking using MNI mask (default)
%
% Output:
%   unmask        - Unmasked 3D/4D volume (if UnmaskOnly=1)
%
% Dependencies:
%   - save_nii (from Jimmy Shen's NIfTI toolbox)
%   - A precomputed MNI mask ('Path_to_mni_mask.mat')
%
% Citations:
%   - For NIfTI I/O: 
%     Shen et al., (2022). NIfTI Tools for MATLAB. 
%     URL: https://www.mathworks.com/matlabcentral/fileexchange/8797
%
%   - For MNI space and masking:
%     Fonov et al. (2011). Unbiased nonlinear average age-appropriate brain 
%     templates from birth to adulthood. NeuroImage, 47(1), S102. 
%     (MNI152 template)
%
%   - If using SPM/FSL for mask generation:
%     Penny et al. (2011). Statistical Parametric Mapping: The Analysis of
%     Functional Brain Images. Elsevier. (SPM12)
%     OR
%     Jenkinson et al. (2012). FSL. NeuroImage, 62(2), 782-790.
%
% ------------------------------------------------------------------------

% Load MNI mask (assumes 'Path_to_mni_mask.mat' contains 'mni_mask' variable)
load('Path_to_mni_mask.mat');

s = size(mat, 2);

% Unmask the data if needed
if AlreadyMasked == 0
    unmask = zeros(902629, s);
    unmask(find(mni_mask), :) = mat;
else
    unmask = mat;
end

% Reshape and save (or return volume)
if UnmaskOnly < 1
    if s > 1
        V.img = reshape(unmask, [91 109 91 s]);
        V.hdr.dime.dim(1:5) = [4 91 109 91 s];
    else 
        V.img = reshape(unmask, [91 109 91]);
    end
    save_nii(V, filename);
else
    if s > 1
        unmask = reshape(unmask, [91 109 91 s]);
    else 
        unmask = reshape(unmask, [91 109 91]);
    end
end