function [mappedCoordinate] = mapRowColOfOutToInImg(coordinate, factor, limit)
    % Scaling down the coordinate of outImg to the coordinate of the inImg
    % and limiting the results to the max size of the inImg.
    c = ceil(coordinate/factor);
    mappedCoordinate = c - (mod(c, limit) * floor(c / limit));
end