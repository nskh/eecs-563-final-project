%% Linear system
A = [-7  1; 
     8  -10]; % 10.9

% A = [-1 1; -1 -1]; % 11.15

eig(A)
errormag = 1000;
t_disturbance = 2;
tin = [0:0.1:10];
y0 = [10, 10];

odeFcn = @(t, y) noisy_linear_dyn(t, y, A, errormag, t_disturbance);
[timeout,out] = ode45(odeFcn, tin, y0);

figure
plot(timeout, out)
title(sprintf("Trajectory for error %.1f", errormag))
xlabel("time")
ylabel("state value")

hold on

odeFcn = @(t, y) A * y;
[timeout_noiseless,out_noiseless] = ode45(odeFcn, tin, y0);

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

%% Bicycle 
v = 1;
l = 5;

theta0 = 0;
y0 = [0, 0, theta0];
tin = [0,1];
odeFcn = @(t,y) bicycle_dyn(t, y, v, l);
options = odeset('OutputFcn',@(t,y,flag) deltaOutputFn(t,y,flag, v, l));
[timeout_noiseless,out_noiseless] = ode45(odeFcn, tin, y0, options);
