function [nearestNeighbour] = calcNearestNeighborCoordinates(coordinate, factor, limit)
    nearestNeighbour = round(coordinate / factor);
    if nearestNeighbour <= 0
        nearestNeighbour = 1;
    elseif nearestNeighbour > limit
        nearestNeighbour = limit;
    end
end