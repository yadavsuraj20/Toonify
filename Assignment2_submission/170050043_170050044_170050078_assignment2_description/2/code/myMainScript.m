%% MyMainScript

tic;
%% Your code here

path = '../data/barbara.mat';
M = load(path);
M = M.imageOrig;
M = M/100;
filM = myBilateralFiltering('../data/barbara.mat',1.6,0.065);
E = M-filM;
SQE  = E.^2;
MSE  = mean(SQE(:));
barbaraRMSD = sqrt(MSE)

path = '../data/grass.png';
M = imread(path);
M = im2double(M);
filM = myBilateralFiltering('../data/grass.png',1.5,0.060);
E = M-filM;
SQE  = E.^2;
MSE  = mean(SQE(:));
grassRMSD = sqrt(MSE)

path = '../data/honeyCombReal.png';
M = imread(path);
M = im2double(M);
filM = myBilateralFiltering('../data/honeyCombReal.png',1.5,0.065);
E = M-filM;
SQE  = E.^2;
MSE  = mean(SQE(:));
honeyCombRMSD = sqrt(MSE)

spatialMask
toc;