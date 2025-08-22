function R = make_BDF_R(k)
    switch k
        case 2, rho = [3/2,  -2,     1/2];
        case 3, rho = [11/6, -3,     3/2,   -1/3];
        case 4, rho = [25/12,-4,     3,     -4/3,   1/4];
        case 5, rho = [137/60,-5,    5,     -10/3,  5/4,   -1/5];
        case 6, rho = [147/60,-6,    15/2,  -20/3,  15/4,  -6/5,  1/6];
        otherwise, error('BDF order k must be 2..6');
    end
    sigma = [1, zeros(1, numel(rho)-1)];   % σ(ξ) = ξ^k
    R = make_LMM_R(rho, sigma);
end