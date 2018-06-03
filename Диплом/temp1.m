clear; close all;
load 'fields/Field 12.mat';
%M=M.*10;
global Mdx Mdy
Mdx = 200; %шаг сетки (м)
Mdy = 200; %шаг сетки (м)
[X,Y] = meshgrid(1:Mdx/1000:31, 1:Mdy/1000:31);
M = interp2(M,X,Y,'spline');
mesh(X,Y,M)
[dX,dY] = gradient(M, Mdx, Mdy);
[alpha, beta] = get_directions2(dX,dY)
hold on;
quiver(0,-10,10*cos(alpha),10*sin(alpha))
quiver(0,-10,10*cos(beta),10*sin(beta))
[alpha, beta] = get_directions3(dX,dY)
quiver(10,-10,10*cos(alpha),10*sin(alpha))
quiver(10,-10,10*cos(beta),10*sin(beta))