function nii_hdr2nii(fnms)
% nii_hdr2nii - Convert .hdr/.img pairs to single-file .nii format using SPM.
%
% This function converts Analyze 7.5 format (.hdr/.img pairs) to the modern
% NIfTI-1 single-file format (.nii) using SPM's I/O utilities. Useful for
% compatibility with tools like FSL that prefer single-file NIfTI.
%
% Inputs:
%   fnms - (Optional) Path(s) to .hdr file(s). If omitted, opens a GUI dialog.
%          Can be a string for one file or a char array for multiple files.
%
% Examples:
%   nii_hdr2nii;                                    % GUI selection
%   nii_hdr2nii('T1_LM1003.hdr');                   % Single file
%   nii_hdr2nii(strvcat('T1.hdr', 'T2.hdr'));       % Multiple files
%
% Dependencies:
%   - SPM12 (or later): Requires spm_vol, spm_read_vols, and spm_write_vol.
%
% Citations:
%   - For SPM12's NIfTI conversion:
%     Penny et al. (2011). Statistical Parametric Mapping: The Analysis of
%     Functional Brain Images. Elsevier. 
%     URL: https://www.fil.ion.ucl.ac.uk/spm/
%
%   - For NIfTI format specifications:
%     Cox et al. (2004). NIfTI-1: A standard for neuroimaging data exchange.
%     NeuroImage, 22(4), 1440-1443.
%
% -------------------------------------------------------------------------

if ~exist('fnms','var') % No input files provided
    [A, Apth] = uigetfile({'*.hdr;*.img;*.nii', 'Neuroimaging files (*.hdr, *.img, *.nii)'}, ...
                          'Select .hdr/.img file(s)', 'MultiSelect', 'on');
    fnms = strcat(Apth, char(A));
end

for i = 1:size(fnms, 1)
    fnm = deblank(fnms(i,:)); % Remove trailing whitespace
    [pth, nm, ext] = fileparts(fnm);
    
    % Ensure we're working with .hdr (SPM handles the .img automatically)
    if strcmpi(ext, '.img')
        fnm = fullfile(pth, [nm '.hdr']);
    end
    
    % Read volume and save as .nii
    hdr = spm_vol(fnm);
    img = spm_read_vols(hdr);
    hdr.fname = fullfile(pth, [nm '.nii']); % Force .nii extension
    spm_write_vol(hdr, img);
    
    fprintf('Converted: %s -> %s\n', fnm, hdr.fname);
end