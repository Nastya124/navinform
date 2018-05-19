function X = route_points(dXb)
global Mdx 
%выделяем контура на полученных картах
[Bx,Lx,Nx,Ax] = bwboundaries(dXb,'noholes');


%делаем структуру для точек
AxPoints = zeros(2,2,length(Bx));

for k=1:length(Bx)
    boundary = Bx{k};
    hold on
    try
    [z, a, b, alpha] = fitellipse(boundary, 'linear', 'constraint', 'trace');
    catch err
       continue;
    end
    %plotellipse(z, a, b, alpha);
    
    %рисуем точку центра эллипса
    %plot(z(2)*Mdx/1000,z(1)*Mdx/1000, 'r.');
    
    %вычисляем и рисуем начало большой оси
    X1(2) = z(1)+a*cos(alpha);
    X1(1) = z(2)+a*sin(alpha);
    %plot(X1(2),X1(1), 'y*');
    AxPoints(:,1,k) = X1;
    
    %вычисляем и рисуем конец большой оси
    X2(2) = z(1)-a*cos(alpha);
    X2(1) = z(2)-a*sin(alpha);
    %plot(X2(2),X2(1), 'y*');
    AxPoints(:,2,k) = X2;
end

%получаем измерения на отрезках с высоким градиентом

%задаем число измерений на отрезках
d_mnt = 300; %расстояние между измерениями (м)
X = [];
%  num = 20;


for i = 1:length(Bx)
    points = [AxPoints(1,1,i),AxPoints(2,1,i);...
            AxPoints(1,2,i),AxPoints(2,2,i)];
    d = pdist(points,'euclidean')*Mdx;
    num = fix(d/d_mnt);
    temp1 = linspace(AxPoints(1,1,i),AxPoints(1,2,i),num);
    temp2 = linspace(AxPoints(2,1,i),AxPoints(2,2,i),num);
    X = [X [temp1; temp2]];
end
%проверяем, что точки маршрута лежат в области карты
X = check_bounds(X,min(size(dXb)));

%figure()
%hold on
%plot(X(2,:),X(1,:),'r.');

end