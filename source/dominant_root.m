function xi = dominant_root(rho, sigma, z)
    % Build coefficients of p(xi) = rho(xi) - z*sigma(xi)
    p = rho - z.*sigma;
    rts = roots(p);
    [~, k] = max(abs(rts));
    xi = rts(k);
end
