function output=median_filter(im)
    % 7x7 median filtering
    sz = size(im);
    m = sz(1);
    n = sz(2);
    im = padarray(im,[3,3]);
    filtered_im = zeros(m,n);
    for i = 4:m+3
        for j = 4:n+3
            temp = im(i-3:i+3,j-3:j+3);
            temp = reshape(temp,1,[]);
            filtered_im(i-3,j-3) = median(temp);
        end
    end
    output = filtered_im;
end