function M_rt = route_points(AxPoints,STN)


%�������� ��������� �� �������� � ������� ����������

%������ ����� ��������� �� ��������
d_mnt = 300; %���������� ����� ����������� (�)
if strcmp(STN.mn_num, 'A')==1
    for i = 1:size(AxPoints,3)
        d = pdist(AxPoints(:,:,i),'euclidean');
        num = fix(d/d_mnt);
        xp = linspace(AxPoints(1,1,i),AxPoints(2,1,i),num); %����� �� x � ������
        yp = linspace(AxPoints(1,2,i),AxPoints(2,2,i),num); %����� �� y � ������
        pts{i} = [xp',yp'];

    end
else
    for i = 1:size(AxPoints,3)
        xp = linspace(AxPoints(1,1,i),AxPoints(2,1,i),STN.mn_num); %����� �� x � ������
        yp = linspace(AxPoints(1,2,i),AxPoints(2,2,i),STN.mn_num); %����� �� y � ������
        pts{i} = [xp',yp'];

    end
end   
%���������, ��� ����� �������� ����� � ������� �����
M_rt.pts = check_bounds(pts,STN);
M_rt.prt_num = length(M_rt.pts);
M_rt.pts_num = sum(cellfun('length',M_rt.pts));

end