% ====================================================================================================================
% Reference: https://git.unl.edu/krishnaponnada/brain-imaging/-/blob/master/process/fcimage_analysis_v2/mask_4dfpimg.m
% ====================================================================================================================

function [img1] = mask_4dfpimg(img1,img2,operation)
%
% Name:mask_4dfpimg.m
% $Revision: 1.1 $
% $Date: 2012/07/16 19:20:47 $
%
% jdp 9/15/10
%
% This script takes two images, and masks the first with the second. The images can either be already loaded (matrices), or they can be image names.
% The operation switch is either 'zero' or 'remove'. 'zero' should be used when masking 4dfps or somethign like that, whereas 'remove' is more multipurpose and could be used to mask out any matrix with any other that has appropriate dimensions. 'remove' actually removes those cells/dimensions.
%
% USAGE: [maskedimage] = mask_4dfpimg(image,maskimage,operation);
% USAGE: [maskedimage] = mask_4dfpimg('data.4dfp.img','spatialmask.4dfp.img','zero');
% USAGE: [maskedimage] = mask_4dfpimg(datamat,maskmat,'zero');
% USAGE: [maskedimage] = mask_4dfpimg(datamat,maskmat,'remove');

% load image and calculate dimensions
if ~isnumeric(img1)
    [img1 frames1 voxelsize1] = read_4dfpimg(img1);
end
d1=size(img1);

% load mask and calculate dimensions
if ~isnumeric(img2)
    [img2 frames2 voxelsize2] = read_4dfpimg(img2);
end
d2=size(img2);

if ~isequal(d1(1),d2(1))
    error('Voxelsizes of images not congruent');
end

if ~isequal(d2(2),1)
    error('Mask should only be 1 frame, not %d\n',frames2);
end

% mask image1 using image2
img2=logical(img2); % sets all nonzero to true

switch operation
    case 'zero'
        img1(~img2,:)=0;
    case 'remove'
        img1(~img2,:)=[];
    otherwise
        error('Need to use zero or remove as mask operators');
end

