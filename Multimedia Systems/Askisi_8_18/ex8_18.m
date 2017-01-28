
%% Exercise 8.18 (Multimedia Systems)

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

for i = 1:number_of_frames
    dt_obj = vision.Deinterlacer;
    dt_img = step(dt_obj,mov2(:,:,:,i));
    imshow(mov2(:,:,:,i)); 
    %imshow(dt_img);
    title('Original Image');
    figure, imshow(dt_img); 
    title('Image after deinterlacing');
end

new_vid = VideoWriter('xylophone_deinterlacing');
open(new_vid)
writeVideo(new_vid,mov2);
close(new_vid)
implay('xylophone_deinterlacing.avi');


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

% new_mov = diff(mov2,1,4);
% new_vid = VideoWriter('xylophone_segmentation');
% open(new_vid)
% writeVideo(new_vid,new_mov);
% close(new_vid)
% implay('xylophone_segmentation.avi');
% 
% fprintf('Program paused. Press enter to continue.\n');
% pause;
