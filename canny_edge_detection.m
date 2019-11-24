function output = canny_edge_detection(im)
    sz = size(im)
    m = sz(1);
    n = sz(2);
    im = imgaussfilt(im);
    im = padarray(im,[1,1]);
%     grad = zeros(m,n,2); % Gx, Gy

    filtx = [-1 0 1; -2 0 2; -1 0 1];
    filty = [1 2 1; 0 0 0; -1 -2 -1];
    gradx = conv2(im,filtx);
    grady = conv2(im,filty);
    
    grad = sqrt(gradx.*gradx+grady.*grady);
    % ang = atan(grad);
%     size(ang)
    ang = zeros(m+2,n+2);

    for i = 1:m+1
        for j = 1:n+1
            ang(i,j) = rad2deg(atan2(grady(i,j),gradx(i,j)));
            if(ang(i,j)<0)
                ang(i,j) = ang(i,j) + 180;
            end
            if(ang(i,j)<=22.5)
                ang(i,j) = 0;
            elseif(ang(i,j)<=67.5)
                ang(i,j) = 45;
            elseif(ang(i,j)<=112.5)
                ang(i,j) = 90;
            elseif(ang(i,j)<=157.5)
                ang(i,j) = 135;
            else
                ang(i,j) = 0;
            end
        end
    end
    disp('ok')
    % ang

    new_arr = zeros(m+2,n+2);

    for i = 2:m+1
        for j = 2:n+1
            if(ang(i,j)==0)
                if(grad(i,j)>grad(i-1,j) && grad(i,j)>grad(i+1,j))
                    new_arr(i,j) = grad(i,j);
                end
            elseif(ang(i,j)==45)
                if(grad(i,j)>grad(i-1,j+1) && grad(i,j)>grad(i+1,j-1))
                    new_arr(i,j) = grad(i,j);
                end
            elseif(ang(i,j)==90)
                if(grad(i,j)>grad(i,j-1) && grad(i,j)>grad(i,j+1))
                    new_arr(i,j) = grad(i,j);
                end
            elseif(ang(i,j)==135)
                if(grad(i,j)>grad(i-1,j-1) && grad(i,j)>grad(i+1,j+1))
                    new_arr(i,j) = grad(i,j);
                end
            end
        end
    end
%     new_arr
%     disp('ok')
% 
    C = 0.25;
    threshold_low = max(1,C*(mean2(im)-std2(im)));
    threshold_high = min(254,C*(mean2(im)+std2(im)));

    for i = 2:m+1
        for j = 2:n+1
            if(grad(i,j)>threshold_high)
                new_arr(i,j) = grad(i,j);
            end
        end
    end
    disp('ok')
% 
    for i = 2:m+1
        for j = 2:n+1
            if(grad(i,j)<=threshold_low)
                continue
            elseif(new_arr(i-1,j-1)>0 || new_arr(i-1,j)>0 || new_arr(i-1,j+1)>0 || new_arr(i,j-1)>0 || new_arr(i,j+1)>0 || new_arr(i+1,j-1)>0 || new_arr(i+1,j)>0 || new_arr(i+1,j+1)>0)
                new_arr(i,j) = grad(i,j);
            end
        end
    end
    disp('ok')
    
    for i = 2:m+1
        for j = 2:n+1
            if(new_arr(i,j)>120)
                new_arr(i,j) = 255;
            else
                new_arr(i,j) = 0;
            end
        end
    end
    new_arr;
    
    output = new_arr(2:m+1,2:n+1);
end