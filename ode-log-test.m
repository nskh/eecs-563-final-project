%% Linear system
A = [-7  1; 
     8  -10];
eig(A)
errormag = 1;
tin = [0, 10];
y0 = [0, 0];

odeFcn = @(t, y) linear_dyn(t, y, A, errormag);
[timeout,out] = ode45(odeFcn, tin, y0);

plot(timeout, out)
title(sprintf("Trajectory for error %.1f", errormag))
xlabel("time")
ylabel("state value")
legend(["y_0", "y_1"])

%% Bicycle 
v = 1;
l = 5;

theta0 = 0;
y0 = [0, 0, theta0];
tin = [0,1];
odeFcn = @(t,y) bicycle_dyn(t, y, v, l);
options = odeset('OutputFcn',@(t,y,flag) deltaOutputFn(t,y,flag, v, l));
[timeout,out] = ode45(odeFcn, tin, y0, options);
