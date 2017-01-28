
C = bsxfun(@(x,y)hypot(x-50,y-50)<25,1:100,(1:100).'); % The image of a circle
figure;imshow(C)                                              %
tform = [1 0 0;0.6 1 0;0 0 1];                         % The transformation matrix
tform = affine2d(tform);                               % 2-D Affine Geometric Transformation
C2 = imwarp(C,tform);                                  % Apply geometric transformation to image
figure;imshow(C2)                                             