pkg load symbolic
clear; clc; close all;
dname = "ex";
data=[1780 1.154 0.993 137.445 0.329 61.262 0.446
1776 1.240 0.994 142.827 0.394 73.335 0.496
1770 1.366 0.995 163.125 0.489 90.632 0.556
1763 1.51 0.996 180.538 0.594 109.599 0.607
1757 1.63 0.997 195.074 0.679 124.842 0.640
1750 1.766 0.998 211.564 0.772 141.477 0.669
1741 1.935 0.999 232.004 0.884 161.110 0.694
1731 2.114 1.0 253.694 0.997 180.719 0.712
1725 2.218 1.0 266.189 1.060 191.427 0.719
1712 2.434 1.0 291.927 1.183 212.073 0.726
1696 2.681 0.998 321.143 1.312 233.080 0.726
1690 2.769 0.997 331.417 1.355 239.816 0.724
1668 3.071 0.993 366.059 1.487 259.798 0.710
1650 3.294 0.989 391.076 1.570 271.344 0.694
1632 3.499 0.984 413.364 1.634 279.266 0.676]

Rpme=data(:,1);
Ie=data(:,2);
pfe=data(:,3);
Pine=data(:,4);
Te=data(:,5);
Poute=data(:,6);
effa=data(:,7);


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
#{
R2 = 4.533
Xm = 82.465
X1m = 6.737
X1a = 5.366
X2 = 6.737
#}
%%Zs2 = R1m + j*X1m + 2/(1/(j*0.5*Xm) + 1/(0.5*R2+j*0.5*X2))
%zre = R1m + R2*Xm^2 / (R2^2+(X2+Xm)^2)
%zim = X1m + (R2^2*Xm+Xm*X2^2+Xm^2*X2) / (R2^2+(X2+Xm)^2)
disp( 'turn ratio')
a = sqrt(X1a/X1m)
disp( '----------------------')
f = 60;
R = 120*f/4;
w = 2*3.14*f;
C = 30*1e-6
Xc = 1/(w*C)
Vm = 120;


for num = 500: R,
s=(R-num)/R;
ws = 2*3.14*num/60;
Va = Vm;
Z1m = R1m+j*X1m;
Z1a = R1a+j*X1a;
Zf  = 1/(1/(j*0.5*Xm) + 1/(0.5*R2/s+j*0.5*X2));
Zb  = 1/(1/(j*0.5*Xm) + 1/(0.5*R2/(2-s)+j*0.5*X2));
Zc = -j*Xc;

Z11 = Z1m+Zf+Zb;
Z12 = -j*a*(Zf-Zb);
Z21 = j*a*(Zf-Zb);
Z22 = Zc+Z1a+a^2*(Zf+Zb);
Z_m = [Z11 Z12
       Z21 Z22];
%disp('current');
Ima = inv(Z_m)*[Vm Va]';
Iin = Ima(1) + Ima(2) +(Pc+PM)/Vm;
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
T = 1/ws*(Pgf-Pgb);
%efficiency
Pout = T*ws*(1-s);
n = Pout/Pin;

log(num,8) = pf;
log(num,7) = Pout;
log(num,6) = Pin;
log(num,5) = abs(Iin);
log(num,4) = pf;
log(num,3) = n;
log(num,2) = T;
log(num,1) = num;
end


figure(1)
subplot(2,3,1)
plot(log(:,1),log(:,2))
hold on
plot(Rpme,Te)
%axis([0 1800 0 1.5]);
legend('simulation',dname);
xlabel ("Rpm");
ylabel ("Torqe(Nm)");
title('Torque-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
#set (h, "xdir", "reverse")
%figure(2)
subplot(2,3,2)
plot(log(:,1),log(:,5),Rpme,Ie)
%axis([0 1800 0 2]);
legend('simulation',dname);
xlabel ("Rpm");
ylabel ("Current(A)");
title('Current-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
%figure(6)
subplot(2,3,3)
plot(log(:,1),log(:,8),Rpme,pfe)
grid on
legend('simulation',dname);
%axis([0 1800 0 1.5]);
xlabel ("Rpm");
ylabel ("Power Factor");
title('Power Factor-Rpm')
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
%figure(3)
subplot(2,3,4)
plot(log(:,1),log(:,6),Rpme,Pine)
%axis([0 1800 0 400]);
legend('simulation',dname);
xlabel ("Rpm");
ylabel ("Input Power(W)");
title('Input Power-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

%figure(4)
subplot(2,3,5)
plot(log(:,1),log(:,7),Rpme,Poute)
%axis([0 1800 0 200]);
legend('simulation',dname);
xlabel ("Rpm");
ylabel ("Output Power(W)");
title('Output Power-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

%figure(5)
subplot(2,3,6)
plot(log(:,1),log(:,3),Rpme,effa)
%axis([0 1800 0 1]);
legend('simulation',dname);
xlabel ("Rpm");
ylabel ("Efficiency");
title('Efficiency-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);



