function images=yuv2rgb(YUV)


Y = double(YUV(:,:,1));
U = double(YUV(:,:,2));
V = double(YUV(:,:,3));

%Conversion Formula
R =uint8( 1 * Y + 0  * U + 1.4022* V);
G = uint8(1 * Y  -0.3456  * U  -0.7145* V);
B= uint8(1 * Y + 1.7710  * U + 0 * V );


image=cat(3,uint8(R),uint8(G),uint8(B));

images=ycbcr2rgb(YUV);
end
