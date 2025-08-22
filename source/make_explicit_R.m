function R = make_explicit_R(coeffs)
% coeffs = [c0 c1 c2 ... cm] so that R(z) = c0 + c1 z + ... + cm z^m
    R = @(z) polyval(flip(coeffs), z);  % polyval expects highest power first
end
