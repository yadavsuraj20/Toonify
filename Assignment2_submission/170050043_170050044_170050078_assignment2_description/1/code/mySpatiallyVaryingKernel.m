function mySpatiallyVaryingKernel(path,BW2,dthresh2)
    [M2,cmap2] = imread(path);
    M2 = im2double(M2);
    sz2 = size(M2);
    m2 = sz2(1);
    n2 = sz2(2);


    NewM2 = zeros(m2,n2,3);
    Jet2 = zeros(m2,n2);
    
    for i = 1:dthresh2
        mulat{i} = zeros(2*i+1,2*i+1);
        sum1 = 0;
        for x = 1:2*i+1
            for y = 1:2*i+1
                if (i+1-x)^2+(i+1-y)^2<=i^2
                    mulat{i}(x,y) = 1;
                    sum1=sum1+1;
                end
            end
        end
        mulat{i} = mulat{i}/sum1;
        %disp(mulat{i})
    end
    

    for i = 1:m2
        %i
        for j = 1:n2
            mindis = dthresh2;
            if i>m2-(dthresh2+1) || i<dthresh2+2 || j>n2-(dthresh2+1) || j<dthresh2+2
                for x = max([1 i-dthresh2]):min([m2 i+dthresh2])
                    for y = max([1 j-dthresh2]):min([n2 j+dthresh2])
                       
                        if BW2(x,y)==1
                            dis = sqrt((i-x)^2+(j-y)^2);
                            mindis=min([mindis dis]);
                        end
                    end
                end
                Jet2(i,j) = floor(mindis);
            else
               
                for x = dthresh2:-1:1
                    
                    V2 = mulat{x};
                    V1 = BW2(i-x:i+x,j-x:j+x);
                    
                    if sum(sum(V1.*V2))==0
                        Jet2(i,j)=x;
                        %disp(x);
                        break
                    end
                    Jet2(i,j)=x;
                end
            end

        end
    %     disp(i);
    end
    figure
    contour(flip(Jet2))

    %disp('done');
   
%         
    for i = 1:m2
        %i
        for j = 1:n2
            sum1 = 0;
            if i>m2-dthresh2 || i<dthresh2+1 || j>n2-dthresh2 || j<dthresh2+1
                    for x = max([1 i-dthresh2]):min([m2 i+dthresh2])
                        for y = max([1 j-dthresh2]):min([n2 j+dthresh2])
                            if (i-x)^2+(j-y)^2<=Jet2(i,j)^2
                                NewM2(i,j,1)=NewM2(i,j,1)+M2(x,y,1);
                                NewM2(i,j,2)=NewM2(i,j,2)+M2(x,y,2);
                                NewM2(i,j,3)=NewM2(i,j,3)+M2(x,y,3);
                                sum1=sum1+1;
                            end
                        end
                    end
                    NewM2(i,j,1)=NewM2(i,j,1)/sum1;
                    NewM2(i,j,2)=NewM2(i,j,2)/sum1;
                    NewM2(i,j,3)=NewM2(i,j,3)/sum1;
            else
                    r = Jet2(i,j);
                    if(BW2(i,j)==0 && r>0)
                        V11 = M2(i-r:i+r,j-r:j+r,1);
                        V12 = M2(i-r:i+r,j-r:j+r,2);
                        V13 = M2(i-r:i+r,j-r:j+r,3);
                        %disp(r);
                        V2 = mulat{r};
                        NewM2(i,j,1)=sum(sum(V11.*V2));
                        NewM2(i,j,2)=sum(sum(V12.*V2));
                        NewM2(i,j,3)=sum(sum(V13.*V2));
                    else
                        NewM2(i,j,1)=M2(i,j,1);
                        NewM2(i,j,2)=M2(i,j,2);
                        NewM2(i,j,3)=M2(i,j,3);
                    end
                %
                %NewM2(i,j,k)
            end
        end
        %     disp(i);
    end
    
   
    figure
    imshow(NewM2,[]);
    
    Backimage = zeros(m2,n2,3);
    Backimage(:,:,1) =Backimage(:,:,1)+ M2(:,:,1).*BW2;
    Backimage(:,:,2) =Backimage(:,:,2)+ M2(:,:,2).*BW2;
    Backimage(:,:,3) =Backimage(:,:,3)+ M2(:,:,3).*BW2;
    
    Frontimage = zeros(m2,n2,3);
    
    Frontimage(:,:,1) = Frontimage(:,:,1)-Backimage(:,:,1) + M2(:,:,1);
    Frontimage(:,:,2) = Frontimage(:,:,2)-Backimage(:,:,2) + M2(:,:,2);
    Frontimage(:,:,3) = Frontimage(:,:,3)-Backimage(:,:,3) + M2(:,:,3);
    
    figure;
    subplot(3,1,1);
    imshow(BW2);
    subplot(3,1,2);
    imshow(Backimage);
    subplot(3,1,3);
    imshow(Frontimage);
    
    figure;
    subplot(1,5,1);
    imshow(mulat{floor(0.2*dthresh2)}*255);
    title('0.2*Dthresh');
    subplot(1,5,2);
    imshow(mulat{floor(0.4*dthresh2)}*255);
    title('0.4*Dthresh');
    subplot(1,5,3);
    imshow(mulat{floor(0.6*dthresh2)}*255);
    title('0.6*Dthresh');
    subplot(1,5,4);
    imshow(mulat{floor(0.8*dthresh2)}*255);
    title('0.8*Dthresh');
    subplot(1,5,5);
    imshow(mulat{floor(dthresh2)}*255);
    title('Dthresh');
    
    
    
end