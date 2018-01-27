function [outImg] = padTop(inImg, width)
    width = ceil(width);
    if width < 0
        return
    end
    outImg = zeros(size(inImg, 1) + width, size(inImg, 2), size(inImg, 3));
    outImg(1:width, :, :) = NaN;
    outImg((width + 1):end, :, :) = inImg;
end