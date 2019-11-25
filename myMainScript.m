tic;
filename = 'data/im_8.bmp';
im = imread(filename);
output = Toonify(im);

figure;
imshow(output);
toc;