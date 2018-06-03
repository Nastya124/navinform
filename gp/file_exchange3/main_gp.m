%close all 
%  rng(1)
% build the correlation struct
  corr.name = 'gauss';
  corr.c0 = [50 50]; % anisotropic correlation
  %corr.c1 = 50;
  x = linspace(0,29,30);
  [X,Y] = meshgrid(x,x); mesh = [X(:) Y(:)]; % 2-D mesh

  % set a spatially varying variance (must be positive!)
  corr.sigma = 300;

  for i =1:1
  [F,KL] = randomfield(corr,mesh,...
              'trunc', 15);
%   [F,KL] = randomfield(corr,mesh);
          


  % plot the realization
  M = reshape(F,30,30);
  savefile = sprintf('Field %s.mat', num2str(i));
  save(savefile, 'M');	
  end
  figure(2);
  surf(X,Y,M); view(2); colorbar;
%   figure
%   contour(M)
%   