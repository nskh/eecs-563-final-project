v = 1;
l = 5;

theta0 = 0;
y0 = [0, 0, theta0];
tin = [0,1];
odeFcn = @(t,y) bicycle_dyn(t, y, v, l);
options = odeset('OutputFcn',@(t,y,flag) deltaOutputFn(t,y,flag, v, l));
[timeout,out] = ode45(odeFcn, tin, y0, options);