pkg load symbolic
clear; clc; close all;
dname = "220V150W60HzN";
data = load("220V_150W_60Hz_N.txt");

%data = load('220V_150W_60Hz.txt');
Te=data(:,1)*1e-3;
Rpme=data(:,2);
Ve = data(:,3);
Ie=data(:,4)*1e-3;
Poute=data(:,5)*1e-3;
Pine=data(:,6)*1e-3;
effa=data(:,7)*1e-2;
pfe=data(:,8)*1e-2;
#{
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
#}
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

for i=1:10,
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
R2 = X(1)

#{
X1a = 5.366
X1m =6.737
X2 = 6.737
Xm = 82.465
#}
%%Zs2 = R1m + j*X1m + 2/(1/(j*0.5*Xm) + 1/(0.5*R2+j*0.5*X2))
%zre = R1m + R2*Xm^2 / (R2^2+(X2+Xm)^2)
%zim = X1m + (R2^2*Xm+Xm*X2^2+Xm^2*X2) / (R2^2+(X2+Xm)^2)
disp( 'turn ratio')
a = sqrt(X1a/X1m);
disp( '----------------------')
f = 60;
%Rpm = 1774;
R = 120*f/4;
Xc = 1/(2*pi*f*C);

for num = 1: 11,
s=(R-Rpme(num))/R;
ws = 2*3.14*Rpme(num)/60;
Vm = Ve(num);
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
Z_m = [Z11 0
       0 Z22];
       
%input power
Ima = inv(Z_m)*[Vm Va]';
Im = Ima(1);
Ia = Ima(2);
Iin = Im + Ia + (Pc+PM)/Vm;
pf = real(Iin)/abs(Iin);
Pin = Vm*abs(Iin)*pf;

%torque
Efm = Zf*Im;
Ebm = Zb*Im;
Efa = a^2*Zf*Ia;
Eba = a^2*Zb*Ia;
Ef = Efm - j*Efa/a;
Eb = Ebm + j*Eba/a;
Pgf = real(Ef*conj(Im)+j*a*Ef*conj(Ia));
Pgb = real(Eb*conj(Im)-j*a*Eb*conj(Ia));
Tq = 1/ws*(Pgf-Pgb);
%efficiency
Pout = Tq*ws*(1-s);
n = Pout/Pin;

%log
log(num,9) = (1-s)*(Pgf-Pgb);
log(num,8) = pf;
log(num,7) = Pout;
log(num,6) = Pin;
log(num,5) = abs(Iin);
log(num,4) = pf;
log(num,3) = n;
log(num,2) = Tq;
log(num,1) = Rpme(num);
end



figure(1)
subplot(2,3,1)
plot(log(:,1),log(:,2),Rpme,Te)
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
axis([0 1800 0 2]);
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
axis([0 1800 0 1.5]);
xlabel ("Rpm");
ylabel ("Power Factor");
title('Power Factor-Rpm')
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
%figure(3)
subplot(2,3,4)
plot(log(:,1),log(:,6),Rpme,Pine)
axis([0 1800 0 400]);
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
axis([0 1800 0 200]);
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
axis([0 1800 0 1]);
legend('simulation',dname);
xlabel ("Rpm");
ylabel ("Efficiency");
title('Efficiency-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);


#{
for i=1:length(pfe),
  ppi(i)=pfe(i)*Ve(i)*Ie(i);
end
figure(7)
plot(Rpme,ppi,Rpme,Pine)
#}

