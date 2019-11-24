function myPatchBasedFiltering(path)
if(strcmp(path,'../../2/data/barbara.mat') == 1)
        M = load(path);
        M = M.imageOrig;
        M = M/100;
    else
        M = imread(path);
        M = im2double(M);
end

gblur = imgaussfilt(M, 0.66);
M1 = imresize(gblur, 0.5);
resizedM = M1;
figure
subplot(1,3,1), imshow(M1)
title('Original Image')
colorbar
[l, w] = size(M1);
maxI = max(max(M1));
minI = min(min(M1));
err = 0.05*double((maxI-minI))*randn(l,w);
M1 = M1+err;
subplot(1,3,2), imshow(M1)
title('Corrupted Image')
colorbar
M1padded = zeros(l+32, w+32);
M1padded(17:16+l, 17:16+w) = M1(1:l, 1:w); 
M2padded = M1padded;
M2 = M1;
hopt = 0.1;
gaussian = zeros(9,9);
sigma = 1;
for k1 = -4:4
    for k2 = -4:4
        gaussian(k1+5,k2+5) = exp(-(k1*k1+k2*k2)/(2*sigma*sigma));
    end
end

% lh = 0.9*hopt;
% uh = 1.1*hopt;
% for h = [lh uh hopt]
h = hopt;
    for x = 17:16+l
        for y = 17:16+w
            neigh_a = zeros(9,9);
%             for i = -4:4
%                 for j = -4:4
%                     if(x+i<1 || y+j<1)
%                             continue
%                     elseif(x+i>l || y+j>w)
%                             continue
%                     end
%                     neigh_a(i+5, j+5) = gaussian(i+5, j+5)*M1(x+i, y+j);
%                 end
%             end
            subM1 = M1padded(x-4:x+4, y-4:y+4);
            neigh_a(1:9,1:9) = gaussian.*subM1;
            wh = zeros(25,25);
            for p = -12:12
                for q = -12:12
%                     if(x+p<1 || y+q<1)
%                             continue
%                         elseif(x+p>l || y+q>w)
%                             continue
%                     end
%                     neigh_b = zeros(9,9);
                    subM1 = M1padded(x+p-4:x+p+4, y+q-4:y+q+4);
%                     for px = -4:4
%                         for py = -4:4
%                             if(x+p+px<1 || y+q+py<1)
%                                     continue
%                             elseif(x+p+px>l || y+q+py>w)
%                                     continue
%                             end
%                             neigh_b(px+5, py+5) = gaussian(px+5, py+5) * M1(x+p+px, y+q+py);
%                         end
%                     end
                    neigh_b = gaussian.*subM1;
                    diff = neigh_a - neigh_b;
                    n = norm(diff);
                    n = n*n;
                    wh(p+13,q+13) = exp(-n/(h*h));
                end
            end
            whsum = sum(sum(wh));
%             newI = 0;
%             for ltx = -12:12
%                 for lty = -12:12
%                     if(x+ltx<1 || y+lty<1)
%                             continue
%                         elseif(x+ltx>l || y+lty>w)
%                             continue
%                     end
%                     newI = newI + wh(13+ltx,13+lty) * M1(x+ltx,y+lty);    
%                 end
%             end
            subM1 = M1padded(x-12:x+12, y-12:y+12);
            subM1multWh = wh(1:25, 1:25).* subM1;
            sumMat = sum(sum(subM1multWh));
%             newI = newI/whsum;
            M2padded(x,y) = sumMat/whsum;
        end
    end
%     M2unpadded
    M2unpadded = M2padded(17:16+l, 17:16+w);
    E = resizedM-M2;
    SQE  = E.^2;
    MSE  = mean(SQE(:));
    RMSD = sqrt(MSE);
    fprintf('h = %.4f RMSD = %.4f\n', h, RMSD);

% end
% fprintf('hopt = %.4f\n', hopt);
subplot(1,3,3), imshow(M2unpadded)
title('Filtered Image')
colorbar
       







% function myPatchBasedFiltering(path)
% if(strcmp(path,'../../2/data/barbara.mat') == 1)
%         M = load(path);
%         M = M.imageOrig;
%         M = M/100;
%     else
%         M = imread(path);
%         M = im2double(M);
% end
% 
% gblur = imgaussfilt(M, 0.66);
% M1 = imresize(gblur, 0.5);
% resizedM = M1;
% figure
% subplot(1,3,1), imshow(M1)
% title('Original Image')
% colorbar
% [l, w] = size(M1);
% maxI = max(max(M1));
% minI = min(min(M1));
% err = 0.05*double((maxI-minI))*randn(l,w);
% M1 = M1+err;
% subplot(1,3,2), imshow(M1)
% title('Corrupted Image')
% colorbar
% 
% M2 = M1;
% hopt = 0.1;
% gaussian = zeros(9,9);
% sigma = 1;
% for k1 = -4:4
%     for k2 = -4:4
%         gaussian(k1+5,k2+5) = exp(-(k1*k1+k2*k2)/(2*sigma*sigma));
%     end
% end
% 
% % lh = 0.9*hopt;
% % uh = 1.1*hopt;
% % for h = [lh uh hopt]
% h = hopt;
%     for x = 1:l
%         for y = 1:w
%             neigh_a = zeros(9,9);
%             R1 = zeros(9,9);
%             R1(1:min([x+4 l])-max([x-4 1])+1,1:min([y+4 w])-max([y-4 1])+1) = M1(max([x-4 1]):min([x+4 l]),max([y-4 1]):min([y+4 w]));
% %             for i = -4:4
% %                 for j = -4:4
% %                     if(x+i<1 || y+j<1)
% %                             continue
% %                     elseif(x+i>l || y+j>w)
% %                             continue
% %                     end
% %                     neigh_a(i+5, j+5) = gaussian(i+5, j+5)*M1(x+i, y+j);
% %                        R1(9,9)
% %                        R1(1 
% %                 end
% %             end
%             neigh_a = gaussian.*R1;
%             wh = zeros(25,25);
%             for p = -12:12
%                 for q = -12:12
%                     if(x+p<1 || y+q<1)
%                             continue
%                         elseif(x+p>l || y+q>w)
%                             continue
%                     end
%                     neigh_b = zeros(9,9);
%                     R2 = zeros(9,9);
% %                     R2(max([x-4 1]):min([x+4 9]),max([y-4 1]):min([y+4 w])) = M1(max([x-4 1]):min([x+4 l]),max([y-4 1]):min([y+4 w]));
%                        R2(1:min([x+4 l])-max([x-4 1])+1,1:min([y+4 w])-max([y-4 1])+1) = M1(max([x-4 1]):min([x+4 l]),max([y-4 1]):min([y+4 w]));
%                         neigh_b = gaussian.*R2;
% %                     for px = -4:4
% %                         for py = -4:4
% %                             if(x+p+px<1 || y+q+py<1)
% %                                     continue
% %                             elseif(x+p+px>l || y+q+py>w)
% %                                     continue
% %                             end
% %                             neigh_b(px+5, py+5) = gaussian(px+5, py+5) * M1(x+p+px, y+q+py);
% %                         end
% %                     end
%                     diff = neigh_a - neigh_b;
%                     n = norm(diff);
%                     n = n*n;
%                     wh(p+13,q+13) = exp(-n/(h*h));
%                 end
%             end
%             whsum = sum(sum(wh));
%             newI = 0;
%             for ltx = -12:12
%                 for lty = -12:12
%                     if(x+ltx<1 || y+lty<1)
%                             continue
%                         elseif(x+ltx>l || y+lty>w)
%                             continue
%                     end
%                     newI = newI + wh(13+ltx,13+lty) * M1(x+ltx,y+lty);    
%                 end
%             end
%             newI = newI/whsum;
%             M2(x,y) = newI;
%         end
%     end
%     E = resizedM-M2;
%     SQE  = E.^2;
%     MSE  = mean(SQE(:));
%     RMSD = sqrt(MSE);
%     fprintf('h = %.4f RMSD = %.4f\n', h, RMSD);
% 
% % end
% % fprintf('hopt = %.4f\n', hopt);
% subplot(1,3,3), imshow(M2)
% title('Filtered Image')
% colorbar