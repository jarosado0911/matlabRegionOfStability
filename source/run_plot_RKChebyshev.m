function R = RKC1_R(s, eps)
% First-order RKC stability function
if nargin<2, eps = 0.05; end
w0 = 1 + eps/s^2;
[T, U] = cheb();                         % Chebyshev helpers
Tp  = s * U(s-1, w0);                    % T_s'(w0) = s U_{s-1}(w0)
w1  = T(s, w0) / Tp;
R = @(z) T(s, w0 + w1*z) / T(s, w0);
end

function R = RKC2_R(s, eps)
% Second-order RKC stability function
if nargin<2, eps = 0.05; end
w0 = 1 + eps/s^2;
[T, U] = cheb();
Tp  = s * U(s-1, w0);                                % T'
Tpp = s * ( w0*U(s-1,w0) - s*T(s,w0) ) / (1 - w0^2); % T'' via identity
w1  = Tp / Tpp;
beta = Tpp / (Tp^2);
alpha = 1 - beta*T(s, w0);
R = @(z) alpha + beta * T(s, w0 + w1*z);
end

function [T,U] = cheb()
% Chebyshev T_n, U_n valid for all real x (vectorized)
T = @(n,x) arrayfun(@(xx) ...
    (abs(xx)<=1)*cos(n*acos(xx)) + ...
    (xx>1)    *cosh(n*acosh(xx)) + ...
    (xx<-1)   *(((-1)^n)*cosh(n*acosh(-xx))), x);
U = @(n,x) arrayfun(@(xx) ...
    (abs(xx)<1) * (sin((n+1)*acos(xx))/sqrt(1-xx^2)) + ...
    (xx>1)      * (sinh((n+1)*acosh(xx))/sqrt(xx^2-1)) + ...
    (xx<-1)     * (((-1)^n)*sinh((n+1)*acosh(-xx))/sqrt(xx^2-1)), x);
end
s = 50; eps = 0.05;
R1 = RKC1_R(s, eps);
R2 = RKC2_R(s, eps);

figure; plot_stability(R1, [-2000 1], [-2*s 2*s], 700, 0.30, 0.18);
title(sprintf('RKC1 (s=%d)', s), 'Interpreter','latex');

figure; plot_stability(R2, [-2000 1], [-1.7*s 1.7*s], 700, 0.30, 0.18);
title(sprintf('RKC2 (s=%d)', s), 'Interpreter','latex');
