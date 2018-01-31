function [x, y, thetaOffset] = convertToRectCoordinates(row, col, ox, oy)
     % Second Quadrant
    if row <= oy && col <=ox
        x = - abs(col - ox);
        y = abs(row - oy);
        thetaOffset = pi;
    % Third Quadrant
    elseif row > oy && col <= ox
        x = - abs(col - ox);
        y = - abs(row - oy);
        thetaOffset = pi;
    % Fourth Quadrant
    elseif row > oy && col > ox
        x = abs(col - ox);
        y = - abs(row - oy);
        thetaOffset = 0;
    % First Quadrant
    else
        x = abs(col - ox);
        y = abs(row - oy);
        thetaOffset = 0;
    end
end