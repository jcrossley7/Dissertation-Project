close all
clear
clc

img = imread('lowgrade\9.jpg');
bwimg = rgb2gray(img);
medImg = medfilt2(bwimg);
BWent = im2bw_ent(medImg);
fprintf('Threshold is %6.4f.\n', BWent);
bwMed = (medImg>=BWent);
%bwMed = im2bw(medImg, 0.4);
%imshow(bwMed);
label = bwlabel(bwMed);
stats = regionprops(label, 'Solidity', 'Area');
density = [stats.Solidity];
area = [stats.Area];
high_dense_area = density > 0.5;
max_area = max(area(high_dense_area));
tumour_label = find(area == max_area);
tumour = ismember(label, tumour_label);
            
se = strel('square', 5);
tumour = imdilate(tumour,se);
figure

subplot(1,6,1)
imshow(img,[])
title('Brain')

subplot(1,6,2)
imshow(bwMed,[])
title('Binarized')

subplot(1,6,3)
imshow(tumour,[])
title('Tumour')

[B,L] = bwboundaries(tumour, 'noholes');
subplot(1,6,4)
imshow(img)
hold on
for i = 1:length(B)  
    plot(B{i}(:,2), B{i}(:,1), 'y', 'linewidth', 1.45)
end
title('Detected Tumours')
hold off
fullTumour = img.*uint8(tumour);
subplot(1,6,5);
imshow(fullTumour);
title('Segmented Tumour');
fractalTumour = ~(im2bw(fullTumour));
subplot(1,6,6);
imagesc(fractalTumour);
colormap gray;
tic
dim_val = BoxCountfracDim(fractalTumour);
toc
fprintf('Fractal Dimension is equal to %6.4f.\n', dim_val);
entropy = entropy(fullTumour);
fprintf('Entropy is equal to %6.4f.\n', entropy);
fprintf('Area is equal to %6.4f.\n', max_area);
fprintf('Solidity is equal to %6.4f.\n', mean(density));