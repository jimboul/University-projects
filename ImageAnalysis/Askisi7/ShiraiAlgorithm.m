
I1 = imread('nasa_left.jpg');
I2 = imread('nasa_right.jpg');
figure
imshow(stereoAnaglyph(I1,I2));
title('Red-cyan composite view of the stereo images');
disparityRange = [-6 10];
disparityMap = disparity(rgb2gray(I1),rgb2gray(I2),'BlockSize',...
    15,'DisparityRange',disparityRange);
figure
imshow(disparityMap,disparityRange);
title('Disparity Map');
colormap jet
colorbar