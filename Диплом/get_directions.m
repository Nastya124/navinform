function [alpha, beta] = get_directions(dX,dY, method)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Методы:
%% 1 - максимум градиента и ортогональное ему направление
%% 2 - максимум функционала (среднее суммы квадратов максимумов)
%% 3 - преобладающие направления градиента на поле, через разложение ковариационной матрицы
%% 4 - фиксированный 0,pi/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

if method == 1
    ang = atan2(dY, dX);
    ang2 = mod(ang,pi);
    mod2 = sqrt(dX.^2+dY.^2);

    ang2 = reshape(ang2.',1,[]);
    mod2 = reshape(mod2.',1,[]);

    [~, I] = max(mod2);
    alpha = ang2(I);


    max_function = 0;

    for i = 1:length(ang2)
        koef = mod2(i)*sin(abs(alpha-ang2(i))).^2;
        if (koef > max_function)
            beta = ang2(i);
            max_function = koef;
        end
    end
    % alpha=alpha*180/pi;
    % beta = beta*180/pi;

end
if method == 2
   
    maxv = 0;
    for i =0:pi/2/1000:pi/2
    alpha = i;
    beta = i+pi/2;
    dAlpha = dX*cos(alpha)+dY*sin(alpha);
    dBeta = dX*cos(beta)+dY*sin(beta);
    An = max(max(abs(dAlpha)));
    Bn = max(max(abs(dBeta)));
    maxmod = sqrt(An^2+Bn^2);
    if maxmod>maxv
        a_max = i;
        maxv = maxmod;
    end
     alpha   = a_max;%*180/pi;
     beta = alpha+pi/2;
    end 

end

if method == 3
   
    d = cov([dX(:), dY(:)]);
    [V,D] = eig(d);

    alpha = wrapToPi(atan2(V(2,1),V(1,1)));
    beta = wrapToPi(atan2(V(2,2),V(1,2)));
    if alpha<0
        alpha = alpha+pi;
    end

    if beta<0
        beta = beta+pi;
    end

end
if method == 4
    alpha = 0;
    beta = pi/2;
end