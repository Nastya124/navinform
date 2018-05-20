 function [dX,dY,dXb,dYb,dAlpha,dAlpha_b,dBeta,dBeta_b,alpha,beta] = map(M)
global Mdx Mdy
%«десь dX,dY - матрицы производных, dXb,dYb - матрицы нацденных областей с
%высоким градиентом дл€ двух координат соответственно

%Ќаходим матрицы градиентов по направлени€м
[dX,dY] = gradient(M, Mdx, Mdy);
%нормируем, чтобы было в пределах единицы
% dXb = abs(dX)./max(max(abs(dX)));
% dYb = abs(dY)./max(max(abs(dY)));

dXb = dX.^2;
dYb = dY.^2;
Xn = max(max(dXb));
Yn = max(max(dYb));
dXb = dXb/Xn;
dYb = dYb/Yn;

%находим пороги бинаризации по ќтсу
xL = graythresh(dXb);
yL = graythresh(dYb);

%бинаризуем с найденными порогами
% dXb = double(im2bw(dXb,xL));
% dYb = double(im2bw(dYb,yL));


dXb = double(im2bw(dXb,0.95));
dYb = double(im2bw(dYb,0.95));

%   figure()
%   imagesc(flip(dYb ,1));

%делаем все то же самое дл€ направлений alpha и beta

[alpha, beta] = get_directions2(dX,dY);

fprintf('Ќаправлени€: альфа %.2f, бета %.2f, дельта %.2f \n',alpha*180/pi, beta*180/pi, abs(alpha-beta)*180/pi);
dAlpha = dX*cos(alpha)+dY*sin(alpha);
dBeta = dX*cos(beta)+dY*sin(beta);

dAlpha_b = dAlpha.^2;
dBeta_b = dBeta.^2;
An = max(max(dAlpha_b));
Bn = max(max(dBeta_b));
dAlpha_b = dAlpha_b/An;
dBeta_b = dBeta_b/Bn;

%находим пороги бинаризации по ќтсу
aL = graythresh(dAlpha_b);
bL = graythresh(dBeta_b);

%бинаризуем с найденными порогами
% dAlpha_b = double(im2bw(dAlpha_b,aL));
% dBeta_b = double(im2bw(dBeta_b,bL));


dAlpha_b = double(im2bw(dAlpha_b,0.95));
dBeta_b = double(im2bw(dBeta_b,0.95));



 end