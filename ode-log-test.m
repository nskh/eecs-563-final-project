%% Linear system
A = [-7  1; 
     8  -10]; % 10.9
P = eye(2);

% A = [-1 1; -1 -1]; % 11.15
% P = [1, 1/16; 1/16, 1];


eig(A)
errormag = 1000;
t_disturbance = 2;
tin = [0:0.1:10];
y0 = [10, 10];

rng(123)
odeFcn = @(t, y) noisy_linear_dyn(t, y, A, errormag, t_disturbance);
[timeout,out] = ode45(odeFcn, tin, y0);
convergence_tolerance = 0.01;
test_convergence(timeout, out(:, 1), convergence_tolerance)
test_convergence(timeout, out(:, 2), convergence_tolerance)

figure
plot(timeout, out)
title(sprintf("Trajectory for error %.1f", errormag))
xlabel("time")
ylabel("state value")

hold on

odeFcn = @(t, y) A * y;
[timeout_noiseless,out_noiseless] = ode45(odeFcn, tin, y0);

test_convergence(timeout_noiseless, out_noiseless(:, 1), convergence_tolerance)
test_convergence(timeout_noiseless, out_noiseless(:, 2), convergence_tolerance)

% figure
plot(timeout_noiseless, out_noiseless)
% title("Noiseless Trajectory")
% xlabel("time")
% ylabel("state value")
legend(["noisy y_0", "noisy y_1", "noiseless y_0", "noiseless y_1"])

figure
title("Output errors")
xlabel("Time")
ylabel("Error value")
plot(out_noiseless - out)

%% Discretized
tmax = 10;
dt = 0.1;
rng(123)
y = discrete_with_disturbance(A, tmax, dt, y0', errormag, t_disturbance);

test_convergence(0:dt:tmax, y(:, 1), convergence_tolerance)
test_convergence(0:dt:tmax, y(:, 2), convergence_tolerance)

plot(0:dt:tmax, y)
title("Discretized system")

%% Bicycle 
v = 1;
l = 5;

theta0 = 0;
y0 = [0, 0, theta0];
tin = [0,1];
odeFcn = @(t,y) bicycle_dyn(t, y, v, l);
options = odeset('OutputFcn',@(t,y,flag) deltaOutputFn(t,y,flag, v, l));
[timeout_noiseless,out_noiseless] = ode45(odeFcn, tin, y0, options);
