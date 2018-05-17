%y = x_1^2+x_2^2 при разных множителях при x соотношение оценок меняется
% рисуем поверхность
close all
clear
[X1,X2] = meshgrid(0:15, 0:15);
figure(3)
Y = X1.^2 + X2.^2;
surf(Y)

%назначаем максимальное число измерений:
 H_size_max = 15;
 P_rand = zeros(H_size_max,2,2);
 P_zero = P_rand;
 P_one = P_rand;

%устанавливаем шаг:
%step_interval = 1;
%назначаем число итераций:
n_iter = 500;

%задаем параметры шума датчика и оцениваемого вектора
r = 4;
P_x = [100 0; 0 100];

for H_size = 1:H_size_max
    H = zeros(H_size,2);
    p_rand = zeros(2);
    p_zero = p_rand;     
    p_one = p_rand;
    for i = 1:n_iter
        start_point_1 = rand();
        start_point_2 = rand();
        for k =  1:H_size
            H(k,1) = 2*(start_point_1 + (k-1));
            H(k,2) = 2*(start_point_2 + (k-1));
        end
        
        p_rand = p_rand + inv(P_x^(-1) + (H'*r^(-1)*H));
        
    end
    P_rand(H_size,:,:) = p_rand/n_iter;
    
    %здесь точка не нули, а (0,1)
     H_zero = zeros(H_size,2);   
     for k = 1:H_size
         H_zero(k,1) = 2*(k-1);
         H_zero(k,2) = 2*(k);
     end
     
     %здесь точка не единицы, а (1,0)
     H_one = zeros(H_size,2);
     for k = 1:H_size
         H_one(k,1) = 2*(k);
         H_one(k,2) = 2*(k-1);
     end
     P_zero(H_size,:,:) = inv( P_x^(-1) + (H_zero'*r^(-1)*H_zero) );
     P_one(H_size,:,:) = inv( P_x^(-1) + (H_one'*r^(-1)*H_one) );
end
F1 = figure(1);
plot(P_rand(:,1,1));
hold on;
plot(P_zero(:,1,1));
plot(P_one(:,1,1));
legend('rand','zero', 'one');
F2 = figure(2);
plot(P_rand(:,2,2));
hold on;
plot(P_zero(:,2,2));
plot(P_one(:,2,2));
legend('rand','zero', 'one');
 