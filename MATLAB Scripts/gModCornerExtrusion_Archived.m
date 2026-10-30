function [Path_in, Path_out, sub,distance] = gModCornerExtrusion(factor)

load('PID_correction_corner_p5-i10-d0 Gcode Ready.mat')
Path_D = [0,5];
Path_D2 = [0,1,2,3,4,5];
sub = 5;
distance = 5;

E1 = [0, 0].*factor;
E2 = [0    1.4545    1.6545    1.8545    1.9182    2.0000].*factor;
Path_in = @(Xn) interp1(Path_D,E1,Xn,'linear');
Path_out = @(Xn) interp1(Path_D2,E2,Xn,'linear');

end