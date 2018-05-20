clear;
load 'fields/Field 3.mat';
%M=M.*10;
global Mdx Mdy
Mdx = 200; %шаг сетки (м)
Mdy = 200; %шаг сетки (м)
[X,Y] = meshgrid(1:Mdx/1000:31, 1:Mdy/1000:31);
M = interp2(M,X,Y,'spline');
[dX,dY] = gradient(M, Mdx, Mdy);
[alpha, beta] = get_directions2(dX,dY)