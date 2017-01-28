%% Exercise 8.17 (Multimedia Systems)

%% Part A
%Open an sample avi file
vid = VideoReader('xylophone.mpg');

% getting no of frames
number_of_frames = vid.NumberOfFrames;
%number_of_frames = vid.NumberOfFrames;
fprintf('The number of frames of our video is: %d\n',number_of_frames);

fprintf('Program paused. Press enter to continue.\n');
pause;

mov2 = read(vid);
implay(mov2);

fprintf('Program paused. Press enter to continue.\n');
pause;

%frameError_video = getFramesVideo(mov,number_of_frames);

% while hasFrame(vid)
%     frame_error = readFrame(vid);
% end
% 
% for i = 2:number_of_frames
%     frame_error(i-1) = imabsdiff(vid(i),vid(i-1));
%     newFrame(i-1) = im2frame(frame_error(i-1));
% end
% movie(newFrame,1,30);

% Below is an alternative way to construct a video by frames
% FrameError = VideoWriter('new_frame_video');
% open(FrameError)
% writeVideo(FrameError,frameError_video);
% close(v);

new_mov = diff(mov2,1,4);
new_vid = VideoWriter('xylophone_segmentation');
open(new_vid)
writeVideo(new_vid,new_mov);
close(new_vid)
implay('xylophone_segmentation.avi');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% Part B

%Open an sample avi file
filename = 'xylophone';
mov=read_video(filename);

%getting no of frames
numberOfFrames = length(mov);
%User Defined parameters for the project 
start_frame=25;   % cannot be less than 2
Frames=5;
%Frames=numberOfFrames;
Txt='Well Begun is Half Done';
motion_trsh=6;


disp(['Total Number of Frames : ' int2str(numberOfFrames)]);
%disp(['Total Number of Frames Selected : 50' ]);
disp(['No of Frames selected for processing : ' int2str(Frames)]);


[im_grey,im_U,im_V]=read_files(start_frame+Frames+2,filename);
first_frame=im_grey(:,:,start_frame-1);
[ht,wd,n]=size(im_grey);
disp(['Frame Image Size in pixels : ' int2str(ht) 'x' int2str(wd)]);

%Considering IBBPBBI format
figure();
subplot(1,3,1);
imshow(im_grey(:,:,1));
title('Original I Frame');
subplot(1,3,2);
imshow(im_grey(:,:,2));
title('Original B Frame');
subplot(1,3,3);
imshow(im_grey(:,:,4));
title('Original P Frame');


disp('Encode Starts.....');
[x_mv,y_mv,x_mv_hid,y_mv_hid,T_pred,capacity]=transmitter(im_grey,Frames,start_frame,Txt,motion_trsh);
disp('Encoding & Data Hiding over');

s = sprintf('\n');disp(s);
disp('TRANSMISSION');
disp(s);

disp('Decoding Without Hidden Data starts');
[recons_im_wo]=receiver_woh(start_frame,first_frame,x_mv,y_mv,T_pred);

disp('Decoding Without Hidden Data starts');
[recons_im,recons_im_ins,recov_txt]=receiver(start_frame,first_frame,x_mv_hid,y_mv_hid,T_pred,motion_trsh);
%[r,c,frame]=size(recons_im);

j=0;
for i=start_frame:Frames+start_frame-1
    j=j+1;
    images(:,:,:,j)=yuv2rgb(cat(3,recons_im(:,:,i),im_U(:,:,i),im_V(:,:,i)));   
    images_rgb=images;
end

% write the recovered Images into video file
videoObj = VideoWriter('recovered_video.avi');
open(videoObj);
writeVideo(videoObj,images_rgb);
close(videoObj);

%Read the recovered video file and play it
videoObject = VideoReader('recovered_video.avi');

fprintf('Program paused. Press enter to continue.\n');
pause;

implay('recovered_video.avi');

fprintf('Program paused. Press enter to continue.\n');
pause;

nFrames = videoObject.NumberOfFrames;
vidHeight = videoObject.Height;
vidWidth = videoObject.Width;
movv(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
% Read one frame at a time.
for k = 1 : nFrames
    movv(k).cdata = read(videoObject, k);
end
hf = figure;
set(hf, 'position', [150 150 vidWidth vidHeight])
% Play back the movie once at the video's frame rate.
movie(hf, movv, 1, videoObject.FrameRate);

disp(s);
disp('Videos Reconstructed from Motion Vectors.');
disp(['The Recovered Text is :' recov_txt]);

%PSNR calculation
for i=start_frame:Frames+start_frame -1
    psnr_value(i)=PSNR(im_grey(:,:,i),recons_im_wo(:,:,i));
    psnr_value_hid(i)=PSNR(im_grey(:,:,i),recons_im_ins(:,:,i));
    psnr_value_extr(i)=PSNR(im_grey(:,:,i),recons_im(:,:,i));
end

figure(),plot(start_frame:start_frame+Frames-1, psnr_value_extr(start_frame:start_frame+Frames-1), 'r'),hold on,
plot(start_frame:start_frame+Frames-1, psnr_value_hid(start_frame:start_frame+Frames-1), 'b'),
title('PSNR between Original Image and Reconstructed Image'), 
legend('After Hidden Data Extraction','Without Extraction')
ylabel('PSNR value'),xlabel('Frame Number'), hold off;


% Embedding Capacity Average
em_capacity=mean(capacity(:,start_frame:start_frame+Frames-1),2);
figure(), plot(em_capacity);xlabel('Threshold Value'),ylabel('Embedding capacity'), title(['Embedding capacity Vs Threshold Value']);



