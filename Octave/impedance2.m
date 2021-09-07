pkg load symbolic
clear; clc; close all;

R1m = 6.8;
P0 = 67.2;
V0 = 120;
I0 = 2.31;
Ps = 102;
Is = 3;
Vs = 51.3;
R1a = 6.3;
Psa = 96.4;
Isa = 3;
Vsa = 46.7;
C = 30*1e-6
PM = 10.159;
Vm = 120;

#{
R1m = 118.9
P0 = 55.62
V0 = 212.2
I0 = 0.4974
Ps = 83.18
Is = 0.5597
Vs = 178.2
R1a = 149.2;
Psa = 104.6;
Isa = 0.5612;
Vsa = 212.3;
C = 2.5*1e-6;
Vm = 214;
PM = 10;

R1m = 41.67;
P0 = 76.81;
V0 = 215.2;
I0 = 0.9391;
Ps = 52.57;
Is = 0.808;
Vs = 100.3
R1a = 41.59;
Psa = 53.68;
Isa = 0.8162;
Vsa = 99.7;
C = 4*1e-6;
Vm = 220;
PM = 14;
#}
'Rotator resistance R2';
R2 = Ps / Is^2 - R1m;
'main winding reactance X1m = X2 rotate winding recatance';
X1m = sqrt((Vs/Is)^2 -(R1m+R2)^2)/2;
X2 = X1m ;
'State copper loss';
Psl = R1m*I0^2;
'rotator copper loss';
Prl = 0.25*R2*I0^2;
'Machine loss';

'Iron loss';
Pc = P0 - Psl - Prl -PM;

'main winding forward backward impedence';
%Zf = 1/(1/0.5j*Xm + 1/(0.5*R2/s + 0.5j*X2))
%Zb = 1/(1/0.5j*Xm + 1/(0.5*R2/(2-s) + 0.5j*X2))


%Rc = 0;
%R2 = 1
%X1m = 1
Xm = X1m;
%X2 = 1;
X1a = X1m;

syms f1(r2, x1a, x1m, x2, xm);
syms f2(r2, x1a, x1m, x2, xm);
syms f3(r2, x1a, x1m, x2, xm);
syms f4(r2, x1a, x1m, x2, xm);
syms f5(r2, x1a, x1m, x2, xm);
syms f6(r2, x1a, x1m, x2, xm);

z0_re = R1m + r2/4;
z0_im = x1m + xm/2 + x2/2;
zs_re = R1m + r2*xm^2 / (r2^2+(x2+xm)^2);
zs_im = x1m + (r2^2*xm+xm*x2^2+xm^2*x2) / (r2^2+(x2+xm)^2);
%zs_re = R1m + r2;
%zs_im = x1m + x2;
zsa_re = R1a + r2*xm^2 / (r2^2+(x2+xm)^2);
zsa_im = x1a + (r2^2*xm+xm*x2^2+xm^2*x2) / (r2^2+(x2+xm)^2);
%zsa_re = R1a + r2;
%zsa_im = x1a + x2;

f1 = x1m - x2;
f2 = V0/I0 - sqrt(z0_re^2 + z0_im^2);
f3 = Vsa/Isa - sqrt(zsa_re^2 + zsa_im^2);
f4 = P0-PM-Pc-z0_re*I0^2;
f5 = Vs/Is - sqrt(zs_re^2 + zs_im^2);
f6 = Ps - zs_re*Is^2;

f = [f1;f2;f3;f4;f5;f6];
ff =function_handle(f);
jf = jacobian(f);
djf = function_handle(jf);

k=1;
X = [R2 X1a X1m X2 Xm]';

for i=1:100,
Y = ff(X(1), X(2), X(3), X(4),X(5));
J = djf(X(1), X(2), X(3), X(4),X(5));
X = X - k*inv(J'*J)*J'*Y;
end

disp( 'Motor parameter')
disp( 'measured')
R1a 
R1m
PM
Pc
disp( 'estimatied')
R2 = X(1)
X1a = X(2)
X1m = X(3)
X2 = X(4)
Xm = X(5)

%%Zs2 = R1m + j*X1m + 2/(1/(j*0.5*Xm) + 1/(0.5*R2+j*0.5*X2))
%zre = R1m + R2*Xm^2 / (R2^2+(X2+Xm)^2)
%zim = X1m + (R2^2*Xm+Xm*X2^2+Xm^2*X2) / (R2^2+(X2+Xm)^2)
disp( 'turn ratio')
a = sqrt(X1a/X1m)
disp( '----------------------')
f = 60;
Rpm = 1774;
R = 120*f/4;
Xc = 1/(2*pi*f*C);
Va = Vm;
for Rpm = 1: R,
s=(R-Rpm)/R;

Z1m = R1m+j*X1m;
Z1a = R1a+j*X1a;
Zf  = R1m + j*X1m + 1/(1/(j*0.5*Xm) + 1/(0.5*R2/s+j*0.5*X2));
Zb  = R1m + j*X1m + 1/(1/(j*0.5*Xm) + 1/(0.5*R2/(2-s)+j*0.5*X2));
Zc = -j*Xc;

Z11 = Z1m+Zf+Zb;
Z12 = -j*a*(Zf-Zb);
Z21 = j*a*(Zf-Zb);
Z22 = Zc+Z1a+a^2*(Zf+Zb);
%Z222 = Z1a+a^2*(Zf+Zb)
Z_m = [Z11 Z12; Z21 Z22];
%disp('current');
Ima = inv(Z_m)*[Vm Va]'
Iin = Ima(1) + Ima(2)+(Pc+PM)/Vm;
pf = real(Iin)/abs(Iin);
Pin = Vm*abs(Iin)*pf;

%torque
Im = Ima(1);
Ia = Ima(2);
Efm = Zf*Im;
Ebm = Zb*Im;
Efa = a^2*Zf*Ia;
Eba = a^2*Zb*Ia;
Ef = Efm - j*Efa/a;
Eb = Ebm + j*Eba/a;
Pgf = real(Ef*conj(Im)+j*a*Ef*conj(Ia));
Pgb = real(Eb*conj(Im)-j*a*Eb*conj(Ia));
T = 1/(2*pi*f)*(Pgf-Pgb);
%efficiency
Pout = T*2*pi*f*(1-s);
n = Pout/Pin;

'State copper loss';
Pmcl = R1m*real(Im)^2;
Pacl = R1a*real(Ia)^2;
'rotator copper loss';
Prl = 0.25*R2*real(Iin)^2;
'Iron loss';
Pc = P0 - Pmcl-Pacl - Prl -PM;

logl(Rpm,1) = Rpm;
logl(Rpm,2) = Pmcl;
logl(Rpm,3) = Pacl;
logl(Rpm,4) = Prl;
logl(Rpm,5) = Pc;
log(Rpm,7) = Pout;
log(Rpm,6) = Pin;
log(Rpm,5) = abs(Iin);
log(Rpm,4) = pf;
log(Rpm,3) = n;
log(Rpm,2) = T;
log(Rpm,1) = Rpm;
end
Z_m

Te=[54.6875
86.71875
285.1563
473.4375
596.875
690.625
769.5313
825.7813
868.75
903.9063
921.875
946.0938
890.625
814.0625
731.25
694.5313
602.3438
516.4063
421.0938
365.625
329.6875
332.8125
299.2188
275.7813
389.8438
367.1875
]*1e-3;
Rpme=[1778.75
1773.75
1743.75
1710
1679.375
1651.25
1620
1591.25
1561.25
1530.625
1501.25
1401.25
1297.5
1200.625
1101.875
1003.75
904.375
804.375
702.5
597.5
499.375
404.375
303.75
204.375
103.125
0];
Ie=[466
475
566
696
806
909
1012
1101
1188
1268
1338
1547
1710
1831
1929
2000
2058
2101
2129
2144
2154
2162
2171
2170
2165
2168]*1e-3;
Pine=[10184.73
16104.68
52061.16
84762.83
104948.9
119399.3
130523.3
137578.4
142008.4
144856.8
144901.1
138802.2
120989.9
102332.1
84361.62
72990.11
57034.76
43490.73
30972.18
22872.86
17237.57
14090.64
9515.941
5901.185
4209.216
0]*1e-3;

figure(1)
title('T-Rpm')
plot(log(:,1),log(:,2))
hold on
%plot(Rpme,Te)
legend('Torque');
xlabel ("Rpm");
ylabel ("Torqe(Nm)");
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
#set (h, "xdir", "reverse")
figure(2)
title('I-Rpm')
plot(log(:,1),log(:,5))
hold on
%plot(Rpme,Ie)
legend('Current');
xlabel ("Rpm");
ylabel ("Current(A)");
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
figure(3)
title('Pin-Rpm')
plot(log(:,1),log(:,6))
hold on
%plot(Rpme,Pine)

xlabel ("Rpm");
ylabel ("Power(W)");
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
figure(4)
title('Pout-Rpm')
plot(log(:,1),log(:,7))
hold on
%plot(Rpme,Pine)

xlabel ("Rpm");
ylabel ("Power(W)");
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

