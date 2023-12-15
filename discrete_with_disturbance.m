function y = discrete_with_disturbance(A, tmax, dt, y0, errormag, t_disturbance)
y = y0;
new_y = y0;
A_disc = A * dt;
for t = dt:dt:tmax
    new_y = A_disc * new_y;
    % add disturbance
    if t == t_disturbance
        % random noise vector
        noisevec = rand(size(y0));
        % scaling constant to have scaling * noisevec have norm errormag
        noisenorm = norm(noisevec);
        scaling = errormag / noisenorm;
        new_y = new_y + scaling * noisevec * dt;
        fprintf("error at time %0.1f\n", t)
    end
    y = [y, new_y];
    disp(length(y))
end

end