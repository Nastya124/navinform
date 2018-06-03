function P  = conditional_cov_matrix(X, dX,dY, P_x,r)
%����� � - ������� ����� ��������, dX, dY - ������� ����������� ����
%P_x � r - ��������� �������

%������ ������������ ����� ���������:
mnt_num = max(size(X));

P = zeros(2,2,mnt_num+1);
P(:,:,1) = P_x;


for i = 1:mnt_num
    %������� �� ������������ ������������
    H(1) = interp2(dX,X(1,i),X(2,i));
    H(2) = interp2(dY,X(1,i),X(2,i));
    %P(:,:,i+1) = (P(:,:,i)^-1 + H'*r^-1*H)^-1;
    K = P(:,:,i)*H'*(H*P(:,:,i)*H'+r)^-1;
    E = eye(2);
    P(:,:,i+1) = (E - K*H)*P(:,:,i);
    
    %������� �� ������� �������
%     H = zeros(i,2);
%      H(:,1) = interp2(dX,X(1,1:i),X(2,1:i));
%      H(:,2) = interp2(dY,X(1,1:i),X(2,1:i));
%      P(:,:,i+1) = inv(P_x^(-1) + (H'*r^(-1)*H));
end

end