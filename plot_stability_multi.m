function plot_stability_multi(Rs, xrange, yrange, N, colors, alphas, labels)
% plot_stability_multi(Rs, xrange, yrange, N, colors, alphas, labels)
%   Rs      : cell array of function handles {R1, R2, ...} for amplification factors
%   xrange  : [xmin xmax] for Re(z)
%   yrange  : [ymin ymax] for Im(z)
%   N       : grid size per axis (default 600)
%   colors  : Kx3 RGB in [0,1] (optional; default = lines(K))
%   alphas  : 1xK or Kx1 transparency per method in [0,1] (optional; default = 0.35)
%   labels  : cellstr for legend entries (optional)
%
% Notes:
% - Shades region {z: |R(z)| <= 1} with specified alpha per method.
% - Plots |R(z)|=1 boundary curves for each method.
% - Overlaps appear darker automatically due to alpha blending.

    if nargin < 4 || isempty(N), N = 600; end
    K = numel(Rs);
    if nargin < 5 || isempty(colors), colors = lines(K); end
    if size(colors,1) ~= K
        error('colors must be Kx3 to match number of methods.');
    end
    if nargin < 6 || isempty(alphas), alphas = 0.35*ones(K,1); end
    if numel(alphas) ~= K, error('alphas must have K elements.'); end
    if nargin < 7, labels = arrayfun(@(k)sprintf('Method %d',k), 1:K, 'uni',0); end

    % Grid
    x = linspace(xrange(1), xrange(2), N);
    y = linspace(yrange(1), yrange(2), N);
    [X,Y] = meshgrid(x,y);
    Z = X + 1i*Y;

    clf; hold on
    set(gca,'YDir','normal'); axis equal tight
    xlabel('\Re(z)'); ylabel('\Im(z)');
    title('$|R(z)| \leq 1$','Interpreter','latex');

    % Layer each method as an image with AlphaData = mask
    hLines = gobjects(1,K);
    for k = 1:K
        % Stability mask
        G = arrayfun(@(w) abs(Rs{k}(w)), Z);
        mask = G <= 1;

        % Colored layer with per-pixel alpha (0 outside, alpha(k) inside)
        C = repmat(reshape(colors(k,:),1,1,3), N, N); % solid color image
        hImg = image('XData', x, 'YData', y, 'CData', C);
        set(hImg, 'AlphaData', alphas(k) * double(mask));

        % Boundary
        [~, hLines(k)] = contour(x, y, G, [1 1], 'Color', colors(k,:), 'LineWidth', 1.5);
    end

    grid on
    box on
    if ~isempty(labels)
        legend(hLines, labels, 'Location','best');
    end
end