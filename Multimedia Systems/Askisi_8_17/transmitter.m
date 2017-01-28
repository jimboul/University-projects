function [x_mv,y_mv,x_mv_hid,y_mv_hid,T_predic,capacity]=transmitter(im_grey,Frames,start_frame,Txt,motion_trsh)

%calculation with Hidding Data
strlen=numel(Txt);
data_rem=8*strlen;
rem_Txt=Txt;
%numberOfFrames = length(im_grey);
numberOfFrames=Frames+start_frame-1;

for Frameno=start_frame:numberOfFrames
    s=sprintf('\n');disp(s);
    disp(['Frame being Processed :' int2str(Frameno)]);
    
%MOTION PREDICTION
[E_temporal,x_motion,y_motion,T_pred(:,:,Frameno)]=temporal_predict(im_grey(:,:,Frameno-1),im_grey(:,:,Frameno),1);
disp('Motion Vector Prediction Done');
T_predic.Tpred=T_pred;

%Magnidute Calculation
mv_mag=sqrt(double(x_motion.^2 +y_motion.^2));
disp('Magnitude of Motion Vector Calculated');
N=8;
figure, imshow(im_grey(:,:,Frameno)), title(['Magnitude of Motion Vectors:: Frame:' int2str(Frameno)]),hold on;
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
figure, imshow(im_grey(:,:,Frameno)), title(['Phase of Motion Vectors:: Frame:' int2str(Frameno)]),hold on;
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
figure, imshow(im_grey(:,:,Frameno)), title(['Selected Motion Vectors:: Frame:' int2str(Frameno)]),hold on;
[ht,wd]=size(mv_mag);
index=0;N=8;
for i=1:ht
    for j=1:wd
        if mv_mag(i,j)>=motion_trsh && x_motion(i,j)<=7 && y_motion(i,j)<=7 && x_motion(i,j)>=-7 && y_motion(i,j)>=-7 && index<=32
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
disp(['Total No of Motion Vectors in this Frame :' int2str(ht*wd)]);
disp(['No of Motion Vectors selected for encoding from this Frame :' int2str(index)]);
mbc(:,:,Frameno)=mb;
T_predic.pred=mbc;

%Empedding capacity wrt Thresholding
[ht,wd]=size(mv_mag);
N=8;
for m_trsh= 1:N
    ind(m_trsh)=0;
for i=1:ht
    for j=1:wd
        if mv_mag(i,j)>=m_trsh && x_motion(i,j)<=7 && y_motion(i,j)<=7 && x_motion(i,j)>=-7 && y_motion(i,j)>=-7 && ind(m_trsh)<=32
            ind(m_trsh)=ind(m_trsh)+1;
        end
    end
end
end


%Data Hididng
if data_rem>0 && index>0
    if data_rem<index
        mv_used=data_rem;
        act_mv_used=mv_used;
        usable_Txt=rem_Txt;
        rem_Txt='';
    elseif data_rem>index
        mv_used=index;
        act_mv_used=floor(mv_used/8)*8;
        usable_Txt=rem_Txt(1:act_mv_used/8);
        rem_Txt=rem_Txt(act_mv_used/8+1:end);
    end
    %data_rem=data_rem-mv_used;
elseif data_rem<=0
    %disp('Data Fully Hidden in previous Frame');
    usable_Txt='';
end
usage(:,:,Frameno)=act_mv_used;
T_predic.prediction=usage;
    % gather the motion vectors that can be used
    [a,b]=find(mb==1);
    for i=1:length(a)
        Data_x(i)=abs(x_motion(a(i),b(i)));
        Data_y(i)=abs(y_motion(a(i),b(i)));
    end
    
    if abs(mv_phase(a(i),b(i)))<=pi/2 
        if numel(usable_Txt>0)
                disp(['Hidden Data in Current Frame :' usable_Txt]);
                disp('Phase angle is Acute. Data Hidden in X motion Vector.');
            else
                disp('Data Hidden Fully in Previous Frames. No data Hidden in current Frame.');
        end
    elseif abs(mv_phase(a(i),b(i)))>pi/2   % Obtuse, Hide data in Y motion vector
        if numel(usable_Txt>0)
            disp(['Hidden Data in Current Frame :' usable_Txt]);
            disp('Phase angle is Obtuse. Data Hidden in Y motion Vector.');
        else
            disp('No data Hidden in current Frame.');
        end
    end
    
    for i=1:length(a)
        %Hide the Txt
        if abs(mv_phase(a(i),b(i)))<=pi/2   % Acute, Hide Data in X motion vector
            em_data_x=embed(Data_x,usable_Txt);
            
            %Replace the Embedded Data into original Motion Vector Matrix
            x_motion_hid=abs(x_motion);
            [a,b]=find(mb==1);
            for i=1:length(a)
                x_motion_hid(a(i),b(i))=em_data_x(i);
            end

            [a,b]=find(x_motion<0);
            for i=1:length(a)
                x_motion_hid(a(i),b(i))=-1*x_motion_hid(a(i),b(i));
            end
        
            y_motion_hid=y_motion; % NO changes in Y motion Vector
            
        elseif abs(mv_phase(a(i),b(i)))>pi/2   % Obtuse, Hide data in Y motion vector
            em_data_y=embed(Data_y,usable_Txt);
        
            %Replace the Embedded Data into original Motion Vector Matrix
            y_motion_hid=abs(y_motion);
            [a,b]=find(mb==1);
            for i=1:length(a)
                y_motion_hid(a(i),b(i))=em_data_y(i);
            end
            [a,b]=find(y_motion<0);
            for i=1:length(a)
                y_motion_hid(a(i),b(i))=-1*y_motion_hid(a(i),b(i));
            end
        
            x_motion_hid=x_motion; % No changes in X motion Vector

        end
    
    end

    data_rem=data_rem-act_mv_used;

    
%x_motion_hid(x_motion_hid==9)=7;x_motion_hid(x_motion_hid==8)=6;
%y_motion_hid(y_motion_hid==9)=7;y_motion_hid(y_motion_hid==8)=6;
    
x_mv(:,:,Frameno)=x_motion;
y_mv(:,:,Frameno)=y_motion;
x_mv_hid(:,:,Frameno)=x_motion_hid;
y_mv_hid(:,:,Frameno)=y_motion_hid;

capacity(:,Frameno)=ind;

   
end

if data_rem>0
    disp('Data Not fully Hidden in the selected Frames. Select More frame to hide this Data');
end


end
