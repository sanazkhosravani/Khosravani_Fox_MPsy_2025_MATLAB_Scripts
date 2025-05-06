
function unmask = NiiWrite(mat,filename,UnmaskOnly,AlreadyMasked)

%mat - map variable
%file - name of file output
%Unmask - 1: 3d output 0: nifti file

%Unmask and write a nifti

load('Path_to_mni_mask.mat');

s = size(mat,2);

%unmask = mat;
if AlreadyMasked == 0
    unmask = zeros(902629,s);
    unmask(find(mni_mask),:)=mat;
else
    unmask = mat;
end

if UnmaskOnly<1
if s>1
    V.img = reshape(unmask,[91 109 91 s]);
    V.hdr.dime.dim(1:5) = [4 91 109 91 s];
else 
    V.img = reshape(unmask,[91 109 91]);
end

save_nii(V,filename);

else
    if s>1
    unmask = reshape(unmask,[91 109 91 s]);
    
else 
    unmask = reshape(unmask,[91 109 91]);
    end
end