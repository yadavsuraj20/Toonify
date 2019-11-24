[X,Y] = meshgrid(-4:0.2:4,-4:0.2:4); %%In the patch we used -4:1:4, here for smoothness of curve we used many points
X2 = X.^2;
Y2 = Y.^2;
F = exp(-(X2+Y2)/2);

figure
surf(X,Y,F)