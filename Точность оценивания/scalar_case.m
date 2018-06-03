
%назначаем максимальное число измерений:
H_size_max = 15;
P_rand = zeros(H_size_max,1);
P_zero = P_rand;
P_one = P_rand;
%устанавливаем шаг:
step_interval = 1;
%назначаем число итераций:
n_iter = 15;
%задаем параметры шума датчика и оцениваемого вектора
r = 4;
P_x = 100;

for H_size = 1:H_size_max
    H = zeros(H_size,1);
    p_rand = 0;
    p_zero = 0;
    p_one = 0;
    for i = 1:n_iter
        start_point = rand();
        for k =  1:H_size
            H(k) = 2*(start_point+step_interval*(k-1));
        end
        %H = [2*start_point; 2*(start_point+1); 2*(start_point+2); 2*(start_point+3); 2*(start_point+4)];
        p_rand = p_rand + 1/( 1/P_x + (1/r)*(H'*H) );
        
    end
    P_rand(H_size) = p_rand/n_iter;
    
    H_zero = zeros(H_size,1);   
    for k = 1:H_size
        H_zero(k) = 2*(k-1);
    end
    H_one = zeros(H_size,1);
    for k = 1:H_size
        H_one(k) = 2*k;
    end
    P_zero(H_size) = 1/( 1/P_x + (1/r)*(H_zero'*H_zero) );
    P_one(H_size) = 1/( 1/P_x + (1/r)*(H_one'*H_one) );
end
plot(P_rand);
hold on;
plot(P_zero);
plot(P_one);
legend('rand','zero', 'one');
 