function [outImg] = swirlFilter(inImg, factor, ox, oy)
    if ox <= 0 || oy <= 0
        disp('The coordinates of the center cannot be zero or negative!');
        return
    end
    if abs(factor) > 5
        disp('Factor should be between -5 and 5!');
        return
    end
    % A negative factor should result in a counter-clockwise swirl and vice
    % versa
    normFactor = - (factor) / 100;

    % Initially the outImg is set to the inImg as not every point in the
    % inImg will map to a point whose coordinates are within outImg(after swirling).
    % For such pixels in outImg which don't map to a swirlled pixel of inImg,
    % the program chooses those pixels in inImg that are in the position that
    % the unmapped pixel(outImg) is in.
    %
    outImg = inImg;
    for row = 1:size(outImg, 1)
        for col = 1:size(outImg, 2)
            % convert row, col to x, y with ox, oy as origin.
            [curr_x, curr_y, thetaOffset] = convertToRectCoordinates(row, col, ox, oy);
            r = sqrt((curr_x ^ 2) + (curr_y ^ 2));
            curr_theta = atan(curr_y / curr_x) + thetaOffset;

            orig_theta = curr_theta - (r * normFactor);
            orig_x = cast(r * cos(orig_theta), 'int16');
            orig_y = cast(r * sin(orig_theta), 'int16');

            % convert orig_y, orig_x back to row and col.
            % ----------------------------------------------------
            % First and Second Quadrant
            if row <= oy
                orig_row = - abs(orig_y) + oy;
                orig_col = orig_x + ox;
            % Third and Fourth Quadrant
            elseif row > oy
                orig_row = abs(orig_y) + oy;
                orig_col = orig_x + ox;
            end
            % ----------------------------------------------------

             if orig_row > 0 && orig_row <= size(inImg, 1) &&...
                orig_col > 0 && orig_col <= size(inImg, 2)
                 outImg(row, col, :) = inImg(orig_row, orig_col, :);
             end
        end
    end
    outImg = cast(outImg, 'uint8');
end