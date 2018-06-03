%Алгоритм:
%1)открываю карту
% 2) карту -> нахожу производные -> (2 карты)
% 3) бинаризую карты
% 4) аппроксимирую карты эллипсами -> получаю точки маршрута
% 5) строю маршруты по точкам, соединяю в общий маршрут
% 6) -> считаю точность оценивания для точек маршрута
% 7) рассчитать наибольшую P.

%12, 15 поле хорошее

clear; close all;
load 'fields/Field 2.mat';

%Настройки
STN.Map_Xsize = 29000;
STN.Map_Ysize = 29000;

%исходная сетка
STN.Mdx_i = 1000; %шаг сетки (м)
STN.Mdy_i = 1000;

%сетка для интерполяции
STN.Mdx = 200; %шаг сетки (м)
STN.Mdy = 200;

STN.r = 1; % CКО измерителя
STN.r_x1 = 1000; %начальные СКО координат (м)
STN.r_x2 = 1000;
STN.P_0 = [STN.r_x1^2 0; 0 STN.r_x2^2]; %начальная матрица ковариаций

STN.BIN_TYPE = 'Thresh'; %'Otsu', 'Thresh'
STN.BIN_THRESH_A = 0.90;
STN.BIN_THRESH_B = 0.90;

STN.mn_num = 'A'; %'A';

% 1 - максимум градиента и ортогональное ему направление
% 2 - максимум функционала (среднее суммы квадратов максимумов)
% 3 - преобладающие направления градиента на поле, через разложение ковариационной матрицы
% 4 - фиксированный 0,pi/2
STN.AB_METHOD = 2;

%%

%получаем матрицы производных по направлениям и бинаризованные карты для
%каждой из координат
MAP_data = inf_map(M,STN);
figure(1)
contour(MAP_data.X_grid,MAP_data.Y_grid,MAP_data.M,15)
hold on
[xi,yi] = getpts;
%**************************************************


%получаем точки маршрута
AxPoints_a = ell_points(MAP_data.Alpha_nav_b,STN);
AxPoints_b = ell_points(MAP_data.Beta_nav_b,STN);

route_a = route_points(AxPoints_a, STN);
route_b = route_points(AxPoints_b, STN);

route_ab = make_route(route_a,route_b);
P_cond_ab = conditional_cov_matrix(route_ab, MAP_data, STN);


STN.AB_METHOD = 4;
MAP_data = inf_map(M,STN);

%получаем точки маршрута
AxPoints_x = [xi(1) yi(1);xi(2) yi(2)];
%AxPoints_y = [xi(3) yi(3);xi(4) yi(4)];

route_x = route_points(AxPoints_x, STN);
%route_y = route_points(AxPoints_y, STN);

%route_xy = make_route(route_x,route_y);
P_cond_xy = conditional_cov_matrix(route_x, MAP_data, STN);

%% testing

hold on
pts_a = vertcat(route_a.pts{:});
pts_b = vertcat(route_b.pts{:});

pts_x = vertcat(route_x.pts{:});
%pts_y = vertcat(route_y.pts{:});

plot(pts_a(:,1),pts_a(:,2),'r.')
plot(pts_b(:,1),pts_b(:,2),'r.')

plot(pts_x(:,1),pts_x(:,2),'b.')
%plot(pts_y(:,1),pts_y(:,2),'b.')

title('Поле в изолиниях');
xlabel('Ox')
ylabel('Oy')



figure(2)
hold on
plot(sqrt(squeeze(P_cond_ab(1,1,:)+P_cond_ab(2,2,:))));
plot(sqrt(squeeze(P_cond_xy(1,1,:)+P_cond_xy(2,2,:))));
legend('СКО AB', 'СКО Экспертное')

return
%%
P_unc_a = unconditional_cov_matrix(route_a, dX, dY, P_x, r);
P_unc_b = unconditional_cov_matrix(pts_b, dX, dY, P_x, r);

route_points_xy = [route_points_x route_points_y];
route_points_ab = [route_points_a route_points_b];

P_unc_xy = unconditional_cov_matrix(route_points_xy, dX, dY, P_x, r);
P_unc_ab = unconditional_cov_matrix(route_points_ab, dX, dY, P_x, r);


plot_everything
