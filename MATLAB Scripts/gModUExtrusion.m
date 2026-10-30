function [Path_in, Path_out, sub,distance] = gModUExtrusion(factor)


%load('PID_correction_U_p5-i10-d0 Gcode Ready.mat');
load('iLQR_correction_U_4 Gcode Ready.mat');

sub = 10;
distance = 5;

Path_D = [0 D_left2];
Path_D2 = [0 D_right2];

QN_left2 =[QN_left2(1), QN_left2];
QN_left2(QN_left2<0.011) = 0;
QN_left2(end-5:end) =0;
QN_right2 =[QN_right2, QN_right2(end)];
QN_right2(QN_right2<0.011) = 0;

E1= cumtrapz(Path_D,QN_left2).*factor;
E2 = cumtrapz(Path_D2,QN_right2).*factor;

%{
Path_D = [0,8];
Path_D2 = [0,1,2,3,4,8];
sub = 5;
distance = 8;

E1 = [0, 0].*factor;
E2 = [0    0    0    1.8545    1.9182    2.0000].*factor;
%}
Path_in = @(Xn) interp1(Path_D,E1,Xn,'linear');
Path_out = @(Xn) interp1(Path_D2,E2,Xn,'linear');

end