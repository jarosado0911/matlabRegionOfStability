function plot_stability(R, xrange, yrange, N)
% plot_stability(R, xrange, yrange, N)
%    R      : function handle for amplification factor R(z)
%    xrange : [xmin xmax] for Re(z)
%    yrange : [ymin ymax] for Im(z)
%    N      : grid size per axis (default 600)

    if nargin < 4, N = 600; end
    x = linspace(xrange(1), xrange(2), N);
    y = linspace(yrange(1), yrange(2), N);
    [X,Y] = meshgrid(x,y);
    Z = X + 1i*Y;

    % Evaluate |R(z)| on the grid (vectorized via arrayfun)
    G = arrayfun(@(w) abs(R(w)), Z);

    % Plot filled stability region and the |R(z)|=1 boundary
    imagesc(x, y, G <= 1); set(gca,'YDir','normal'); axis equal tight
    hold on
    contour(x, y, G, [1 1], 'k', 'LineWidth', 1.5); % boundary
    hold off
    xlabel('Re(z)'), ylabel('Im(z)')
    title('Absolute stability region: |R(z)| $\le$ 1','Interpreter','latex')
    colormap([1 1 1; 0.6 0.8 1])  % white = unstable, light blue = stable
    colorbar('Ticks',[0 1],'TickLabels',{'unstable','stable'})
end