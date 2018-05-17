 function [dX,dY,dXb,dYb,dAlpha,dAlpha_b,dBeta,dBeta_b] = map(M)
global Mdx Mdy
%����� dX,dY - ������� �����������, dXb,dYb - ������� ��������� �������� �
%������� ���������� ��� ���� ��������� ��������������

%������� ������� ���������� �� ������������
[dX,dY] = gradient(M, Mdx, Mdy);
%���������, ����� ���� � �������� �������
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

%������� ������ ����������� �� ����
xL = graythresh(dXb);
yL = graythresh(dYb);

%���������� � ���������� ��������
dXb = double(im2bw(dXb,xL));
dYb = double(im2bw(dYb,yL));
%   figure()
%   imagesc(flip(dYb ,1));

%������ ��� �� �� ����� ��� ����������� alpha � beta
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

%������� ������ ����������� �� ����
aL = graythresh(dAlpha_b);
bL = graythresh(dBeta_b);

%���������� � ���������� ��������
dAlpha_b = double(im2bw(dAlpha_b,aL));
dBeta_b = double(im2bw(dBeta_b,bL));


 end