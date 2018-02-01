function [outImg] = swirlFilter(inImg, factor, ox, oy)
    if ox <= 0 || oy <= 0
        disp('The coordinates of the center cannot be zero or negative!');
        return
    end

    if abs(factor) > 100 || factor == 0
        disp('The factor must be within -100 to 100 and not zero')
        return
    end

    % modifing factor such that more the value more the swirl and not the
    % other way round.
    factor = sign(factor) * (100 - abs(factor));
    outImg = zeros(size(inImg));
    for row = 1:size(inImg,1)
        for col = 1:size(inImg,2)
            % Convert (x, y) to (r, theta) using r = sqrt(x^2 + y^2) and
            % theta = inv_tan(y/x)
            curr_x = row - ox;
            curr_y = col - oy;
            orig_theta = atan2(curr_y, curr_x);
            orig_radius = sqrt((curr_x ^ 2) + (curr_y ^ 2));

            % Swirl angle based on current radius
            swirled_theta = orig_theta + (orig_radius / factor);

            % Covert (r, theta) to (x, y) using x = r.cos(theta) and y =
            % r.sin(theta)
            swirled_x = orig_radius * cos(swirled_theta);
            swirled_y = orig_radius * sin(swirled_theta);
            swirled_xTrue = limitBetween(ceil(swirled_x) + ox, 1, size(inImg, 1));
            swirled_yTrue = limitBetween(ceil(swirled_y) + oy, 1, size(inImg, 2));

            outImg(row, col, :) = inImg(swirled_xTrue, swirled_yTrue, :);
        end
    end
    outImg = cast(outImg, 'uint8');
end