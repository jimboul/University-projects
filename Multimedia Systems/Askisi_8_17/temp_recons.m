

function [recons_im]=temp_recons(im_old,x_motion,y_motion,pred_err)

N = 8;      % block size is N x N pixels
W = 2*N;     % search window size is W x W pixels
N2=2*N;

%x_motion=x_motion/100;
%y_motion=y_motion/100;

% Make image size divisible by 8
[X,Y] = size(im_old);
if mod(X,N)~=0
    Height = floor(X/N)*N;  % cut off the extra rows if not divisible by N
else
    Height = X;             % else keep as it is
end
if mod(Y,N)~=0
    Width = floor(Y/N)*N;   % cut off the extra cols if not divisible by N
else
    Width = Y;              % else Keep as it is
end
clear X Y Z


% pad input images on left, right, top, and bottom
% padding by replicating works better than padding w/ zeros, which is 
% better than symmetric which is better than circular


im_old1 = double(padarray(im_old,[W/2 W/2],'replicate'));

for rows = 1:N:Height
    rblk = floor(rows/N) + 1;  % Row Block No
    for cols = 1:N:Width
        cblk = floor(cols/N) + 1;   % Collumn Block No
        x1 = x_motion(rblk,cblk); y1 = y_motion(rblk,cblk); % take correspionding motion vector

        %recons img= old imaage moved by motion vectors + prediction error
        Br(rows:rows+N-1,cols:cols+N-1) = im_old1(rows+N+y1:rows+y1+N2-1,cols+N+x1:cols+x1+N2-1)+pred_err(rows:rows+N-1,cols:cols+N-1);
    end
end
recons_im=Br;







