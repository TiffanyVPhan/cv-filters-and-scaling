function [superImposedImg] = famousMe(imageOfMe, baseImg, padLeft, padTop)
    if padLeft < 0 || padTop < 0
        disp('Left and right padding cannot be negative');
        return;
    end

    imageOfMe = imresize(imageOfMe, [200, 300]);
    baseImg = imresize(baseImg, [512, 512]);

    superImposedImg = baseImg;
    binaryMask = zeros(size(imageOfMe, 1), size(imageOfMe, 2));
    for row = 1:size(imageOfMe, 1)
        for col = 1:size(imageOfMe, 2)
             gray = ((0.299 * imageOfMe(row, col, 1)) + (0.587 * imageOfMe(row, col, 2)) + (0.114 * imageOfMe(row, col, 3)));
              if gray > 20 && gray < 65
                  gray = 0;
              else
                  gray = 255;
              end
             binaryMask(row, col) = gray;
         end
     end
    binaryMask = (cast(binaryMask, 'uint8') / 255) .* imageOfMe;

     for row = 1:size(binaryMask, 1)
         for col = 1:size(binaryMask, 2)
             if binaryMask(row, col, :) ~= 0
                    superImposedImg(row + padTop, col + padLeft, :) = binaryMask(row, col, :);
             end
         end
     end
end