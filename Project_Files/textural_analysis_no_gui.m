close all
clear
clc

img = imread('Brain1.jpg');
imggray = rgb2gray(img);
med1img = medfilt2(imggray);
med2img = im2double(imggray);
mean1img = filter2(fspecial('average', 3), imggray)/255;
mean2img = im2double(imggray);

count = 1;
array = zeros(1,25);

for row = 3: size(mean2img, 1) - 2
    for col = 3 : size(mean2img, 2) - 2
        for a = row - 2 : row + 2
            for b = col - 2 : col + 2
                array(count) = mean2img(a,b);
                count = count + 1;
            end
        end
        count = 1;
        average = mean(array);
        mean2img(row,col) = average;
    end
end
figure;
subplot(2,2,1);
imshow(mean1img);
title('Matlab mean');
subplot(2,2,2);
imshow(mean2img);
title('Filtered mean');
for row = 3: size(med2img,1) - 2
    for col = 3 : size(med2img, 2) - 2
        for a = row - 2 : row +2
            for b = col - 2 : col + 2
                array(count) = med2img(a,b);
                count = count + 1;
            end
        end
        count = 1;
        med2img(row, col) = median(array);
    end
end
subplot(2,2,3)
imshow(med1img);
title('Matlab median');
subplot(2,2,4)
imshow(med2img);
title('Filtered Median');
