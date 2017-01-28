
function [im_grey,im_U,im_V]=read_files(varargin)

nargs = length(varargin);
if nargs==1
    nframes=varargin{1};
    vid_name='xylophone';
elseif nargs==2
    nframes=varargin{1};
    vid_name=varargin{2};
end



%Read Images
for i=1:nframes
    %Deduce the File Name
    j=i-1; 
    suffix='.png';
    file=[vid_name,'\',num2str(j),suffix];
    
    a(:,:,:,i)=imread(file);        %Read Image
    YUV=rgb2yuv(a(:,:,:,i),0);      %Convert into YUV
    im_grey(:,:,i)=YUV(:,:,1); 
    im_U(:,:,i)=YUV(:,:,2);
    im_V(:,:,i)=YUV(:,:,3);
end

end


