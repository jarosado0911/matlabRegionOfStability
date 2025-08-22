% Define amplification factors
R_FE  = make_explicit_R([1 1]);                      % Forward Euler: 1 + z
R_Heun= make_explicit_R([1 1 1/2]);                  % Heun: 1 + z + z^2/2
R_RK4 = make_explicit_R([1 1 1/2 1/6 1/24]);         % RK4
R_BE  = make_rational_R([1], [1]);                   % Backward Euler: 1/(1 - z)

Rs      = {R_FE, R_Heun, R_RK4, R_BE};
labels  = {'Forward Euler','Heun (RK2)','RK4','Backward Euler'};
colors  = [0.85 0.33 0.1; 0 0.45 0.74; 0.47 0.67 0.19; 0.49 0.18 0.56];
alphas  = [0.35 0.35 0.35 0.25];

plot_stability_multi(Rs, [-6 2], [-6 6], 400, colors, alphas, labels);
