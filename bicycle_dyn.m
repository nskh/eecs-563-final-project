function deriv = bicycle_dyn(t, input, v, l)
x = input(1);  % unused now
y = input(2);  % unused now
theta = input(3);
delta = controller_simple(deg2rad(45) - theta);

xdot = v * cos(theta);
ydot = v * sin(theta);
thetadot = v * tan(delta) / l;
deriv = [xdot; ydot; thetadot];