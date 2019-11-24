%% MyMainScript

function M = myBilateralFilteringRGB(path, sigmad, sigmar)
    M = imread(path);
    M = im2double(M);
    sz = size(M);
    m = sz(1);
    n = sz(2);
    %% Corruption---------------
%     maxI = max(max(mean(M,3)));
%     minI = min(min(mean(M,3)));
%     err = 0.05*double((maxI-minI))*randn(m,n);
%     errM = M+err;
    %% Corruption done----------
    figure
    subplot(1,3,1), imshow(M)
    title('Original Image')
    colorbar
%     subplot(1,3,2), imshow(errM)
%     title('Corrupted Image')
%     colorbar
% %     M = errM;

    for x = 1:m
        x
        for y = 1:n
            I = 0;
            sumw = 0;
            for i = -5:5
                for j = -5:5
                    if(x+i<1 || y+j<1)
                        continue
                    elseif(x+i>m || y+j>n)
                        continue
                    end
                    w = exp(-(i.^2+j.^2)/(2*(sigmad.^2)));
                    temp = M(x+i,y+j, :)- M(x,y,:);
                    norm2 = temp(1,1,1).^2 + temp(1,1,2).^2 + temp(1,1,3).^2;
                    w = w*exp(-(norm2/(2*sigmar*sigmar)));
                    I = I+w* mean(M(x+i,y+j, :));
                    sumw = sumw+w;
                end
            end
            M(x,y) = I/sumw;
        end
    end
    subplot(1,3,3), imshow(M)
    title('Filtered Image')
    colorbar
end