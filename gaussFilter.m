function [outImg] = gaussFilter(inImg, sigma)
    if sigma < 0
        disp('The value of sigma cannot be less than 0.')
        return
    end
    
    kernelSize = 2 * ceil(2 * sigma) + 1;
    
    left_width = (kernelSize - 1) / 2;
    right_width = kernelSize - 1 - left_width;
    top_width = left_width;
    bottom_width = right_width;
    
    paddedImg = padarray(padarray(padarray(padarray(double(inImg), [0, left_width], NaN, 'pre'), [0, right_width], NaN, 'post'), [top_width, 0], NaN, 'pre'), [bottom_width, 0], NaN, 'post');

    kernel = zeros(kernelSize, kernelSize);
    for row = 1:kernelSize
        for col = 1:kernelSize
            x = row - ((kernelSize - 1)/2);
            y = col - ((kernelSize - 1)/2);
            exponent = -(x ^ 2 + y ^ 2)/(2 * sigma ^ 2);
            kernel(row, col) = (1 / (2 * pi * (sigma ^ 2))) * exp(exponent);
        end
    end

    outImg = zeros(size(inImg));
    for row = (1 + top_width):(top_width + size(inImg, 1))
        for col = (1 + left_width):(left_width + size(inImg, 2))
            conv = paddedImg((row - top_width):(row + bottom_width), (col - left_width):(col + right_width), :);
            outImg(row - top_width, col - left_width, :) = nansum(nansum(kernel .* conv));
        end
    end
    outImg = cast(outImg,'uint8');
end