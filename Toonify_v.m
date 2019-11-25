function output = Toonify_v(im)
    result = LABmethod(im);
     
%     figure;
%     imshow(result);
    
    edges = edge_subtask(result);
%     
%     figure;
%     imshow(edges);
    
    % RGBmethod(filename);
    
%     edges = edge_subtask(result);
    
    output = medfilt3(result, [7 7 1]);

    output = 255*output;
    output = uint8(output/8);
    output = double(output*8);
    output = output/255;
    
    [m, n] = size(edges);
    
    
%     figure;
%     imshow(output);
%     
    % edges
    for x = 1:m
        for y = 1:n
            if edges(x,y) == 0
%                 for i = 1:3
%                     output(x,y,i) = 0;
%                 end
                output(x,y,1) = 0;output(x,y,3) = 0;output(x,y,2) = 0;
            end
        end
    end
%     figure;
%     imshow(output);
end