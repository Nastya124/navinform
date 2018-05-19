function [alpha, beta] = get_directions(dX,dY)

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