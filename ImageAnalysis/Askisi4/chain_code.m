function [chain] = chain_code(Image)
% chain_code: Generate an 8 connected chain from an image 
%   
% input: an image path - should contain a single connected contour
% output: [Nx2] 8 connected chain of N coordinates
%

Image = Image(:,:,1);

% Get first connected component
[start_r,start_c] = find(Image,1,'first');

% As bwtraceboundary needs an intial direction, so choose the first one that works
if Image(logical(start_r+1),logical(start_c+1)) == 255
    dir = 'SE';
elseif Image(logical(start_r),logical(start_c+1)) == 255
    dir = 'E';
elseif Image(logical(start_r-1),logical(start_c+1)) == 255
    dir = 'NE';
elseif Image(logical(start_r-1),logical(start_c)) == 255
    dir = 'N';
elseif Image(logical(start_r-1),logical(start_c-1)) == 255
    dir = 'NW';
elseif Image(logical(start_r),logical(start_c-1)) == 255
    dir = 'W';
elseif Image(logical(start_r+1),logical(start_c-1)) == 255
    dir = 'SW';
elseif Image(logical(start_r+1),logical(start_c)) == 255
    dir = 'S';
else
    dir = 'W';
end

chain = bwtraceboundary(Image,[start_r,start_c],dir,8,Inf,'counterclockwise');