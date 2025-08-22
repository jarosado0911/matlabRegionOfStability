function plot_stability(R, xrange, yrange, N, alphaStable, alphaUnstable)
% plot_stability(R, xrange, yrange, N, alphaStable, alphaUnstable)
%    R      : function handle for amplification factor R(z)
%    xrange : [xmin xmax] for Re(z)
%    yrange : [ymin ymax] for Im(z)
%    N      : grid size per axis (default 600)
%    alphaStable/alphaUnstable : transparencies in [0,1] (defaults 0.35)

    if nargin < 4 || isempty(N), N = 600; end
    if nargin < 5 || isempty(alphaStable),   alphaStable   = 0.35; end
    if nargin < 6 || isempty(alphaUnstable), alphaUnstable = 0.35; end

    x = linspace(xrange(1), xrange(2), N);
    y = linspace(yrange(1), yrange(2), N);
    [X,Y] = meshgrid(x,y);
    Z = X + 1i*Y;

    % Evaluate |R(z)|
    G = arrayfun(@(w) abs(R(w)), Z);
    maskStable   = (G <= 1);
    maskUnstable = ~maskStable;

    clf; hold on

    % --- Colored transparent layers (stable = blue, unstable = red) ---
    blue = [0 0.4470 0.7410];
    red  = [0.8500 0.3250 0.0980];
    Cblue = repmat(reshape(blue,1,1,3), N, N);
    Cred  = repmat(reshape(red ,1,1,3), N, N);

    imgBlue = image('XData', x, 'YData', y, 'CData', Cblue);
    set(imgBlue, 'AlphaData', alphaStable * double(maskStable));

    imgRed = image('XData', x, 'YData', y, 'CData', Cred);
    set(imgRed, 'AlphaData', alphaUnstable * double(maskUnstable));

    % Fix orientation/limits/aspect
    ax = gca;
    set(ax, 'YDir','normal');
    axis equal
    xlim(xrange); ylim(yrange);

    % Boundary |R(z)| = 1 on top
    [~,hC] = contour(x, y, G, [1 1], 'k', 'LineWidth', 1.5);
    ax.Layer = 'top';

    % --- Axes styling: ticks inside, boxed, minor ticks + minor grid ---
    ax.TickDir    = 'in';
    ax.TickLength = [0.015 0.015];
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.Box        = 'on';
    grid(ax, 'on');          % main grid
    grid(ax, 'minor');       % minor grid lines

    % --- Put numeric axes through the origin (labels on interior axes) ---
    didOrigin = false;
    try
        ax.XAxisLocation = 'origin';
        ax.YAxisLocation = 'origin';
        didOrigin = true;
    catch
        % Older MATLAB: fall back to drawing lines at the origin
    end
    if ~didOrigin
        if yrange(1) <= 0 && yrange(2) >= 0
            plot([xrange(1) xrange(2)], [0 0], 'k-', 'LineWidth', 1, 'HandleVisibility','off');
        end
        if xrange(1) <= 0 && xrange(2) >= 0
            plot([0 0], [yrange(1) yrange(2)], 'k-', 'LineWidth', 1, 'HandleVisibility','off');
        end
    end

    % Legend (dummy patches to show colors/alphas)
    hStable   = patch(NaN, NaN, blue, 'FaceAlpha', alphaStable,   'EdgeColor','none');
    hUnstable = patch(NaN, NaN, red,  'FaceAlpha', alphaUnstable, 'EdgeColor','none');
    legend([hStable, hUnstable, hC], {'stable','unstable','|R(z)|=1'}, 'Location','best');

    xlabel('Re(z)'); ylabel('Im(z)');
    title('Absolute stability region: $|R(z)| \leq 1$', 'Interpreter','latex');

    hold off
end