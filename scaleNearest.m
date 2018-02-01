function [outImg] = scaleNearest(inImg, factor)
    if factor < 0
        disp('Factor cannot be less than 0');
    end

    outImg = zeros(round(factor * size(inImg, 1)), round(factor * size(inImg, 2)), size(inImg ,3));

    for row = 1:size(outImg, 1)
        for col = 1:size(outImg, 2)
            in_row = calcNearestNeighborCoordinates(row, factor, size(inImg, 1));
            in_col = calcNearestNeighborCoordinates(col, factor, size(inImg, 2));
            outImg(row, col, :) = inImg(in_row, in_col, :);
        end
    end
    outImg = cast(outImg, 'uint8');
end