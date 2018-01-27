function [outImg] = padBottom(inImg, width)
    width = ceil(width);
    if width < 0
        return
    end
    outImg = zeros(size(inImg, 1) + width, size(inImg, 2), size(inImg, 3));
    outImg(1:size(inImg, 1), :, :) = inImg;
    outImg((size(inImg, 1) + 1):end, :, :) = NaN;
end