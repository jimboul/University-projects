
%% Central Moments

I = imread('frog.bmp');
Idouble = im2double(I);
central_moments = moment(Idouble,3);
disp(central_moments)

%% Invariant Moments

% First Moment
n20=cent_moment(2,0,I);
n02=cent_moment(0,2,I);
M1=n20+n02;

% Second Moment
n20=cent_moment(2,0,I);
n02=cent_moment(0,2,I);
n11=cent_moment(1,1,I);
M2=(n20-n02)^2+4*n11^2;

% Third Moment
n30=cent_moment(3,0,I);
n12=cent_moment(1,2,I);
n21=cent_moment(2,1,I);
n03=cent_moment(0,3,I);
M3=(n30-3*n12)^2+(3*n21-n03)^2;

% Fourth Moment
n30=cent_moment(3,0,I);
n12=cent_moment(1,2,I);
n21=cent_moment(2,1,I);
n03=cent_moment(0,3,I);
M4=(n30+n12)^2+(n21+n03)^2;

% Fifth Moment
n30=cent_moment(3,0,I);
n12=cent_moment(1,2,I);
n21=cent_moment(2,1,I);
n03=cent_moment(0,3,I);
M5=(n30-3*n21)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)+(3*n21-n03)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);

% Sixth Moment
n20=cent_moment(2,0,I);
n02=cent_moment(0,2,I);
n30=cent_moment(3,0,I);
n12=cent_moment(1,2,I);
n21=cent_moment(2,1,I);
n03=cent_moment(0,3,I);
n11=cent_moment(1,1,I);
M6=(n20-n02)*((n30+n12)^2-(n21+n03)^2)+4*n11*(n30+n12)*(n21+n03);

% Seventh Moment
n30=cent_moment(3,0,I);
n12=cent_moment(1,2,I);
n21=cent_moment(2,1,I);
n03=cent_moment(0,3,I);
M7=(3*n21-n03)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)-(n30+3*n12)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);

% The vector M is a column vector containing M1,M2,....M7
% Feature vector
M=[M1    M2     M3    M4     M5    M6    M7]';

disp(M)
