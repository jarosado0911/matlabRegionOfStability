% Helpers (ensure you have these)
% make_rational_R.m
%   a = [a1 ... ap] for (1 - a1 z - ... - ap z^p) y_{n+1} = (b0 + b1 z + ... ) y_n
%   b = [b0 b1 ... bq]
R_theta = @(theta) make_rational_R([theta], [1 (1-theta)]);

% Pick a few interesting thetas
thetas = [0, 0.5, 0.75, 1.0];   % FE, Trapezoid, "stiff-ish", BE
labels = arrayfun(@(t) sprintf('\\theta = %.2g', t), thetas, 'uni', 0);

Rs = cellfun(@(t) R_theta(t), num2cell(thetas), 'uni', 0);

% Colors and alphas (tweak to taste)
colors = [ ...
    0.85 0.33 0.10;  % theta=0   (Forward Euler)
    0.00 0.45 0.74;  % theta=0.5 (Trapezoid)
    0.47 0.67 0.19;  % theta=0.75
    0.49 0.18 0.56]; % theta=1   (Backward Euler)
alphas = [0.35 0.35 0.35 0.25];

% Plot multiple stability regions with overlap transparency
plot_stability_multi(Rs, [-6 2], [-6 6], 300, colors, alphas, labels);
