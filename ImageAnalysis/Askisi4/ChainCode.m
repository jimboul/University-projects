%% Taking the number of pixels from the image below

I = imread('sea.jpg');
Igrayscale = rgb2gray(I);
Icontour = imcontour(Igrayscale);
%Ipixels = [size(I) 2];

%% Chain Code

chainCode = chain_code(Icontour);

%% Differential Chain Code

difChainCode = dif_chain_code(chainCode);