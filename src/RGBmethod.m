function result = RGBmethod(inputImage)
tic;
im = imread(inputImage);
size(im);

patch = imcrop(im,[170, 35, 50 50]);
patchVar = std2(patch)^2;
DoS = 2*patchVar;
result = imbilatfilt(im,DoS,10);
figure;
% imshow(result);
montage({inputImage, im});
title(['Degree of Smoothing direct RGB: ',num2str(DoS)])
toc;
end