function xdot = noisy_linear_dyn(t, x, A, errormag, t_disturbance)
% LTI dynamics, ignore time

persistent errorCommanded
% normalize noise vector to match magnitude
if t < t_disturbance
    xdot = A * x;
    errorCommanded = 0;
elseif (t > t_disturbance) & (errorCommanded == 0)
    % random noise vector
    noisevec = rand(size(x));
    % scaling constant to have scaling * noisevec have norm errormag
    noisenorm = norm(noisevec);
    scaling = errormag / noisenorm;
    xdot = A * x + scaling * noisevec;
    fprintf("error at time %0.1f\n", t)
    errorCommanded = 1;
else
    xdot = A * x ;
end
