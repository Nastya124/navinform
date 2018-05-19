close all

figure(1)
subplot(1,2,1)
contour(X,Y,M,15)
title('Поле в изолиниях');
xlabel('Ox')
ylabel('Oy')
subplot(1,2,2)
N=25; % or usea different # of points if needed
range1=unique(round(linspace(1,size(dX,1),N)));
range2=unique(round(linspace(1,size(dX,1),N)));
[rx, ry]=meshgrid(range1,range2);
quiver(rx,ry,dX(range1,range2),dY(range1,range2)); %, hold off
% quiver(dX,dY);

ang = atan2(dY, dX);
ang2 = mod(ang,pi)*180/pi;
mod2 = sqrt(dX.^2+dY.^2);

figure(2)
subplot(2,1,1)
hist(reshape(ang2.',1,[]),180);
subplot(2,1,2)
hist(reshape(mod2.',1,[]),100);
figure(3)
ndhist(reshape(ang2.',1,[]),reshape(mod2.',1,[]),'3d');


figure(4)
subplot(2,3,1)
contour(X,Y,M,15)
title('Поле в изолиниях');
axis equal
subplot(2,3,4)
% [qX,qY] = meshgrid(1:Mdx/100:31, 1:Mdy/100:31);
quiver(X,Y,dX,dY);
% axis equal

subplot(2,3,2)
imagesc(flip(dXb,1));
hold on
plot(route_points_x(1,:),(151-route_points_x(2,:)),'r.')
title('Области по направлению X');

% figure(5)
subplot(2,3,3)
imagesc(flip(dYb,1));
hold on
plot(route_points_y(1,:),(151-route_points_y(2,:)),'r.')
title('Области по направлению Y');

% figure(6)
subplot(2,3,5)
imagesc(flip(dAlpha_b,1));
hold on
plot(route_points_a(1,:),(151-route_points_a(2,:)),'r.')
title('Области по направлению alpha');

% figure(7)
subplot(2,3,6)
imagesc(flip(dBeta_b,1));
hold on
plot(route_points_b(1,:),(151-route_points_b(2,:)),'r.')
title('Области по направлению beta');

figure(8);
hold on
plot(sqrt(squeeze(P_unc_xy(1,1,:)+P_unc_xy(2,2,:))));
plot(sqrt(squeeze(P_unc_ab(1,1,:)+P_unc_ab(2,2,:))));
legend('Pxy_u', 'Pab_u');
title('ПДТО радиальной погрешности по направлениям XY и alpha-beta');
xlabel('Количество измерений')
ylabel('СКО, м')

