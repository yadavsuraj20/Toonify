% Main Script
function im1 = edge_subtask(inputImage)
% orig_im = imread(inputImage);
orig_im = inputImage;
im = rgb2ycbcr(orig_im);
im = im(:,:,1);
% im = double(im);
% med_im = median_filter(im);
% 
% figure
% subplot(1,3,1)
% imshow(orig_im,[])
% subplot(1,3,2)
% imshow(im,[])
% subplot(1,3,3)
% imshow(med_im,[])

canny_im = canny_edge_detection(im);
% canny_im = imdilate(canny_im,[1 1; 1 1]);
% figure;
% imshow(canny_im);
% figure
% subplot(1,3,1)
% imshow(edge(im,'canny'),[])
% imshow(orig_im)
% subplot(1,3,2)
% imshow(canny_im,[])
% subplot(1,3,3)

% canny edge detection
C = 0.25;
threshold_low = max(1,C*(mean2(im)-std2(im)))/255;
threshold_high = min(254,C*(mean2(im)+std2(im)))/255;
threshold = [threshold_low threshold_high];
im1 = edge(im,'Canny',threshold);

% image dilation with 2x2 structuring element
im1 = imdilate(im1,[1 1; 1 1]);

im1 = 1 - im1;
% im1 = 1 - canny_im/255;

% im1 = bwareaopen(im1,100);
% imshow(im1,[])
end