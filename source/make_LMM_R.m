function R = make_LMM_R(rho, sigma)
% R(z): returns the dominant root xi of rho(xi) - z*sigma(xi) = 0
% rho, sigma: coefficient vectors for polynomials in DESCENDING powers of xi
% Example: rho = [1 -1 0] means rho(xi) = xi^2 - xi
    rho = rho(:).';  sigma = sigma(:).';
    m = max(numel(rho), numel(sigma));
    rho = [zeros(1,m-numel(rho)) rho];
    sigma = [zeros(1,m-numel(sigma)) sigma];
    R = @(z) dominant_root(rho, sigma, z);
end

