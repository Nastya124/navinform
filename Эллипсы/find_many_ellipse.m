image = imread('el5.png');
BW = rgb2gray(image);
%выделяем контура
[B,L,N,A] = bwboundaries(BW);
figure, imshow(BW); hold on;
%вычисляем периметр, чтобы в дальнейшем отсеять контур всего изображения
sBW = size(BW);
perim = 2*sBW(1) + 2* sBW(2);
for k=1:N
    boundary = B{k};
    sB = size(boundary);
    %проверяем, что длина контура меньше, чем периметр изображения.
    if sB(1) > (perim - 20)
        B(k) = [];
    end
    N = length(B);
end


%делаем структуру для точек
AxPoints = zeros(2,2,length(B));

colors=['b' 'g' 'r' 'c' 'm' 'y'];
for k=1:length(B)
    boundary = B{k};
 
    cidx = mod(k,length(colors))+1;
    hold on
    plot(boundary(:,2), boundary(:,1),colors(cidx),'LineWidth',2);
    [z, a, b, alpha] = fitellipse(boundary, 'linear', 'constraint', 'trace');
    plotellipse(z, a, b, alpha);
    
    %рисуем точку центра эллипса
    plot(z(2),z(1), 'r.');
    
    %вычисляем и рисуем начало большой оси
    X1(2) = z(2)+a*sin(alpha);
    X1(1) = z(1)+a*cos(alpha);
    plot(X1(2),X1(1), 'y*');
    AxPoints(:,1,k) = X1;
    
    %вычисляем и рисуем конец большой оси
    X2(2) = z(2)-a*sin(alpha);
    X2(1) = z(1)-a*cos(alpha);
    plot(X2(2),X2(1), 'y*');
    AxPoints(:,2,k) = X2;
end

sAP = size(AxPoints);

%задаем номер эллипса, от которого начнем движение
i_far = 1;
%инициализируем матрицу точек маршрута
WPoints = zeros(2, 2*sAP(3));
WPoints(:,1) = AxPoints(:,1,i_far);
WPoints(:,2) = AxPoints(:,2,i_far);
AxPoints(:,:,1) = [];

for j = 1:sAP(3)
    s = size(AxPoints);
    ss = size(s);
    if (ss(2) < 3)
        temp1 = sqrt( (WPoints(1,2*j)-AxPoints(1,1))^2 + (WPoints(2,2*j)-AxPoints(2,1))^2);
        temp2 = sqrt( (WPoints(1,2*j)-AxPoints(1,2))^2 + (WPoints(2,2*j)-AxPoints(2,2))^2);
        if (temp1 > temp2)
            WPoints(:,2*j+1) = AxPoints(:,2);
            WPoints(:,2*j+2) = AxPoints(:,1);
        else
            WPoints(:,2*j+1) = AxPoints(:,1);
            WPoints(:,2*j+2) = AxPoints(:,2);
        end
        break;
    end
    %инициализируем начальное "расстояние"
    far = sBW(1) + sBW(2);
    for i = 1:s(3)
        %считаем расстояние от второй точки оси предыдущей, 
        temp = sqrt( (WPoints(1,2*j)-AxPoints(1,1,i))^2 + (WPoints(2,2*j)-AxPoints(2,1,i))^2);
        if temp < far
            far = temp;
            i_far = i;
        end  
    end
    WPoints(:,2*j+1) = AxPoints(:,1,i_far);
    WPoints(:,2*j+2) = AxPoints(:,2,i_far);
    AxPoints(:,:,i_far) = [];

end
plot(WPoints(2,:), WPoints(1,:),'m' );

