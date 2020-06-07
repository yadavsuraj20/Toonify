tic;
filename = 'data/im_5.bmp';
im = imread(filename);
output = Toonify(im);

figure;
imshow(output);
toc;