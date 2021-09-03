clear all
close all


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


Rc = 0;
%R2 = 1
%X1m = 1
Xm = 1;
%X2 = 1;
k = 1;
X = [R1m R2 X1m Xm X2]';

for i=1:5,

R1m = X(1);
R2 = X(2);
X1m = X(3);
Xm = X(4);
X2 = X(5);



R0 = R1m + 0.25*R2;
X0 = X1m + 0.5 * Xm + 0.5* X2;
Z0 = R0 + j*X0;

Rs = R1m + R2;
Xs = X1m + X2 ;
Zs = Rs + j*Xs;

Zs2 = R1m + j*X1m + 1/(1/(j*Xm) + 1/(R2+j*X2));



J = [0 0 1 0 -1
    -R0/abs(Z0) -0.25*R0/abs(Z0) -X0/abs(Z0) -0.5*X0/abs(Z0) -0.5*X0/abs(Z0)
    -I0^2 -0.25*I0^2  0 0 0
    -Rs/abs(Zs) -Rs/abs(Zs) -Xs/abs(Zs) 0 -Xs/abs(Zs)
    -Is^2 -Is^2 0 0 0];

Psl = R1m*I0^2;
Prl = 0.25*R2*I0^2;
Pc = P0 - Psl - Prl -PM;


Y = [ X1m-X2
      V0/I0-abs(Z0)
      P0-PM-Pc-real(Z0)*I0^2
      Vs/Is-abs(Zs)
      Ps-real(Zs)*Is^2];

X = X - k*inv(J)*Y;
elog(i,:) = Y;
end


X1a = X1m;
for i=1:10,
Rsa = R1a + R2;
Xsa = X1a + X2 ;
Zsa= Rsa + j*Xsa;

Ya = Vsa/Isa - abs(Zsa);
Ja =  - Xsa/abs(Zsa);
X1a = X1a - inv(Ja)*Ya;

end;
R1m
R1a
R2
Xm
X1m
X1a
X2
PM
Pc
Psl
Prl
a = sqrt(X1a/X1m)

f = 60
Rpm = 1780
R = 120*f/4
s=(R-Rpm)/R
w = 2*3.14*f
C = 30*1e-6
Xc = 1/(w*C)

Z1m = R1m+j*X1m;
Zf  = R1m + j*X1m + 1/(1/(j*0.5*Xm) + 1/(0.5*R2/s+j*0.5*X2));
Zb  = R1m + j*X1m + 1/(1/(j*0.5*Xm) + 1/(0.5*R2/(1-s)+j*0.5*X2));
Zc = j*Xc;
Z1a = R1a+j*X1a;
Z11 = Z1m+Zf+Zb;
Z12 = -j*a*(Zf-Zb);
Z21 = j*a*(Zf-Zb);
Z22 = Zc+Z1a+a^2*(Zf+Zb);
Z_m = [Z11 Z12; Z21 Z22]
Iin = inv(Z_m)*[120 120]'
Iin2 = abs(Iin(1)+Iin(2))