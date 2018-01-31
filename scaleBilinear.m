function [outImg] = scaleBilinear(inImg, factor)
    if factor < 0
        disp('Factor cannot be less than 0');
    end

    paddedImg = padarray(padarray(double(inImg), [0, 1], 'replicate', 'post'), [1, 0], 'replicate', 'post');
    
    outImg = zeros(round(factor * size(inImg, 1)), round(factor * size(inImg, 2)), size(inImg ,3));  
    for row = 1:size(outImg, 1)
        for col = 1:size(outImg, 2)
            topLeftRowIndex = ceil(row/factor);
            topLeftColIndex = ceil(col/factor);

            topLeft = paddedImg(topLeftRowIndex, topLeftColIndex, :);
            topRight = paddedImg(topLeftRowIndex, topLeftColIndex + 1, :);
            bottomLeft = paddedImg(topLeftRowIndex + 1, topLeftColIndex, :);
            bottomRight = paddedImg(topLeftRowIndex + 1, topLeftColIndex + 1, :);
            
            nearestMultipleCol = (floor(col / factor) * factor)  + 1;
            nearestMultipleRow = (floor(row / factor) * factor)  + 1;
            linearOne = (((topRight - topLeft) / factor) * (col - nearestMultipleCol)) + topLeft;
            linearTwo = (((bottomRight - bottomLeft) / factor) * (col - nearestMultipleCol)) + bottomLeft;

            outImg(row, col, :) = (((linearTwo - linearOne) / factor) * (row - nearestMultipleRow)) + linearOne;
            
        end
    end
    outImg = cast(outImg, 'uint8');
end