
[x,y,z] = sphere;
figure
surf(x,y,z)
[X,Y] = meshgrid(x,y);
Z = X.* exp(-X.^2 - Y.^2);
[U,V,W] = surfnorm(X,Y,Z);

figure
quiver3(X,Y,Z,U,V,W,0.5)

hold on
surf(X,Y,Z)
view(-35,45)
axis([-2 2 -1 1 -.6 .6])
hold off
