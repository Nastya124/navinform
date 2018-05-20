%Алгоритм:
%1)открываю карту
% 2) карту -> нахожу производные -> (2 карты)
% 3) бинаризую карты
% 4) аппроксимирую карты эллипсами -> получаю точки маршрута
% 5) строю маршруты по точкам, соединяю в общий маршрут
% 6) -> считаю точность оценивания для точек маршрута
% 7) рассчитать наибольшую P.

clear
%M = peaks(200);
 close all
load 'fields/Field 3.mat';
%M=M.*10;
global Mdx Mdy
Mdx = 200; %шаг сетки (м)
Mdy = 200; %шаг сетки (м)
[X,Y] = meshgrid(0:Mdx/1000:30, 0:Mdy/1000:30);
M = interp2(M,X,Y,'spline');

%задаем параметры шума датчика и оцениваемого вектора
r = 1;
P_x = [1000000 0; 0 1000000];

%получаем матрицы производных по направлениям и бинаризованные карты для
%каждой из координат
[dX,dY,dXb,dYb,dAlpha,dAlpha_b,dBeta,dBeta_b,alpha,beta] = map(M);
%**************************************************
%!!!!!!Это ТОЛЬКО направления X и Y!!!!!!!!!!!!!!!!
%получаем точки маршрута
 route_points_x = route_points(dXb);
 route_points_y = route_points(dYb);
 
%вычисляем точность оценивания для каждой из координат
% P_unc_x = unconditional_cov_matrix(route_points_x, dX, dY, P_x, r);
% P_unc_y = unconditional_cov_matrix(route_points_y, dX, dY, P_x, r);

%сравнение с точностью на "экспертном" маршруте
%route_points_exp(1,:) = linspace(20,25,max(size(route_points_x)));
%route_points_exp(2,:) = linspace(3,48,max(size(route_points_x)));
%P_exp = conditional_cov_matrix(route_points_exp, dX, dY, P_x, r);

% figure();
% subplot(2,1,1)
% hold on
% plot(sqrt(squeeze(P_unc_x(1,1,:))));
% plot(sqrt(squeeze(P_unc_x(2,2,:))));
% legend('Px_u', 'Py_u');
% title('СКО ПДТО по областям для координаты Х');
% xlabel('Количество измерений')
% ylabel('СКО, м')
% subplot(2,1,2)
% hold on
% plot(sqrt(squeeze(P_unc_y(1,1,:))));
% plot(sqrt(squeeze(P_unc_y(2,2,:))));
% legend('Px_u', 'Py_u');
% title('СКО ПДТО по областям для координаты Y');
% xlabel('Количество измерений')
% ylabel('СКО, м')
%%plot(sqrt(squeeze(P_exp(1,1,:))));
%%plot(sqrt(squeeze(P_exp(2,2,:))));
%%legend('Px', 'Py', 'P_exp_x', 'P_exp_y');
%%title('СКО по областям для координаты Х');
%**************************************************

 route_points_a = route_points(dAlpha_b);
 route_points_b = route_points(dBeta_b);
 
 P_unc_a = unconditional_cov_matrix(route_points_a, dX, dY, P_x, r);
 P_unc_b = unconditional_cov_matrix(route_points_b, dX, dY, P_x, r);
 
 route_points_xy = [route_points_x route_points_y];
 route_points_ab = [route_points_a route_points_b];
 
 P_unc_xy = unconditional_cov_matrix(route_points_xy, dX, dY, P_x, r);
 P_unc_ab = unconditional_cov_matrix(route_points_ab, dX, dY, P_x, r);
 
 %plot_everything
 
 %  subplot(2,1,1)
%  hold on
%  plot(sqrt(squeeze(P_unc_xy(1,1,:))));
%  plot(sqrt(squeeze(P_unc_ab(1,1,:))));
%  legend('Pxy_u', 'Pab_u');
%  title('ПДТО координаты X по направлениям XY и alpha-beta');
%  xlabel('Количество измерений')
%  ylabel('СКО, м')
%  subplot(2,1,2)
%  hold on
%  plot(sqrt(squeeze(P_unc_xy(2,2,:))));
%  plot(sqrt(squeeze(P_unc_ab(2,2,:))));
%  legend('Pxy_u', 'Pab_u');
%  title('ПДТО координаты Y по направлениям XY и alpha-beta');
%  xlabel('Количество измерений')
%  ylabel('СКО, м')
