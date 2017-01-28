
L=[1 4 6 4 1];   % Level
E=[-1 -2 0 1 2]; % Edge
S=[-1 0 2 0 -1]; % Spot
R=[1 -4 6 -4 1]; % Ripple

% Outer product of the vectors and mask production
Mask1=E'*L; 
Mask2=L'*E;   
Mask3=L'*R;    
Mask4=R'*L;
Mask5=E'*S;
Mask6=S'*E;
Mask7=S'*S;
Mask8=R'*R;
Mask9=L'*S;
Mask10=S'*L;
Mask11=E'*E;
Mask12=E'*R;
Mask13=R'*E;
Mask14=S'*R;
Mask15=R'*S;

% Texture Energy Maps for counting the 9 masks
F1=(Mask1+Mask2)*0.5; 
F2=(Mask3+Mask4)*0.5; 
F3=(Mask5+Mask6)*0.5;
F4=(Mask9+Mask10)*0.5;
F5=(Mask12+Mask13)*0.5;
F6=(Mask14+Mask15)*0.5;

[X,map]=imread('frog.bmp','bmp'); 
imshow(X,map);  
title('Initial Image')
im=ind2gray(X,map); 
W=fspecial('average',2); 
i=imfilter(im,W); 

I1=conv2(i,Mask1); 
I2=conv2(i,Mask2);
I3=conv2(i,Mask3);
I4=conv2(i,Mask4);
I5=conv2(i,Mask5);
I6=conv2(i,Mask6);
I7=conv2(i,Mask7);
I8=conv2(i,Mask8);
I9=conv2(i,Mask9);
I10=conv2(i,Mask10);
I11=conv2(i,Mask11);
I12=conv2(i,Mask12);
I13=conv2(i,Mask13);
I14=conv2(i,Mask14);
I15=conv2(i,Mask15);


IF1=conv2(i,F1); 
IF2=conv2(i,F2);
IF3=conv2(i,F3);
IF4=conv2(i,Mask7);
IF5=conv2(i,Mask8);
IF6=conv2(i,F4);
IF7=conv2(i,Mask11);
IF8=conv2(i,F5);
IF9=conv2(i,F6);



figure,imshow(im) 
title('GrayScale Image')
figure,imshow(i) 
title('PreProcessed Image')
figure,imshow(I1) 
title('Initial Texture Energy Map 1')
figure,imshow(I2)
title('Initial Texture Energy Map 2')
figure,imshow(I3)
title('Initial Texture Energy Map 3')
figure,imshow(I4)
title('Initial Texture Energy Map 4')
figure,imshow(I5)
title('Initial Texture Energy Map 5')
figure,imshow(I6)
title('Initial Texture Energy Map 6')
figure,imshow(I7)
title('Initial Texture Energy Map 7')
figure,imshow(I8)
title('Initial Texture Energy Map 8')
figure,imshow(I9)
title('Initial Texture Energy Map 9')
figure,imshow(I10)
title('Initial Texture Energy Map 10')
figure,imshow(I11)
title('Initial Texture Energy Map 11')
figure,imshow(I12)
title('Initial Texture Energy Map 12')
figure,imshow(I13)
title('Initial Texture Energy Map 13')
figure,imshow(I14)
title('Initial Texture Energy Map 14')
figure,imshow(I15)
title('Initial Texture Energy Map 15')


figure,imshow(IF1)
title('Final Texture Energy Map 1')
figure,imshow(IF2)
title('Final Texture Energy Map 2')
figure,imshow(IF3)
title('Final Texture Energy Map 3')
figure,imshow(IF4)
title('Final Texture Energy Map 4')
figure,imshow(IF5)
title('Final Texture Energy Map 5')
figure,imshow(IF6)
title('Final Texture Energy Map 6')
figure,imshow(IF7)
title('Final Texture Energy Map 7')
figure,imshow(IF8)
title('Final Texture Energy Map 8')
figure,imshow(IF9)
title('Final Texture Energy Map 9')