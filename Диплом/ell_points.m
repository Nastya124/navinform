function AxPoints = ell_points(dXb,STN)
%выделяем контура на полученных картах
[Bx,~,N,~] = bwboundaries(dXb,'noholes');

%делаем структуру для точек
AxPoints = zeros(2,2,N);
   
for k=1:N
    boundary = Bx{k};
    try
    [z, a, ~, alpha] = fitellipse(boundary, 'linear', 'constraint', 'trace');
    catch
       continue;
    end
        
    %вычисляем начало большой оси (м)
    X1(2) = (z(1)+a*cos(alpha)-1)*STN.Mdx;
    X1(1) = (z(2)+a*sin(alpha)-1)*STN.Mdy;
    AxPoints(1,:,k) = X1;
    
    %вычисляем конец большой оси (м)
    X2(2) = (z(1)-a*cos(alpha)-1)*STN.Mdx;
    X2(1) = (z(2)-a*sin(alpha)-1)*STN.Mdy;
    AxPoints(2,:,k) = X2;
end