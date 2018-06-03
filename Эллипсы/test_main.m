%% Test FITELLIPSE - run through all possibilities
% Example
%% 1) Linear fit, bookstein constraint
% Data points
x = [5 10 5 0 7 3;
     0 5 10 5 7 3];

[z, a, b, alpha] = fitellipse(x, 'linear');

%% 2) Linear fit, Trace constraint
% Data points
%x = [5 10 5 0 7 1;
%     0 5 10 5 7 1];

%[z, a, b, alpha] = fitellipse(x, 'linear', 'constraint', 'trace');

%% 3) Nonlinear fit
% Data points


%[z, a, b, alpha] = fitellipse(x);

% Changing the tolerance, maxits
%[z, a, b, alpha] = fitellipse(x, 'tol', 1e-8, 'maxits', 100);

%% Plotting
hF = figure();
hAx = axes('Parent', hF);
h = plotellipse(hAx, z, a, b, alpha, 'r.');

hold on
plotellipse(z, a, b, alpha)
