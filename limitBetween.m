function [resultantCoordinate] = limitBetween(coordinate, lowerLimit, upperLimit)
    if coordinate < lowerLimit
        resultantCoordinate = lowerLimit;
    elseif coordinate > upperLimit
        resultantCoordinate = upperLimit;
    else
        resultantCoordinate = coordinate;
    end
end