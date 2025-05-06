function nii_hdr2nii (fnms)
%Convert file.hdr/file.img to file.nii
%n.b. FSL does not like file.nii and file.hdr co-existing
% fnms : (optional) images to convert
%Examples
% nii_hdr2nii
% nii_hdr2nii('T1_LM1003.hdr');
% nii_hdr2nii(strvcat('T1_LM1003.hdr','T2_LM1003.hdr'));

if ~exist('fnms','var') %file not specified
    [A,Apth] = uigetfile({'*.nii';'*.*'},'Select .nii file(s)', 'MultiSelect', 'on');
    fnms = strcat(Apth,char(A));
end
for i=1:size(fnms,1)
    fnm = fnms(i,:);
    [pth, nm] = spm_fileparts(fnm);
    hdr = spm_vol(fnm);
    img = spm_read_vols(hdr);
    hdr.fname = fullfile(pth, [nm, '.nii']);
    spm_write_vol(hdr,img);
end

% fnm = 'mask.hdr';
% hdr = spm_vol(fnm);
% img = spm_read_vols(hdr);
% hdr.fname = fullfile(pth, [nm, '.nii']);
% spm_write_vol(hdr,img);