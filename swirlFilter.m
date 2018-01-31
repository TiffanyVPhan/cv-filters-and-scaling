function [outImg] = swirlFilter(inImg, factor, ox, oy)
    if factor > 5 || factor < 0
        disp('Factor should be between 0 and 5!');
        return
    end
    normFactor = factor / 100;
    outImg = inImg;
    for row = 1:size(outImg, 1)
        for col = 1:size(outImg, 2)
            [curr_x, curr_y, thetaOffset] = convertToRectCoordinates(row, col, ox, oy);
            r = sqrt((curr_x ^ 2) + (curr_y ^ 2));
            curr_theta = atan(curr_y / curr_x) + thetaOffset;

            orig_theta = curr_theta - (r * normFactor);
            orig_x = cast(r * cos(orig_theta), 'int16');
            orig_y = cast(r * sin(orig_theta), 'int16');

            % convert orig_y, orig_x back to row and col.
            % -----------------------------------------------
            % First and Second Quadrant
            if row <= oy
                orig_row = - abs(orig_y) + oy;
                orig_col = orig_x + ox;
            % Third and Fourth Quadrant
            elseif row > oy
                orig_row = abs(orig_y) + oy;
                orig_col = orig_x + ox;
            end
            % -----------------------------------------------

            if orig_row > 0 && orig_row <= size(inImg, 1) &&...
               orig_col > 0 && orig_col <= size(inImg, 2)
                outImg(row, col, :) = inImg(orig_row, orig_col, :);
            end
        end
    end
    outImg = cast(outImg, 'uint8');
end