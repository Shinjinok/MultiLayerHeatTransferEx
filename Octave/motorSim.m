function log = motorSim(Param,X,data,f)
R1m = Param(1);
P0 = Param(2);
V0 = Param(3);
I0 = Param(4);
Ps = Param(5);
Is = Param(6);
Vs = Param(7)
R1a = Param(8);
Psa = Param(9);
Isa = Param(10);
Vsa = Param(11);
C = Param(12);
PM = Param(13);


R2 = X(1)
X1a = X(2)
X1m = X(3)
X2 = X(4)
Xm = X(5)
Pc = X(6)
a = sqrt(X1a/X1m);
Te=data(:,1);
Rpme=data(:,2);
Ve = data(:,3);
Ie=data(:,4);
Poute=data(:,5);
Pine=data(:,6);
effa=data(:,7);
pfe=data(:,8);

R = 120*f/4;
Xc = 1/(2*pi*f*C);
w = 2*3.14*f;
for num = 1: length(data),
s=(R-Rpme(num))/R;
%s=(R-num)/R;
ws = 2*3.14*Rpme(num)/60;
%ws = 2*3.14*num/60;
Vm = Ve(num);
%Vm = 120;
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
       
%input power
Ima = inv(Z_m)*[Vm Va]';
Im = Ima(1);
Ia = Ima(2);
Iin = Im + Ia +(Pc+PM)/Vm;
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
Pout = (Pgf-Pgb)*(1-s);
Tq = Pout/ws;
%efficiency
n = Pout/Pin;

%log

log(num,1) = Tq;
log(num,2) = Rpme(num);
%log(num,2) = num;
log(num,3) = Vm;
log(num,4) = abs(Iin);
log(num,5) = Pout;
log(num,6) = Pin;
log(num,7) = n;
log(num,8) = pf;
log(num,9) = abs(Im);
log(num,10) =abs(Ia);
log(num,11) =R2*abs(Iin)^2;
log(num,12) =Pc;
end
  endfunction