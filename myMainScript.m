tic;
filename = 'data/im_5.bmp';
edges = edge_subtask(filename);
% RGBmethod(filename);
result = LABmethod(filename);
% LABmethod('colorchips.png');
% myBilateralFilteringRGB('cchips.png', 1.5, 0.05);

output = medfilt3(result, [7 7 1]);
% figure;
% imshow(output, []);

% output = 255*output;
% output = round(output/12);
% output = double(output*12);

% output = rgb2ycbcr(output);
% output(:,:,2) = round(output(:,:,2)/24);
% output(:,:,3) = round(output(:,:,3)/24);
% output(:,:,2) = output(:,:,2)*24;
% output(:,:,3) = output(:,:,3)*24;
% output = ycbcr2rgb(output);
% figure;
% imshow(output);
[m, n] = size(edges);
% edges
for x = 1:m
    for y = 1:n
        if edges(x,y) == 0
            for i = 1:3
                output(x,y,i) = 0;
            end
        end
    end
end

figure;
imshow(output);
% figure;
% imshow(edges);

toc;