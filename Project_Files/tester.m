I = imread("brain3.jpg");
I2 = medianFilter(I);
imshow(I);
[L, C] = imsegkmeans(I,3);
B = labeloverlay(I,L);
J = imsegkmeans(I, 3);
imshow(J);
