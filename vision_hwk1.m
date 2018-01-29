% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% your information
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear variables;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gauss Filter', 'Frosty Filter', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
           choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gauss Filter', 'Frosty Filter', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek');
           switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename = 'mandril1.jpg';
               case 3
                   filename = 'sully.bmp';
               case 4
                   filename = 'yoda.bmp';
               % fill in cases for all the images you plan to use
           end
           current_img = imread(filename);
       case 3
           % Display image
           figure
           imagesc(current_img);
           if size(current_img,3) == 1
               colormap gray
           end
           
       case 4
           % Mean Filter
           
           % 1. Ask the user for size of kernel
           ip = inputdlg('Enter the Kernel size');
           k_size = str2double(ip{:});

           % 2. Call the appropriate function
           newImage = meanFilter(current_img, k_size); % create your own function for the mean filter
           
           % 3. Display the old and the new image using subplot
           % ....
           figure
           subplot(1, 2, 1)
           imagesc(current_img)

           subplot(1, 2, 2)
           imagesc(newImage)
           title('Mean filter');

           % 4. Save the newImage to a file
           imwrite(newImage, 'Mean-Filter.jpg');
              
       case 5
           % Gaussian Blur Filter

           % 1. Ask the user for Sigma
           ip = inputdlg('Enter the value of sigma');
           sigma = str2double(ip{:});

           % 2. Call the appropriate function
           newImage = gaussFilter(current_img, sigma);

           % 3. Display the old and the new image using subplot
           % ....
           figure
           subplot(1, 2, 1)
           imagesc(current_img)

           subplot(1, 2, 2)
           imagesc(newImage)
           title('Gaussian Blur filter');

           % 4. Save the newImage to a file
           imwrite(newImage, 'Gauss-Filter.jpg');

       case 6
           % Frosty Filter

           % 1. Ask the user for n and m
           ip = inputdlg('Enter the number of rows of the window(N)');
           n = str2double(ip{:});
           ip = inputdlg('Enter the number of columns of the window(M)');
           m = str2double(ip{:});


           % 2. Call the appropriate function
           newImage = frostyFilter(current_img, n, m);

           % 3. Display the old and the new image using subplot
           % ....
           figure
           subplot(1, 2, 1)
           imagesc(current_img)

           subplot(1, 2, 2)
           imagesc(newImage)
           title('Frosty filter');

           % 4. Save the newImage to a file
           imwrite(newImage, 'Frosty-Filter.jpg');

       case 7
           % Scale using Nearest Neighbor Algorithm

           % 1. Ask the user for factor
           ip = inputdlg('Enter the factor to scale by');
           factor = str2double(ip{:});

           % 2. Call the appropriate function
           newImage = scaleNearest(current_img, factor);

           % 3. Display the old and the new image using subplot
           % ....
           figure
           subplot(1, 2, 1)
           imagesc(current_img)
           title('Original Image');

           subplot(1, 2, 2)
           imagesc(newImage)
           title('NN Scaled Image');

           % 4. Save the newImage to a file
           imwrite(newImage, 'Scale-Nearest.jpg');

       case 8
           % Scale image using Bilinear technique

           % 1. Ask the user for factor
           ip = inputdlg('Enter the factor to scale by');
           factor = str2double(ip{:});

           % 2. Call the appropriate function
           newImage = scaleBilinear(current_img, factor);

           % 3. Display the old and the new image using subplot
           % ....
           figure
           subplot(1, 2, 1)
           imagesc(current_img)

           subplot(1, 2, 2)
           imagesc(newImage)
           title('Bilinear Scaled Image');

           % 4. Save the newImage to a file
           imwrite(newImage, 'Scale-Bilinear.jpg');

       case 9
           % Swirl Filter

           % 1. Ask the user for factor
           answer = inputdlg('Factor between 0 and 5 (0 - No swirl, 5 - Full Swirl)');
           factor = str2double(answer{:});

           s = size(current_img);
           default = sprintf('%g %g', floor(s(2) / 2), floor(s(1) / 2 ));
           answer = inputdlg('Coordinates of center of Swirl (separated by space)',...
                             'Input', 1, {default});
           coord = str2num(answer{:});
           ox = coord(1);
           oy = coord(2);

           % 2. Call the appropriate function
           newImage = swirlFilter(current_img, factor, ox, oy);

           % 3. Display the old and the new image using subplot
           % ....
           figure
           subplot(1, 2, 1)
           imagesc(current_img)

           subplot(1, 2, 2)
           imagesc(newImage)
           title('Swirl Filter');

           % 4. Save the newImage to a file
           imwrite(newImage, 'Swirl-Filter.jpg');

       case 10
           % Famous Me

           % Load an image
           image_choice = menu('Choose an image of yourself', 'me');
           switch image_choice
               case 1
                   filename = 'me.jpeg';
               % fill in cases for all the images you plan to use
           end
           imageOfMe = imread(filename);

           image_choice = menu('Choose a base image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek');
           switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename = 'mandril1.jpg';
               case 3
                   filename = 'sully.bmp';
               case 4
                   filename = 'yoda.bmp';
               % fill in cases for all the images you plan to use
           end

           baseImg = imread(filename);

           % 2. Call the appropriate function
           superImposedImg = famousMe(imageOfMe, baseImg, 250, 200);

           % 3. Display the old and the new image using subplot
           % ....
           figure
           subplot(1, 3, 1)
           imagesc(imageOfMe)
           title('Image of you');

           subplot(1, 3, 2)
           imagesc(baseImg)
           title('Base Image');

           subplot(1, 3, 3)
           imagesc(superImposedImg)
           title('You are Famous!');

           % 4. Save the newImage to a file
           imwrite(superImposedImg, 'Famous-Me.jpg');
           
       %....
   end
   % Display menu again and get user's choice
   choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gauss Filter', 'Frosty Filter', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
end
