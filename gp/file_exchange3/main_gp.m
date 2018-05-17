 % build the correlation struct
  corr.name = 'exp';
  corr.c0 = [1 1]; % anisotropic correlation

  x = linspace(-1,1,100);
  [X,Y] = meshgrid(x,x); mesh = [X(:) Y(:)]; % 2-D mesh

  % set a spatially varying variance (must be positive!)
  corr.sigma = cos(pi*mesh(:,1)).*sin(2*pi*mesh(:,2))+1.5;

  [F,KL] = randomfield(corr,mesh,...
              'trunc', 10);

  % plot the realization
  M = reshape(F,100,100);
  surf(X,Y,M); view(2); colorbar;
  