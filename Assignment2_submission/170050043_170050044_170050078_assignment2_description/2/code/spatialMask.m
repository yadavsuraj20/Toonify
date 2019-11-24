%% MyMainScript

x = 6; y=6;
sigmad = 2;
M = zeros(11,11);
for i = 1:11
    for j = 1:11
        M(i,j) = exp(-((i-x)*(i-x)+(y-j)*(y-j))/(2*sigmad*sigmad));
    end
end

figure
imshow(M, 'initialMagnification',500)
% truesize(M,[11 11])
% truesize(M)
title('Mask for spatial Gaussian')
colorbar