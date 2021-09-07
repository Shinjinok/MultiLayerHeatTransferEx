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
#{

R1m = 118.9
P0 = 55.62
V0 = 212.2
I0 = 0.4974
Ps = 83.18
Is = 0.5597
Vs = 178.2
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
PM = 10.159;
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


syms f1(r1m, r2, x1a, x1m, x2, xm);
syms f2(r1m, r2, x1a, x1m, x2, xm);
syms f3(r1m, r2, x1a, x1m, x2, xm);
syms f4(r1m, r2, x1a, x1m, x2, xm);
syms f5(r1m, r2, x1a, x1m, x2, xm);
syms f6(r1m, r2, x1a, x1m, x2, xm);

z0_re = r1m + r2/4;
z0_im = x1m + xm/2 + x2/2;
%zs_re = r1m + r2*xm^2 / (r2^2+(x2+xm)^2);
%zs_im = x1m + (r2^2*xm+xm*x2^2+xm^2*x2) / (r2^2+(x2+xm)^2);
zs_re = r1m + r2;
zs_im = x1m + x2;
zsa_re = R1a + r2;
zsa_im = x1a + x2;

f1 = x1m - x2;
f2 = V0/I0 - sqrt(z0_re^2 + z0_im^2);
f3 = Vsa/Isa - sqrt(zsa_re^2 + zsa_im^2);
f4 = P0-PM-Pc-z0_re*I0^2;
f5 = Vs/Is - sqrt(zs_re^2 + zs_im^2);
f6 = Ps - zs_re*Is^2;


jf = jacobian([f1;f2;f3;f4;f5;f6]);
djf = function_handle(jf);
f = [f1;f2;f3;f4;f5;f6];
ff =function_handle(f);

k=1;
X = [R1m R2 X1a X1m X2 Xm]';

for i=1:10,
Y = ff(X(1), X(2), X(3), X(4),X(5), X(6));
J = djf(X(1), X(2), X(3), X(4),X(5), X(6));
X = X - k*inv(J)*Y;
end

disp( 'Motor parameter')
R1a 
R1m = X(1)
R2 = X(2)
X1a = X(3)
X1m = X(4)
X2 = X(5)
Xm = X(6)
PM
Pc
%%Zs2 = R1m + j*X1m + 2/(1/(j*0.5*Xm) + 1/(0.5*R2+j*0.5*X2))
%zre = R1m + R2*Xm^2 / (R2^2+(X2+Xm)^2)
%zim = X1m + (R2^2*Xm+Xm*X2^2+Xm^2*X2) / (R2^2+(X2+Xm)^2)
disp( 'turn ratio')
a = sqrt(X1a/X1m)
disp( '----------------------')
f = 60
Rpm = 1750
R = 120*f/4
s=(R-Rpm)/R
w = 2*3.14*f
C = 30*1e-6
Xc = 1/(w*C)
Vm = 120;

Z1m = R1m+j*X1m;
Zf  = R1m + j*X1m + 1/(1/(j*0.5*Xm) + 1/(0.5*R2/s+j*0.5*X2));
Zb  = R1m + j*X1m + 1/(1/(j*0.5*Xm) + 1/(0.5*R2/(2-s)+j*0.5*X2));
Zc = -j*Xc;
Z1a = R1a+j*X1a;
Z11 = Z1m+Zf+Zb;
Z12 = -j*a*(Zf-Zb);
Z21 = j*a*(Zf-Zb);
Z22 = Zc+Z1a+a^2*(Zf+Zb);
Z_m = [Z11 Z12; Z21 Z22]
disp('current')
Ima = inv(Z_m)*[Vm Vm]';
Iin = Ima(1) + Ima(2)
pf = real(Iin)/abs(Iin)
Pin = Vm*abs(Iin)*pf




