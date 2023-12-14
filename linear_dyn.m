function xdot = linear_dyn(~, x, A, errormag)
% LTI dynamics, ignore time

% random noise vector
noisevec = rand(size(x));
% scaling constant to have scaling * noisevec have norm errormag
noisenorm = norm(noisevec);
scaling = errormag / noisenorm;
% normalize noise vector to match magnitude
xdot = A * x + scaling * noisevec;