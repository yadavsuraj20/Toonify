function output = Toonify(im)

    edges = edge_subtask(im);

    % RGBmethod(filename);
    result = LABmethod(im);
%     edges = edge_subtask(result);
    
    output = medfilt3(result, [7 7 1]);

    output = 255*output;
    output = uint8(output/8);
    output = double(output*8);
    output = output/255;
    
    [m, n] = size(edges);
    
    % edges
    for x = 1:m
        for y = 1:n
            if edges(x,y) == 0
                for i = 1:3
                    output(x,y,i) = 0;
                end
            end
        end
    end
end