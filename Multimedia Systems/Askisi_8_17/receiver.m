function [recons_image,recons_image_ins,recov_txt]=receiver(start_frame,first_frame,x_mv,y_mv,T_predic,motion_trsh)



recov_txt='';
[hd,wd,numberOfFrames]=size(x_mv);
recons_image(:,:,start_frame-1)=first_frame;

for Frameno=start_frame:numberOfFrames

    s=sprintf('\n');disp(s);
    disp(['Frame being Processed :' int2str(Frameno)]);
    
    x_motion=x_mv(:,:,Frameno);
    y_motion=y_mv(:,:,Frameno);

%IMAGE RECONSTRUCTION
Tpred=T_predic.Tpred;
recons_im=temp_recons(recons_image(:,:,Frameno-1),x_motion,y_motion,Tpred(:,:,Frameno));
recons_im=uint8(recons_im);
recons_image_ins(:,:,Frameno)=recons_im;
figure();
imshow(uint8(recons_im));title(['Reconstructed Image using Motion Vectors with Hidden Text:: Frame:' int2str(Frameno)]);

%Magnidute Calculation
mv_mag=sqrt(double(x_motion.^2 +y_motion.^2));
disp('Magnitude of Motion Vector Calculated');
N=8;
figure, imshow(recons_im), title(['Magnitude of Motion Vectors:: Frame:' int2str(Frameno)]),hold on;
[ht,wd]=size(mv_mag);
for i=1:ht
    for j=1:wd
        c=(i-1)*N+1;r=(j-1)*N+1;
        rectangle('Position',[r,c,N,N]);
        text(r+N/2,c+N/2,int2str(mv_mag(i,j)),'fontsize', 6);
    end
end
hold off;

% Phase Calculation
mv_phase=atan(double(x_motion./y_motion));
disp('Phase of Motion Vector Calculated');
N=8;
figure, imshow(recons_im), title(['Phase of Motion Vectors:: Frame:' int2str(Frameno)]),hold on;
[ht,wd]=size(mv_phase);
for i=1:ht
    for j=1:wd
        c=(i-1)*N+1;r=(j-1)*N+1;
        rectangle('Position',[r,c,N,N]);
        text(r+N/2,c+N/2,int2str(mv_phase(i,j)),'fontsize', 6);
    end
end
hold off;


%Thresholding
figure, imshow(recons_im), title(['Selected Motion Vectors:: Frame:' int2str(Frameno)]),hold on;
[ht,wd]=size(mv_mag);
index=0;N=8;
for i=1:ht
    for j=1:wd
        if mv_mag(i,j)>=motion_trsh
            c=(i-1)*N+1;r=(j-1)*N+1;
            rectangle('Position',[r,c,N,N]);
            mb(i,j)=1;
            index=index+1;
        else
            mb(i,j)=0;
        end
    end
end
hold off;
disp('Thresholding Done');
mb=T_predic.pred(:,:,Frameno);
index=numel(find(mb==1));
disp(['Total No of Motion Vectors in this Frame :' int2str(ht*wd)]);
disp(['No of Motion Vectors seleted for decoding from this Frame :' int2str(index)]);

% gather the motion vectors that can be used
[a,b]=find(mb==1);
for i=1:length(a)
    em_data_x(i)=abs(x_motion(a(i),b(i)));
    em_data_y(i)=abs(y_motion(a(i),b(i)));
end
siz=floor(length(a)/8);
siz=T_predic.prediction(:,:,Frameno)/8;
x_motion_retrv=x_motion;
y_motion_retrv=y_motion;
%Retrieve The Hidden Data
if abs(mv_phase(a(i),b(i)))<=pi/2   % Acute, Hiden Data is in X motion vector
    disp('X motion Vector Selected for Data Retrieval');
    [im_Data_x,txt_retrv]=recover(em_data_x,siz);
    %Replace the Retrieved Data into original Motion Vector Matrix
    x_motion_retrv=abs(x_motion);
    for i=1:length(a)
        x_motion_retrv(a(i),b(i))=im_Data_x(i);
    end
    [a,b]=find(x_motion<0);
    for i=1:length(a)
        x_motion_retrv(a(i),b(i))=-1*x_motion_retrv(a(i),b(i));
    end
   
elseif abs(mv_phase(a(i),b(i)))>pi/2  % Obtuse, Hidden Data is in Y motion Vector
    disp('Y motion Vector Selected for Data Retrieval');
    [im_Data_y,txt_retrv]=recover(em_data_y,siz);
    y_motion_retrv=abs(y_motion);
    [a,b]=find(mb==1);
    for i=1:length(a)
        y_motion_retrv(a(i),b(i))=im_Data_y(i);
    end

    [a,b]=find(y_motion<0);
    for i=1:length(a)
        y_motion_retrv(a(i),b(i))=-1*y_motion_retrv(a(i),b(i));
    end

end
    
recov_txt=[recov_txt txt_retrv];
    
    %reconstruct the image using Motion vectors after Hidden Data Retrival
    recons_im=temp_recons(recons_image(:,:,Frameno-1),x_motion_retrv,y_motion_retrv,Tpred(:,:,Frameno));
    figure(); imshow(uint8(recons_im));title(['Reconstructed Image using Motion Vectors after Hidden Data Retrival:: Frame:' int2str(Frameno)])
    disp('Hidden Data Retrieved');
    disp(['Txt Retrieved from this frame (' int2str(Frameno) ') is : ' txt_retrv]);
    
    recons_image(:,:,Frameno)=uint8(recons_im);
    

end

end




