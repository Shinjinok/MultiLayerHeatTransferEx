pkg load symbolic
clear; clc; close all;
dname = "ex";
data1=[1780 1.154 0.993 137.445 0.329 61.262 0.446
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

Rpme=data1(:,1);
Ie=data1(:,2);
pfe=data1(:,3);
Pine=data1(:,4);
Te=data1(:,5);
Poute=data1(:,6);
effa=data1(:,7);
Ve = ones(length(data1),1)*120;
data = [Te Rpme Ve Ie Poute Pine effa pfe];
f=60;

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
PM = 10.159;
C = 30*1e-6;

param = [R1m P0 V0 I0 Ps Is Vs R1a Psa Isa Vsa C PM];
X  = motorEstmate(param);
#

%%R2 = X(1)
%X1a = X(2)
%X1m = X(2)
%X2 = X(3)
%Xm = X(4)
%disp( 'turn ratio')
%a = sqrt(X1a/X1m)


disp( '----------------------')

log = motorSim2(param,X,0,[V0 0],f);
V0
I0
Iin = log(4)
P0
Pin = log(6)
pf = log(8)

log = motorSim2(param,X,1,[0 Vs],f);
Vs
Is
Iin = log(4)
Ps
Pin = log(6)
pf = log(8)
log = motorSim2(param,X,1,[0 Vsa],f);
Vsa
Isa
Iin = log(4)
Psa
Pin = log(6)
pf = log(8)


log = motorSim(param,X,data,f);


figure(2)
subplot(2,3,1)
plot(log(:,2),log(:,1),Rpme,Te)
%axis([0 1800 0 1.5]);
h=legend('simulation',dname);
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("Rpm");
ylabel ("Torqe(Nm)");
title('Torque-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
#set (h, "xdir", "reverse")
%figure(2)
subplot(2,3,2)
plot(log(:,2),log(:,4),Rpme,Ie)
%axis([0 1800 0 2]);
h=legend('simulation',dname);
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("Rpm");
ylabel ("Current(A)");
title('Current-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
%figure(6)
subplot(2,3,3)
plot(log(:,2),log(:,8),Rpme,pfe)
grid on
h=legend('simulation',dname);
legend (h, "location", "northwest");
set (h, "fontsize", 16);
%axis([0 1800 0 1.5]);
xlabel ("Rpm");
ylabel ("Power Factor");
title('Power Factor-Rpm')
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
%figure(3)
subplot(2,3,4)
plot(log(:,2),log(:,6),Rpme,Pine)
%axis([0 1800 0 400]);
h=legend('simulation',dname);
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("Rpm");
ylabel ("Input Power(W)");
title('Input Power-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

%figure(4)
subplot(2,3,5)
plot(log(:,2),log(:,5),Rpme,Poute)
%axis([0 1800 0 200]);
h=legend('simulation',dname);
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("Rpm");
ylabel ("Output Power(W)");
title('Output Power-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

%figure(5)
subplot(2,3,6)
plot(log(:,2),log(:,7),Rpme,effa)
%axis([0 1800 0 1]);
h=legend('simulation',dname);
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("Rpm");
ylabel ("Efficiency");
title('Efficiency-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

figure(3)

plot(log(:,2),log(:,9),log(:,2),log(:,10),log(:,2),log(:,11),log(:,2),log(:,12))
%axis([0 1800 0 1.5]);
legend('main copper loss','aux copper loss','rotor loss','Iron loss');
xlabel ("Rpm");
ylabel ("Power(W)");
title('Loss-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
#set (h, "xdir", "reverse")
%figure(2)

