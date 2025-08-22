function R = make_RK_R(A, b)
% Returns a function handle R(z) for the RK method with Butcher (A,b)
    A = double(A); b = double(b(:)); s = numel(b);
    I = eye(s); e = ones(s,1);
    R = @(z) 1 + z .* (b.' * ((I - z.*A) \ e));
end