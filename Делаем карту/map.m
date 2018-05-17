[X,Y] = meshgrid(-2:.02:2, -2:.02:2);
Z = X .* exp(-X.^2 - Y.^2);
close all
figure(1);
surf(Z)

%s = size(X);
% dX = zeros(s);
% dY = dX;
% for i = 2:(s(1)-1)
%     for j = 2:(s(2)-1)
%         %тут надо подумать с координатами, где какая
%         dX(i,j) = abs( ( Z(i+1,j)-Z(i-1,j) )/2 );
%         dY(i,j) = abs( ( Z(i,j+1)-Z(i,j-1) )/2 );
%     end
% end
[dX,dY] = gradient(Z);
dX = abs(dX)./max(max(abs(dX)));
dY = abs(dY)./max(max(abs(dY)));
figure(2);
surf(dX);
figure(3);
surf(dY);

yL = graythresh(dY);
xL = graythresh(dX);

dYb = im2bw(dY,yL);
dXb = im2bw(dX,xL);

figure
imshow(dYb)
figure
imshow(dXb)

figure
M = dYb + dXb;
imshow(M)
