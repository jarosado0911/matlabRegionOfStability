% Define amplification factors
R_FE  = make_explicit_R([1 1]);                      % Forward Euler: 1 + z
R_Heun= make_explicit_R([1 1 1/2]);                  % Heun: 1 + z + z^2/2
R_RK4 = make_explicit_R([1 1 1/2 1/6 1/24]);         % RK4
R_BE  = make_rational_R([1], [1]);                   % Backward Euler: 1/(1 - z)

% special methods
R_TRBDF2 = @(z) (12 + 5*z) ./ (12 - 7*z + z.^2);
R_Gauss1 = @(z) (1 + 0.5*z) ./ (1 - 0.5*z);
R_Gauss2 = @(z) (1 + 0.5*z + (z.^2)/12) ./ (1 - 0.5*z + (z.^2)/12);
R_Radau2 = @(z) (1 + z/3) ./ (1 - (2/3)*z + (z.^2)/6);
R_SSP33 = @(z) 1 + z + 0.5*z.^2 + (1/6)*z.^3;

% AM1 (Backward Euler):  y_{n+1} = y_n + h f_{n+1}
R_AM1 = make_LMM_R([1 -1], [1 0]);                      % (ρ=ξ-1, σ=ξ)

% AM2 (Trapezoid):       y_{n+1} = y_n + h/2 (f_{n+1}+f_n)
R_AM2 = make_LMM_R([1 -1], [1/2 1/2]);                  % (ρ=ξ-1, σ=(ξ+1)/2)

% AM3: y_{n+1} = y_n + h/12 (5 f_{n+1} + 8 f_n - f_{n-1})
R_AM3 = make_LMM_R([1 -1  0], [5/12  8/12  -1/12]);     % (ρ=ξ^2-ξ, σ=(5ξ^2+8ξ-1)/12)

% AM4: y_{n+1} = y_n + h/24 (9 f_{n+1} + 19 f_n - 5 f_{n-1} + f_{n-2})
R_AM4 = make_LMM_R([1 -1  0   0], [9/24 19/24 -5/24 1/24]); % (ρ=ξ^3-ξ^2, σ=...)


% BDF2:  (3/2) y_n - 2 y_{n-1} + (1/2) y_{n-2} = h f_n
R_BDF2 = make_LMM_R([3/2,   -2,     1/2],        [1, 0, 0]);

% BDF3:  (11/6) y_n - 3 y_{n-1} + (3/2) y_{n-2} - (1/3) y_{n-3} = h f_n
R_BDF3 = make_LMM_R([11/6,  -3,     3/2,   -1/3], [1, 0, 0, 0]);

% BDF4:  (25/12) y_n - 4 y_{n-1} + 3 y_{n-2} - (4/3) y_{n-3} + (1/4) y_{n-4} = h f_n
R_BDF4 = make_LMM_R([25/12, -4,     3,     -4/3,   1/4],       [1, 0, 0, 0, 0]);

% BDF5:  (137/60) y_n - 5 y_{n-1} + 5 y_{n-2} - (10/3) y_{n-3} + (5/4) y_{n-4} - (1/5) y_{n-5} = h f_n
R_BDF5 = make_LMM_R([137/60,-5,     5,     -10/3,  5/4,  -1/5], [1, 0, 0, 0, 0, 0]);

% BDF6:  (147/60) y_n - 6 y_{n-1} + (15/2) y_{n-2} - (20/3) y_{n-3} + (15/4) y_{n-4} - (6/5) y_{n-5} + (1/6) y_{n-6} = h f_n
R_BDF6 = make_LMM_R([147/60,-6,    15/2,   -20/3,  15/4, -6/5,  1/6], [1, 0, 0, 0, 0, 0, 0]);



Rs     = {R_FE, R_Heun, R_RK4, R_BE,...
          R_TRBDF2, R_Gauss1, R_Gauss2, R_Radau2, R_SSP33, ...
          R_AM1, R_AM2, R_AM3, R_AM4, ...
          R_BDF2, R_BDF3, R_BDF4, R_BDF5, R_BDF6};
labels = {'Forward Euler','Heun (RK2)','RK4','Backward Euler', ...
           'TR-BDF2','Gauss(1)','Gauss(2)','RadauIIA(2)','SSPRK(3,3)', ...
           'AdamsM(1)','AdamsM(2)','AdamsM(3)','AdamsM(4)', ...
           'BDF(2)', 'BDF(3)','BDF(4)', 'BDF(5)', 'BEF(6)'};

xrange = [-20 20];
yrange = [-20 20];
N      = 200;

for k = 1:numel(Rs)
    figure('Name', labels{k}, 'Color', 'w');  % new window per method
    plot_stability(Rs{k}, xrange, yrange, N); % your function (4-arg version)
    title(sprintf('%s: $|R(z)| \\leq 1$', labels{k}), 'Interpreter','latex');
end