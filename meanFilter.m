function [outImg] = meanFilter(inImg, kernelSize)
    s = size(inImg);
    % Just in case i/p is a decimal
    kernelSize = round(kernelSize);
    if kernelSize > s(1) || kernelSize > s(2)
        disp('Kernel size cannot be bigger than the image.');
        return
    end
    % Calculating width for padding
    left_width = ceil((kernelSize - 1) / 2);
    right_width = kernelSize - 1 - left_width;
    top_width = left_width;
    bottom_width = right_width;
    paddedImg = padarray(padarray(padarray(padarray(double(inImg), [0, left_width], NaN, 'pre'), [0, right_width], NaN, 'post'), [top_width, 0], NaN, 'pre'), [bottom_width, 0], NaN, 'post');

    outImg = zeros(s);
    kernelCoef = 1 / (kernelSize ^ 2);
    kernel = kernelCoef * ones(kernelSize, kernelSize);
    for row = (1 + top_width):(top_width + s(1))
        for col = (1 + left_width):(left_width + s(2))
            conv = paddedImg((row - top_width):(row + bottom_width), (col - left_width):(col + right_width), :);
            outImg(row - top_width, col - left_width, :) = nansum(nansum(kernel .* conv));
        end
    end
    outImg = cast(outImg,'uint8');
end