% Main Script
function im1 = edge_subtask(inputImage)
% orig_im = imread(inputImage);
orig_im = inputImage;
im = rgb2ycbcr(orig_im);
im = im(:,:,1);

canny_im = canny_edge_detection(im);
% canny_im = imdilate(canny_im,[1 1; 1 1]);
% figure;
% imshow(canny_im);
% figure
% subplot(1,2,1)
% imshow(canny_im,[])
% title('Our output')
% subplot(1,2,2)

% canny edge detection
C = 0.25;
threshold_low = max(1,C*(mean2(im)-std2(im)))/255;
threshold_high = min(254,C*(mean2(im)+std2(im)))/255;

% if threshold_low > threshold_high
%     temp = threshold_high;
%     threshold_high = threshold_low;
%     threshold_low = temp;
% end

% threshold = [threshold_low threshold_high]
threshold = [0.07 0.17];
im1 = edge(im,'Canny',threshold);
% imshow(im1);
% title('Canny function')

% image dilation with 2x2 structuring element
im1 = imdilate(im1,[1 1; 1 1]);

im1 = 1 - im1;
% im1 = 1 - canny_im/255;

end