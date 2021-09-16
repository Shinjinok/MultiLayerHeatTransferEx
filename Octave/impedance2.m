pkg load symbolic
clear; clc; close all;
dname = "220V150W60HzN";
data1 = load("220V_150W_60Hz_N.txt");
f=60;

Te=data1(:,1)*1e-3;
Rpme=data1(:,2);
Ve = data1(:,3);
Ie=data1(:,4)*1e-3;
Poute=data1(:,5)*1e-3;
Pine=data1(:,6)*1e-3;
effa=data1(:,7)*1e-2;
pfe=data1(:,8)*1e-2;

data = [Te Rpme Ve Ie Poute Pine effa pfe];

R1m = 41.67;
P0 = 76.81;
V0 = 215.2;
I0 = 0.9391;
Ps = 52.57;
Is = 0.808;
Vs = 100.3;
R1a = 41.59;
P0a = 77;
I0a = 0.9324;
V0a = 213.7;
C = 4*1e-6;
%Vm = 220;
PM = 14;
Psa = 53.68;
Isa = 0.8162;
Vsa = 99.7;
param = [R1m P0 V0 I0 Ps Is Vs R1a P0a I0a V0a C PM];
X  = motorEstmate2(param);
#{
R0 = X(1)
R2 = X(2)
X1a = X(3)
X1m = X(4)
X2 = X(5)
Xm = X(6)
disp( 'turn ratio')
a = sqrt(X1a/X1m)
disp( '----------------------')
#}
disp( '-param,X,s,[V0 0]-')
s = (1800-1774)/1800
log = motorSim2(param,X,s,[V0 0],f);
V0
I0
Iin = log(4)
P0
Pin = log(6)
pf = log(8)
disp( '-param,X,1,[Vs 0]-')
log = motorSim2(param,X,1,[Vs 0],f);
Vs
Is
Iin = log(4)
Ps
Pin = log(6)
pf = log(8)
disp( '--param,X,s,[0 V0a]--')
s = (1800-1776)/1800
log = motorSim2(param,X,s,[0 V0a],f);
V0a
I0a
Iin = log(4)
P0a
Pin = log(6)
pf = log(8)
disp( '-param,X,1,[0 Vsa]-')
log = motorSim2(param,X,1,[0 Vsa],f);
Vs
Is
Iin = log(4)
Ps
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
axis([0 1800 0 2]);
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
axis([0 1800 0 1.5]);
xlabel ("Rpm");
ylabel ("Power Factor");
title('Power Factor-Rpm')
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
%figure(3)
subplot(2,3,4)
plot(log(:,2),log(:,6),Rpme,Pine)
axis([0 1800 0 400]);
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
axis([0 1800 0 200]);
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
axis([0 1800 0 1]);
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

plot(log(:,2),log(:,9:11))
%axis([0 1800 0 1.5]);
legend('Im','Ia','Iin');
xlabel ("Rpm");
ylabel ("Current(I)");
title('Current-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
#set (h, "xdir", "reverse")
%figure(2)


