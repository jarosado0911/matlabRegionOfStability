function R = make_rational_R(a, b)
% a = [a1 a2 ... ap]  for LHS: 1 - a1 z - a2 z^2 - ... - ap z^p
% b = [b0 b1 ... bq]  for RHS: b0 + b1 z + ... + bq z^q
    a = a(:).';  b = b(:).';               % ensure row vectors
    denom_poly = [fliplr(a) 0];            % a_p z^p + ... + a1 z + 0
    numer_poly = fliplr(b);                 % b_q z^q + ... + b1 z + b0
    R = @(z) polyval(numer_poly, z) ./ (1 - polyval(denom_poly, z));
end
