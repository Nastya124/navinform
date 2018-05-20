%��������:
%1)�������� �����
% 2) ����� -> ������ ����������� -> (2 �����)
% 3) ��������� �����
% 4) ������������� ����� ��������� -> ������� ����� ��������
% 5) ����� �������� �� ������, �������� � ����� �������
% 6) -> ������ �������� ���������� ��� ����� ��������
% 7) ���������� ���������� P.

clear
%M = peaks(200);
 close all
load 'fields/Field 3.mat';
%M=M.*10;
global Mdx Mdy
Mdx = 200; %��� ����� (�)
Mdy = 200; %��� ����� (�)
[X,Y] = meshgrid(0:Mdx/1000:30, 0:Mdy/1000:30);
M = interp2(M,X,Y,'spline');

%������ ��������� ���� ������� � ������������ �������
r = 1;
P_x = [1000000 0; 0 1000000];

%�������� ������� ����������� �� ������������ � �������������� ����� ���
%������ �� ���������
[dX,dY,dXb,dYb,dAlpha,dAlpha_b,dBeta,dBeta_b,alpha,beta] = map(M);
%**************************************************
%!!!!!!��� ������ ����������� X � Y!!!!!!!!!!!!!!!!
%�������� ����� ��������
 route_points_x = route_points(dXb);
 route_points_y = route_points(dYb);
 
%��������� �������� ���������� ��� ������ �� ���������
% P_unc_x = unconditional_cov_matrix(route_points_x, dX, dY, P_x, r);
% P_unc_y = unconditional_cov_matrix(route_points_y, dX, dY, P_x, r);

%��������� � ��������� �� "����������" ��������
%route_points_exp(1,:) = linspace(20,25,max(size(route_points_x)));
%route_points_exp(2,:) = linspace(3,48,max(size(route_points_x)));
%P_exp = conditional_cov_matrix(route_points_exp, dX, dY, P_x, r);

% figure();
% subplot(2,1,1)
% hold on
% plot(sqrt(squeeze(P_unc_x(1,1,:))));
% plot(sqrt(squeeze(P_unc_x(2,2,:))));
% legend('Px_u', 'Py_u');
% title('��� ���� �� �������� ��� ���������� �');
% xlabel('���������� ���������')
% ylabel('���, �')
% subplot(2,1,2)
% hold on
% plot(sqrt(squeeze(P_unc_y(1,1,:))));
% plot(sqrt(squeeze(P_unc_y(2,2,:))));
% legend('Px_u', 'Py_u');
% title('��� ���� �� �������� ��� ���������� Y');
% xlabel('���������� ���������')
% ylabel('���, �')
%%plot(sqrt(squeeze(P_exp(1,1,:))));
%%plot(sqrt(squeeze(P_exp(2,2,:))));
%%legend('Px', 'Py', 'P_exp_x', 'P_exp_y');
%%title('��� �� �������� ��� ���������� �');
%**************************************************

 route_points_a = route_points(dAlpha_b);
 route_points_b = route_points(dBeta_b);
 
 P_unc_a = unconditional_cov_matrix(route_points_a, dX, dY, P_x, r);
 P_unc_b = unconditional_cov_matrix(route_points_b, dX, dY, P_x, r);
 
 route_points_xy = [route_points_x route_points_y];
 route_points_ab = [route_points_a route_points_b];
 
 P_unc_xy = unconditional_cov_matrix(route_points_xy, dX, dY, P_x, r);
 P_unc_ab = unconditional_cov_matrix(route_points_ab, dX, dY, P_x, r);
 
 %plot_everything
 
 %  subplot(2,1,1)
%  hold on
%  plot(sqrt(squeeze(P_unc_xy(1,1,:))));
%  plot(sqrt(squeeze(P_unc_ab(1,1,:))));
%  legend('Pxy_u', 'Pab_u');
%  title('���� ���������� X �� ������������ XY � alpha-beta');
%  xlabel('���������� ���������')
%  ylabel('���, �')
%  subplot(2,1,2)
%  hold on
%  plot(sqrt(squeeze(P_unc_xy(2,2,:))));
%  plot(sqrt(squeeze(P_unc_ab(2,2,:))));
%  legend('Pxy_u', 'Pab_u');
%  title('���� ���������� Y �� ������������ XY � alpha-beta');
%  xlabel('���������� ���������')
%  ylabel('���, �')
