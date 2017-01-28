function [recons_image]=receiver_woh(start_frame,first_frame,x_mv,y_mv,T_predic)

disp('Reconstruction of Image without Hidden Data');
[hd,wd,numberOfFrames]=size(x_mv);
recons_image(:,:,start_frame-1)=first_frame;

for Frameno=start_frame:numberOfFrames

    disp(['Frame being Processed :' int2str(Frameno)]);
    
    x_motion=x_mv(:,:,Frameno);
    y_motion=y_mv(:,:,Frameno);

    
%IMAGE RECONSTRUCTION
Tpred=T_predic.Tpred;

recons_im=temp_recons(recons_image(:,:,Frameno-1),x_motion,y_motion,Tpred(:,:,Frameno));

recons_im=uint8(recons_im);
figure();
imshow(uint8(recons_im));title(['Reconstructed Image using Motion Vectors without Hidden Data:: Frame:' int2str(Frameno)]);

    
    recons_image(:,:,Frameno)=uint8(recons_im);
    

end

end




