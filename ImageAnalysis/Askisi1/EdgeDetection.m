[X,map]=imread('frog.bmp','bmp'); 
imshow(X,map);  
title('Initial Picture')
I = ind2gray(X,map);
figure,imshow(I)
title('Grayscale Picture');

SobelPicture = edge(I,'sobel'); 
RobertsPicture = edge(I,'roberts'); 
PrewittPicture = edge(I,'prewitt'); 
figure,imshow(SobelPicture)
title('Sobel Picture');
figure,imshow(RobertsPicture)
title('Roberts Picture');
figure,imshow(PrewittPicture)
title('Prewitt Picture');

% Kirsch 
Kernel1= [5 5 5; -3 0 -3; -3 -3 -3];
Kernel2= [-3 -3 5; -3 0 5; -3 -3 -3];
Kernel3= [-3 5 5; -3 0 5; -3 -3 5];
Kernel4= [-3 -3 -3; -3 0 5; -3 5 5];
Kernel5=[-3 -3 -3; -3 0 -3; 5 5 5];
Kernel6=[-3 -3 -3; 5 0 -3; 5 5 -3];
Kernel7=[5 -3 -3; 5 0 -3; 5 -3 -3];
Kernel8=[5 5 -3; 5 0 -3; -3 -3 -3];


I1=im2bw(I); 

C1=conv2(double(I1),Kernel1); 
C2=conv2(double(I1),Kernel2);
C3=conv2(double(I1),Kernel3);
C4=conv2(double(I1),Kernel4);
C5=conv2(double(I1),Kernel5);
C6=conv2(double(I1),Kernel6);
C7=conv2(double(I1),Kernel7);
C8=conv2(double(I1),Kernel8);


Maxer=max(C1,C2);
Maxer=max(Maxer,C3);
Maxer=max(Maxer,C4);
Maxer=max(Maxer,C5);
Maxer=max(Maxer,C6);
Maxer=max(Maxer,C7);
Maxer=max(Maxer,C8);

figure,imshow(Maxer) 
title('Kirsch Picture');