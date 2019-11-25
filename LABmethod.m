function smoothedRBG = LABmethod(inputImage)
tic;
% imRGB = imread(inputImage);
imLAB = rgb2lab(inputImage);
% figure;
% imshow(imLAB);
% title('imLAB image')

% patch = imcrop(imLAB,[34,71,60,55]);
% patch = imcrop(imLAB,[30,30,9,9]);
% patchSq = patch.^2;
% edist = sqrt(sum(patchSq,3));
% patchVar = std2(edist).^2;

% DoS = 2*patchVar;
DoS = 5;
smoothedLAB = imLAB;

for i = 1:30
    smoothedLAB = imbilatfilt(smoothedLAB,DoS);
end
% smoothedLAB = imbilatfilt(imLAB);

smoothedRBG = lab2rgb(smoothedLAB);

% figure;
% imshow(imRGB);
% figure;
% montage({imRGB,smoothedRBG})
% title(['Original Image vs. Filtered Image with Degree of Smoothing: ',num2str(DoS), 10])
% figure;
% imshow(smoothedRBG);
toc;
end