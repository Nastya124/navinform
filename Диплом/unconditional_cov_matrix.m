function P = unconditional_cov_matrix(X, dX,dY, P_x,r)
%����� � - ������� ����� ��������, dX, dY - ������� ����������� ����

%������ ����� �������� ��� �������� ����������� ������� ����������
n_iter = 10;

mnt_num = max(size(X));
P = zeros(2,2,mnt_num+1);

for j = 1:n_iter
    dev_x = mvnrnd(zeros(2,1),P_x/1000000);
    X_rand(1,:) = X(1,:) + dev_x(1);
    X_rand(2,:) = X(2,:) + dev_x(2);
    X_rand = check_bounds(X_rand,min(size(dX)),2);
    P = P + conditional_cov_matrix(X_rand, dX,dY, P_x,r);
end
P = P/n_iter;