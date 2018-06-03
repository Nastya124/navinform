function [OUT] = inf_map(M,STN)

%предварительная интерполяция
[X_grid_i,Y_grid_i] = meshgrid(0:STN.Mdx_i:STN.Map_Xsize, 0:STN.Mdy_i:STN.Map_Ysize);
[X_grid,Y_grid] = meshgrid(0:STN.Mdx:STN.Map_Xsize, 0:STN.Mdy:STN.Map_Ysize);
M = interp2(X_grid_i,Y_grid_i,M,X_grid,Y_grid,'cubic');

%Здесь dX,dY - матрицы производных, dXb,dYb - матрицы нацденных областей с
%высоким градиентом для двух координат соответственно



%Находим матрицы градиентов по направлениям
[dX,dY] = gradient(M, STN.Mdx, STN.Mdy);

%находим альфа, бета
[alpha, beta] = get_directions(dX,dY,STN.AB_METHOD);
fprintf('Направления: альфа %.2f, бета %.2f, дельта %.2f \n',alpha*180/pi, beta*180/pi, abs(alpha-beta)*180/pi);

%Расчитываем значение характеристики информативности по осям альфа, бета
dAlpha = dX*cos(alpha)+dY*sin(alpha);
dBeta = dX*cos(beta)+dY*sin(beta);

Alpha_nav = dAlpha.^2/STN.r.^2;
Beta_nav= dBeta.^2/STN.r.^2;

%нормируем
An = max(max(Alpha_nav));
Bn = max(max(Beta_nav));
Alpha_nav_norm = Alpha_nav/An;
Beta_nav_norm = Beta_nav/Bn;

if strcmp(STN.BIN_TYPE,'Otsu') == 1
    %находим пороги бинаризации по Отсу
    aL = graythresh(Alpha_nav_norm);
    bL = graythresh(Beta_nav_norm);
    
    %бинаризуем с найденными порогами
    Alpha_nav_b = double(im2bw(Alpha_nav_norm,aL));
    Beta_nav_b = double(im2bw(Beta_nav_norm,bL));
end
if strcmp(STN.BIN_TYPE,'Thresh') == 1
    %бинаризуем с фиксированным порогом
    Alpha_nav_b = double(im2bw(Alpha_nav_norm,STN.BIN_THRESH_A));
    Beta_nav_b = double(im2bw(Beta_nav_norm,STN.BIN_THRESH_B));
end
OUT.M = M;
OUT.X_grid = X_grid;
OUT.Y_grid = Y_grid;
OUT.alpha = alpha;
OUT.beta = beta;
OUT.dX = dX;
OUT.dY = dY;
OUT.Alpha_nav = Alpha_nav;
OUT.Beta_nav = Beta_nav;
OUT.Alpha_nav_norm = Alpha_nav_norm;
OUT.Beta_nav_norm = Beta_nav_norm;
OUT.Alpha_nav_b = Alpha_nav_b;
OUT.Beta_nav_b = Beta_nav_b;

