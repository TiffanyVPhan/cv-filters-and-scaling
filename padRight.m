function [outImg] = padRight(inImg, width)
    width = ceil(width);
    if width < 0
        return
    end
    outImg = zeros(size(inImg, 1), size(inImg, 2) + width, size(inImg, 3));
    outImg(:, 1:size(inImg, 2), :) = inImg;
    outImg(:, (size(inImg, 2) + 1):end, :) = NaN;
end