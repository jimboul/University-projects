%% Exercise 6.16

I = imread('Audi S1.jpg');
imshow(I)
figure;
axis off
title('RGB image')

fprintf('Program paused. Press enter to continue.\n');
pause;

Igrayscale = rgb2gray(I);
imshow(Igrayscale)
figure;
axis off
title('Grayscale image')
imwrite(Igrayscale,'Audi S1 (grayscale).jpg');

fprintf('Program paused. Press enter to continue.\n');
pause;

prompt = 'How many quantization levels would you like to simulate?\n';
quant_levels = input(prompt);
thresh = multithresh(Igrayscale,quant_levels - 1);
valuesMax = [thresh max(I(:))];
[quant_Igrayscale_max, index] = imquantize(Igrayscale,thresh,valuesMax);
imshow(quant_Igrayscale_max)
imwrite(quant_Igrayscale_max,'Quantized Audi S1.jpg');
valuesMin = [min(I(:)) thresh];
quant_Igrayscale_min = valuesMin(index);

imshowpair(quant_Igrayscale_min,quant_Igrayscale_max,'montage')
title('Minimum Interval Value           Maximum Interval Value')
figure;

fprintf('Program paused. Press enter to continue.\n');
pause;

Irle_encoded = run_length_encoding(Igrayscale);
imwrite(Irle_encoded,'Encoded Audi S1.jpg');

