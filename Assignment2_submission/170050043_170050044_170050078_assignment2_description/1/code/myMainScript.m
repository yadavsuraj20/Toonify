%% MyMainScript

tic;
clc;

%% Your code here

[M1,cmap1] = imread('../data/bird.jpg');
sz1 = size(M1);
m1 = sz1(1);
n1 = sz1(2);
%disp(m1);
%disp(n1);
%disp(M1(1,1));
bthresh1 =  100;
gthresh1 =  100;
rthresh1 =  100;
rbthresh1 = 0.99;
rgthresh1 =  0;
bgthresh1 =  0;


BW1 = zeros(m1,n1);

%%%%%%%%%%%Automatic Part%%%%%%
for i = 1:m1
    for j = 1:n1
        if M1(i,j,1)/(M1(i,j,3)+1) > rbthresh1 
            BW1(i,j) = 1;
        end 
    end
end

%%%%%%%%%%Semi-Automatic Correction%%%%%%%%%
for i = 1:m1
    for j = 1:n1
        if (j>780)||(i<50)||(j<300&&i>190)||(i>450 && j<500)||(j<380&&i<355&&i>320)
            BW1(i,j) = 0;
        end 
    end
end
%
%size(medfilt2(BW1,[5 5]))
%figure
%imshow(medfilt2(BW1,[5 5]),[]);

% 
dthresh1 = 40;
mySpatiallyVaryingKernel('../data/bird.jpg',medfilt2(BW1,[5 5]), dthresh1)
% 

[M2,cmap2] = imread('../data/flower.jpg');
sz2 = size(M2);
m2 = sz2(1);
n2 = sz2(2);
%disp(m2);
%disp(n2);
%disp(M2(1,1));
bthresh =  10;         %100;
gthresh =  100;         %100;
rthresh =  120;         %100;
rbthresh =  0.9;        %0.99;
rgthresh =  0.80;         %0;
bgthresh =  0.2;        %0;


BW2 = zeros(m2,n2);

%%%%%%%%%%%Automatic Part%%%%%%
for i = 1:m2
    for j = 1:n2
        if (M2(i,j,1)> rthresh && M2(i,j,2)< gthresh) || (i<160 && i>110 && j>190 && j<240) 
            BW2(i,j) = 1;
        end 
    end
end

%%%%%%%%%%Semi-Automatic Correction%%%%%%%%%
for i = 1:m2
    for j = 1:n2
        if i>150 && j<150 
            BW2(i,j) = 0;
        end 
    end
end
%figure
%imshow(medfilt2(BW2,[10 10]),[]);

dthresh2 = 20;
mySpatiallyVaryingKernel('../data/flower.jpg',medfilt2(BW2,[10 10]), dthresh2);
toc;