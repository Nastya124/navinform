close all

figure(1)
contour(X,Y,M,15)
title('Поле в изолиниях');
xlabel('Ox') 
ylabel('Oy')

ang = atan2(dY, dX);
ang2 = mod(ang,pi)*180/pi;
mod2 = sqrt(dX.^2+dY.^2);

figure(2)
hist(reshape(ang2.',1,[]),180);
figure(3)
ndhist(reshape(ang2.',1,[]),reshape(mod2.',1,[]),'3d');


figure(4)
imagesc(flip(dXb,1)); 
hold on
plot(route_points_x(1,:),(151-route_points_x(2,:)),'r.')
title('Области по направлению X');
 
figure(5)
imagesc(flip(dYb,1)); 
hold on
plot(route_points_y(1,:),(151-route_points_y(2,:)),'r.')
title('Области по направлению Y');
 
figure(6)
imagesc(flip(dAlpha_b,1)); 
hold on
plot(route_points_a(1,:),(151-route_points_a(2,:)),'r.')
title('Области по направлению alpha');

figure(7)
imagesc(flip(dBeta_b,1)); 
hold on
plot(route_points_b(1,:),(151-route_points_b(2,:)),'r.')
title('Области по направлению alpha');

 figure(8);
 hold on
 plot(sqrt(squeeze(P_unc_xy(1,1,:)+P_unc_xy(2,2,:))));
 plot(sqrt(squeeze(P_unc_ab(1,1,:)+P_unc_ab(2,2,:))));
 legend('Pxy_u', 'Pab_u');
 title('ПДТО радиальной погрешности по направлениям XY и alpha-beta');
 xlabel('Количество измерений')
 ylabel('СКО, м')

