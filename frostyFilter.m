function [outImg] = frostyFilter(inImg, n, m)
    if n < 0 || m < 0
        disp('Window size cannot be negative')
        return
    end
    left_width = ceil((m - 1) / 2);
    right_width = m - 1 - left_width;
    top_width = ceil((n - 1) / 2);
    bottom_width = n - 1 - top_width;
    paddedImg = padarray(padarray(padarray(padarray(double(inImg), [0, left_width], 'replicate', 'pre'), [0, right_width], 'replicate', 'post'), [top_width, 0], 'replicate', 'pre'), [bottom_width, 0], 'replicate', 'post');

    outImg = zeros(size(inImg));
    for row = (1 + top_width):(top_width + size(inImg, 1))
        for col = (1 + left_width):(left_width + size(inImg, 2))
            neighbors = paddedImg((row - top_width):(row + bottom_width), (col - left_width):(col + right_width), :);
            outImg(row - top_width, col - left_width, :) = neighbors(randi([1, n]), randi([1, m]), :);
        end
    end
    outImg = cast(outImg, 'uint8');
end