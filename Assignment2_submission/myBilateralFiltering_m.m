function myBilateralFiltering(imagePath)
%MYBILATERALFILTERING Summary of this function goes here
%   Detailed explanation goes here

% read the original image 
if strcmp(imagePath,'../data/barbara.mat')
    im = load(imagePath);
    imr = im.imageOrig;
    imr = imr/255;
    % set optimal parameter
    sdSpace = 7;
    sdIntensity = 0.01;

elseif strcmp(imagePath,'../data/grass.png')
    imr = imread(imagePath);
    % set optimal parameter
    sdSpace = 25.01;
    sdIntensity = 0.051;
else
    imr = imread(imagePath);
    % set optimal parameter
    sdSpace = 21;
    sdIntensity = 0.05;
end

origImage = im2double(imr);
origSize = size(origImage);
N = origSize(1); % image is N*N

% estimate sd_corrupt
sdCorrupt = (max(max(origImage))-min(min(origImage)))/20.0 ;

% get the corrupted image
corrImage = randn(N)*sdCorrupt + origImage;

% set parameters
windowSize = 11;
padding = (windowSize-1)/2;
scaleFactor = 100;

% precompute gaussian mask for space
spaceMask = 1:windowSize ;
midVal = median(spaceMask);
spaceMask = exp(-((spaceMask-midVal).^2)/(2*sdSpace*sdSpace));
spaceMask = spaceMask'*spaceMask;
% final spaceMask
spaceMask = (scaleFactor/(sqrt(2*pi)*sdSpace))*spaceMask;

% init filter image as padded corrupted image to handle corner cases
filterImage = zeros(N+2*padding);
filterImage((padding+1):(N+padding),(padding+1):(N+padding)) = corrImage;

% init final image that stores the answer
finalImage = zeros(N);

% loop over all pixels
for r = (padding+1):(N+padding)
    for c = (padding+1):(N+padding)
       % generate intensity mask
       intensityWindow = filterImage((r-padding):(r+padding),(c-padding):(c+padding));
       midVal = filterImage(r,c);
       intensityMask =  exp(-((intensityWindow-midVal).^2)/(2*sdIntensity*sdIntensity));
       % final intensity mask
       intensityMask = (scaleFactor/(sqrt(2*pi)*sdIntensity))*intensityMask;
       
       % apply mask of space and intensity
       den = intensityMask.*spaceMask;
       num = intensityWindow.*den;
       
       % store the final intensity in final image 
       finalImage(r-padding,c-padding) = sum(sum(num))/sum(sum(den));
    end
end

%  calculate rms obtained
rms = sqrt(sum(sum(finalImage-origImage).^2)/(N*N));
disp(['RMSD error for ',imagePath,'=>']);
disp(rms);


% display spaceMask orig , corr , final image 
figure;
imshow(mat2gray(imresize(spaceMask, [50 50])));
title(['Spacial gaussian mask ',imagePath]);
colorbar;
figure;

% original
subplot(1, 3, 1);
imshow(mat2gray(origImage));
title(['Original image ',imagePath]);
colorbar;

% corrupted
subplot(1, 3, 2);
imshow(mat2gray(corrImage));
title(['Corrupted image ',imagePath]);
colorbar;

% fitered
subplot(1, 3, 3);
imshow(mat2gray(finalImage));
title(['Filtered image ',imagePath]);
colorbar;


end

