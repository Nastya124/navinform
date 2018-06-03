function M_rt = route_points(AxPoints,STN)


%получаем измерения на отрезках с высоким градиентом

%задаем число измерений на отрезках
d_mnt = 300; %расстояние между измерениями (м)
if strcmp(STN.mn_num, 'A')==1
    for i = 1:size(AxPoints,3)
        d = pdist(AxPoints(:,:,i),'euclidean');
        num = fix(d/d_mnt);
        xp = linspace(AxPoints(1,1,i),AxPoints(2,1,i),num); %точки по x в метрах
        yp = linspace(AxPoints(1,2,i),AxPoints(2,2,i),num); %точки по y в метрах
        pts{i} = [xp',yp'];

    end
else
    for i = 1:size(AxPoints,3)
        xp = linspace(AxPoints(1,1,i),AxPoints(2,1,i),STN.mn_num); %точки по x в метрах
        yp = linspace(AxPoints(1,2,i),AxPoints(2,2,i),STN.mn_num); %точки по y в метрах
        pts{i} = [xp',yp'];

    end
end   
%проверяем, что точки маршрута лежат в области карты
M_rt.pts = check_bounds(pts,STN);
M_rt.prt_num = length(M_rt.pts);
M_rt.pts_num = sum(cellfun('length',M_rt.pts));

end