pkg load symbolic
clear; clc; close all;

dname = "220V150W60HzN";
data1 = load("220V_150W_60Hz.txt");
f=60;

Te0=data1(:,1)*1e-3;
Rpme=data1(:,2);
Ve = data1(:,3);
Ie=data1(:,4)*1e-3;
Poute=data1(:,5)*1e-3;
Pine=data1(:,6)*1e-3;
effa=data1(:,7)*1e-2;
pfe=data1(:,8)*1e-2;

data5 = [Te0 Rpme Ve Ie Poute Pine effa pfe];


x0 = [0 0.1 0.2 0.3 0.4];
y = [0.025 0.025 0.07 0.24 0.52];
p = polyfit(x0,y,4);
#{
for i=1:length(x0),
  ye(i) = p*[x0(i)^4 x0(i)^3 x0(i)^2 x0(i) 1]'
end
#}
dname1 = "ex_2";
dname2 = "ex_3";
dname3 = "ex_4";
ldata1 = load("experiment0917_2.txt");
ldata2 = load("experiment0917_3.txt");
ldata3 = load("experiment0917_4.txt");
f=60;



x = ldata1(:,1);
Rpme=ldata1(:,2);
Ve = ldata1(:,3);
Ie=ldata1(:,4);
Poute=ldata1(:,5);
Pine=ldata1(:,6);
effa=ldata1(:,7);
pfe=ldata1(:,8);
for i=1:length(ldata1),
  Te(i) = p*[x(i)^4 x(i)^3 x(i)^2 x(i) 1]';
  Poute(i) = Te(i)*2*pi*Rpme(i)/60;
  effa(i) = Poute(i)/Pine(i);
end
data1 = [Te' Rpme Ve Ie Poute Pine effa pfe];
x = ldata2(:,1);
Rpme=ldata2(:,2);
Ve = ldata2(:,3);
Ie=ldata2(:,4);
Poute=ldata2(:,5);
Pine=ldata2(:,6);
effa=ldata2(:,7);
pfe=ldata2(:,8);
for i=1:length(ldata2),
  Te(i) = p*[x(i)^4 x(i)^3 x(i)^2 x(i) 1]';
  Poute(i) = Te(i)*2*pi*Rpme(i)/60;
  effa(i) = Poute(i)/Pine(i);
end
data2 = [Te' Rpme Ve Ie Poute Pine effa pfe];
x = ldata3(:,1);
Rpme=ldata3(:,2);
Ve = ldata3(:,3);
Ie=ldata3(:,4);
Poute=ldata3(:,5);
Pine=ldata3(:,6);
effa=ldata3(:,7);
pfe=ldata3(:,8);
for i=1:length(ldata2),
  Te(i) = p*[x(i)^4 x(i)^3 x(i)^2 x(i) 1]';
  Poute(i) = Te(i)*2*pi*Rpme(i)/60;
  effa(i) = Poute(i)/Pine(i);
end
data3 = [Te' Rpme Ve Ie Poute Pine effa pfe];



#{
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
PM = 14;
Psa = 53.68;
Isa = 0.8162;
Vsa = 99.7;
#}

R1m = 41.67;
#{
V0 = 215.96;
I0 = 0.9309;
P0 = V0*I0*0.3893;
Vs = 216.9;
Is = 2.233;
Ps = Vs*Is*0.87;
R1a = 41.59;
V0a = 215.78;
I0a = 0.938;
P0a = V0a*I0a*0.39;
Vsa = 216.4;
Isa = 2.25;
Psa = Vsa*Isa*0.879;
C = 4*1e-6;
PM = 14;
#}
R1m = 41.67;
V0 = 215.96;
I0 = 0.9309;
P0 = V0*I0*0.3893
Vs = 210;
Is = 2.06;
Ps = Vs*Is*0.868
R1a = 41.59;
V0a = 215.78;
I0a = 0.938
P0a = V0a*I0a*0.39
Vsa = 211;
Isa = 2.074;
Psa = Vsa*Isa*0.877
C = 4*1e-6;
PM = 14;

param = [R1m P0 V0 I0 Ps Is Vs R1a P0a I0a V0a C PM Psa Isa Vsa];
X  = motorEstmate3(param);
%estimated = [R2 X1a X1m X2 Xm Pc];
%X = [51 46 47 47 500 17];
log = motorSim3(param,X,data5,f);
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

#}



figure(2)
subplot(2,3,1)
plot(log(:,2),log(:,1),data1(:,2),data1(:,1),data2(:,2),data2(:,1),data3(:,2),data3(:,1),data5(:,2),data5(:,1))
%axis([0 1800 0 1.5]);
h=legend('simulation',dname1,dname2,dname3,dname);
legend (h, "location", "northwest");
set (h, "fontsize", 10);
xlabel ("Rpm");
ylabel ("Torqe(Nm)");
title('Torque-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
#set (h, "xdir", "reverse")
%figure(2)
subplot(2,3,2)
plot(log(:,2),log(:,4),data1(:,2),data1(:,4),data2(:,2),data2(:,4),data3(:,2),data3(:,4),data5(:,2),data5(:,4))
%axis([0 1800 0 2]);
h=legend('simulation',dname1,dname2,dname3,dname);
legend (h, "location", "southwest");
set (h, "fontsize", 10);
xlabel ("Rpm");
ylabel ("Current(A)");
title('Current-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
%figure(6)
subplot(2,3,3)
plot(log(:,2),log(:,8),data1(:,2),data1(:,8),data2(:,2),data2(:,8),data3(:,2),data3(:,8),data5(:,2),data5(:,8))
grid on
h=legend('simulation',dname1,dname2,dname3,dname);
legend (h, "location", "southwest");
set (h, "fontsize", 10);
axis([0 1800 0 1.5]);
xlabel ("Rpm");
ylabel ("Power Factor");
title('Power Factor-Rpm')
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
%figure(3)
subplot(2,3,4)
plot(log(:,2),log(:,6),data1(:,2),data1(:,6),data2(:,2),data2(:,6),data3(:,2),data3(:,6),data5(:,2),data5(:,6))
%axis([0 1800 0 400]);
h=legend('simulation',dname1,dname2,dname3,dname);
legend (h, "location", "southwest");
set (h, "fontsize", 10);
xlabel ("Rpm");
ylabel ("Input Power(W)");
title('Input Power-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

%figure(4)
subplot(2,3,5)
plot(log(:,2),log(:,5),data1(:,2),data1(:,5),data2(:,2),data2(:,5),data3(:,2),data3(:,5),data5(:,2),data5(:,5))
%axis([0 1800 0 200]);
h=legend('simulation',dname1,dname2,dname3,dname);
legend (h, "location", "northwest");
set (h, "fontsize", 10);
xlabel ("Rpm");
ylabel ("Output Power(W)");
title('Output Power-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

%figure(5)
subplot(2,3,6)
plot(log(:,2),log(:,7),data1(:,2),data1(:,7),data2(:,2),data2(:,7),data3(:,2),data3(:,7),data5(:,2),data5(:,7))
%axis([0 1800 0 1]);
h=legend('simulation',dname1,dname2,dname3,dname);
legend (h, "location", "northwest");
set (h, "fontsize", 10);
xlabel ("Rpm");
ylabel ("Efficiency");
title('Efficiency-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);



figure(3)

plot(log(:,2),log(:,9:12))
%axis([0 1800 0 1.5]);

h=legend('Stator CL','Rotor CL','Iron L','Machine L');
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("Rpm");
ylabel ("Loss(Watt)");
title('Loss-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
#set (h, "xdir", "reverse")

fname = "loss.txt";
fid = fopen(fname,"w");
fprintf(fid, "RPM   SCL    RCL     PC    PM\n");
for i=1:length(log),
  fprintf(fid,"%4.1f    %4.1f   %4.1f   %4.1f   %4.1f\n",log(i,2),log(i,9:12));
end
fclose(fid);

coil_pai = 0.35;
coil_turn = 190;
one_trurn = 400;
coil_v = (coil_pai/2)^2*3.14*coil_turn*one_trurn*1e-9
coil_volume = 126020*1e-9
rotor_volume = 139555*1e-9
stator_volume = 133282*1e-9
coil_watt = log(7,9)
rotor_watt = log(7,10)
stator_watt = log(7,11)
coil_loss = log(7,9)/coil_v/8
rotor_loss = log(7,10)/rotor_volume
stator_loss = log(7,11)/stator_volume


