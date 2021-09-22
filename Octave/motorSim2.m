function log = motorSim2(Param,X,s,v,f)
R1m = Param(1);
P0 = Param(2);
V0 = Param(3);
I0 = Param(4);
Ps = Param(5);
Is = Param(6);
Vs = Param(7);
R1a = Param(8);
Psa = Param(9);
Isa = Param(10);
Vsa = Param(11);
C = Param(12);
PM = Param(13);

R2 = X(1);
X1a = X(2);
X1m = X(3);
X2 = X(4);
Xm = X(5);
Pc = X(6);
a = sqrt(X1a/X1m);


R = 120*f/4;

w = 2*3.14*60;

ws = w*(1-s);
Z1m = R1m+j*X1m;
Z1a = R1a+j*X1a;
Zf  = 1/(1/(j*0.5*Xm) + 1/(0.5*R2/s+j*0.5*X2));
Zb  = 1/(1/(j*0.5*Xm) + 1/(0.5*R2/(2-s)+j*0.5*X2));


Z11 = Z1m+Zf+Zb;
Z12 = -j*a*(Zf-Zb);
Z21 = j*a*(Zf-Zb);
Z22 = Z1a+(Zf+Zb);
Z_m = [Z11 0
       0 Z22]
       
%input power
Ima = inv(Z_m)*v';
Im = Ima(1)
Ia = Ima(2)

Iin = Im + Ia+ (Pc+PM)/Vm;
pf = real(Iin)/abs(Iin);
Pin = norm(v)*abs(Iin)*pf;


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

log(1) = Tq;
log(2) = ws;
log(3) = norm(v);
log(4) = abs(Iin);
log(5) = Pout;
log(6) = Pin;
log(7) = n;
log(8) = pf;

  endfunction