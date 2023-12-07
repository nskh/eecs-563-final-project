function status = deltaOutputFn(t,input,flag, v, l)
% OutputFcn sample
persistent deltavals
switch flag
    case 'init'
        deltavals = 0; %mass increases linearly with time
    case ''
        x = input(1);
        y = input(2);
        theta = input(3);
        delta = controller_simple(deg2rad(45) - theta);
        deltavals = [deltavals, delta];
    case 'done' % when it's done
        assignin('base','deltavals',deltavals); % get the data to the workspace.
end
status = 0;
