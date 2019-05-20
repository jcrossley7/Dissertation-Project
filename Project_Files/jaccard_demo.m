close all
clear
clc

img = imread('brain1.jpg');
img2 = rgb2gray(img);
medImg = medfilt2(img2);
avgImg = filter2(fspecial('average', 3), img2)/255;
bwMed = im2bw(medImg, 0.7);
bwAvg = im2bw(avgImg, 0.7);
similarity = jaccard(bwMed, bwAvg);
imshowpair(bwMed, bwAvg)
title(['Jaccard Index = ' num2str(similarity)]);

labelM = bwlabel(bwMed);
labelA = bwlabel(bwAvg);
statsM = regionprops(labelM, 'Solidity', 'Area');
statsA = regionprops(labelA, 'Solidity', 'Area');
density = [statsM.Solidity];
area = [statsM.Area];
density2 = [statsA.Solidity];
area2 = [statsA.Area];

high_dense_area1 = density > 0.5;
max_area1 = max(area(high_dense_area1));
tumour_label1 = find(area == max_area1);
tumour1 = ismember(labelM, tumour_label1);
high_dense_area2 = density2 > 0.5;
max_area2 = max(area(high_dense_area2));
tumour_label2 = find(area2 == max_area2);
tumour2 = ismember(labelA, tumour_label2);
            
se = strel('square', 5);
tumour1 = imdilate(tumour1,se);
tumour2 = imdilate(tumour2,se);

similarity2 = jaccard(tumour1, tumour2);
imshowpair(tumour1, tumour2)
title(['Jaccard Index = ' num2str(similarity2)]);

figure(2)

subplot(1,3,1)
imshow(img,[])
title('Brain')

subplot(1,3,2)
imshow(tumour1,[])
title('Tumour')

[B,L] = bwboundaries(tumour1, 'noholes');
subplot(1,3,3)
imshow(img)
hold on
for i = 1:length(B)  
    plot(B{i}(:,2), B{i}(:,1), 'y', 'linewidth', 1.45)
end
title('Detected Tumours')
hold off