%% MyMainScript

function M = myBilateralFiltering(path, sigmad, sigmar)
    if(strcmp(path,'../data/barbara.mat') == 1)
        M = load(path);
        M = M.imageOrig;
        M = M/100;
    else
        M = imread(path);
        M = im2double(M);
    end
    sz = size(M);
    m = sz(1);
    n = sz(2);
    %% Corruption---------------
    maxI = max(max(M));
    minI = min(min(M));
    err = 0.05*double((maxI-minI))*randn(m,n);
    errM = M+err;
    %% Corruption done----------
    figure
    subplot(1,3,1), imshow(M)
    title('Original Image')
    colorbar
    subplot(1,3,2), imshow(errM)
    title('Corrupted Image')
    colorbar
    M = errM;
    for x = [1:m]
        for y = [1:n]
            I = 0;
            sumw = 0;
            for i = [-5:5]
                for j = [-5:5]
                    if(x+i<1 || y+j<1)
                        continue
                    elseif(x+i>m || y+j>n)
                        continue
                    end
                    w = exp(-(i*i+j*j)/(2*sigmad*sigmad));
                    w = w*exp(-((M(x+i,y+j)-M(x,y))*(M(x+i,y+j)-M(x,y)))/(2*sigmar*sigmar));
                    I = I+w*M(x+i,y+j);
                    sumw = sumw+w;
                end
            end
            M(x,y) = I/sumw;
%             s1 = x-5:x+5;
%             s1 = repmat(s1,11,1);
%             s2 = s1.';
%             s1 = s1-x;
%             s2 = s2-y;
%             s1 = -(s1.^2);
%             s2 = -(s2.^2);
%             s = s1+s2;
%             s = s/(2*sigmad*sigmad);
%             if(x-5>0 && y-5>0 && x+5<=m && y+5<=n)
%                 I = M(x-5:x+5,y-5:y+5)-M(x,y);
%             else
%                 I = zeros(11,11);
%             end
%             I = I.^2;
%             I = I/(2*sigmar*sigmar);
%             w = (I+s);
%             w = expm(w);
%             I = w.*M;
%             M(x,y) = sum(I,'omitnan')/sum(w,'omitnan');
        end
    end
    %%-------------------------------------
%     figure
    subplot(1,3,3), imshow(M)
    title('Filtered Image')
    colorbar
end