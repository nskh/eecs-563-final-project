function t_eps = test_convergence(t, y, epsilon)
t_eps = t(end);
for i = 1:length(t)
    if all(abs(y(i:end, :) - 0) < epsilon)
        t_eps = t(i);
        break
    end
end