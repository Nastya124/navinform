 function [dX,dY,dXb,dYb,dAlpha,dAlpha_b,dBeta,dBeta_b] = map(M)
global Mdx Mdy
%Здесь dX,dY - матрицы производных, dXb,dYb - матрицы нацденных областей с
%высоким градиентом для двух координат соответственно

%Находим матрицы градиентов по направлениям
[dX,dY] = gradient(M, Mdx, Mdy);
%нормируем, чтобы было в пределах единицы
% dXb = abs(dX)./max(max(abs(dX)));
% dYb = abs(dY)./max(max(abs(dY)));
ang = atan2(dY, dX);
ang2 = mod(ang,pi)*180/pi;
mod2 = sqrt(dX.^2+dY.^2);
figure
%hist(reshape(ang2.',1,[]),180);
ndhist(reshape(ang2.',1,[]),reshape(mod2.',1,[]),'3d');


dXb = dX.^2;
dYb = dY.^2;
Xn = max(max(dXb));
Yn = max(max(dYb));
dXb = dXb/Xn;
dYb = dYb/Yn;

%находим пороги бинаризации по Отсу
xL = graythresh(dXb);
yL = graythresh(dYb);

%бинаризуем с найденными порогами
dXb = double(im2bw(dXb,xL));
dYb = double(im2bw(dYb,yL));
%   figure()
%   imagesc(flip(dYb ,1));

%делаем все то же самое для направлений alpha и beta
alpha = 123*pi/180;
beta = 40*pi/180;

dAlpha = dX*cos(alpha)+dY*sin(alpha);
dBeta = dX*cos(beta)+dY*sin(beta);

dAlpha_b = dAlpha.^2;
dBeta_b = dBeta.^2;
An = max(max(dAlpha_b));
Bn = max(max(dBeta_b));
dAlpha_b = dAlpha_b/An;
dBeta_b = dBeta_b/Bn;

%находим пороги бинаризации по Отсу
aL = graythresh(dAlpha_b);
bL = graythresh(dBeta_b);

%бинаризуем с найденными порогами
dAlpha_b = double(im2bw(dAlpha_b,aL));
dBeta_b = double(im2bw(dBeta_b,bL));


 end