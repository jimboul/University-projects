
BW = imread('text.png');
BWdouble = im2double(BW);
CC = bwconncomp(BW);
L = labelmatrix(CC);
measurements = regionprops(L, 'Area', 'Perimeter');
allAreas = [measurements.Area];
allPerimeters = [measurements.Perimeter];
circularities = allPerimeters .^ 2 ./ (4 * pi * allAreas);
disp(circularities)

%orthogonal_matrices = dot(BWdouble,BWdouble')
[Q,R] = qr(BWdouble);
disp(Q)
disp(R)