function estimated = motorEstmate3(Param)
  %param = [R1m P0 V0 I0 Ps Is Vs R1a Psa Isa Vsa C PM];
R1m = Param(1);
P0 = Param(2);
V0 = Param(3);
I0 = Param(4);
Ps = Param(5);
Is = Param(6);
Vs = Param(7);
R1a = Param(8);
P0a = Param(9);
I0a = Param(10);
V0a = Param(11);
C = Param(12);
PM = Param(13);
Psa = Param(14);
Isa = Param(15);
Vsa = Param(16);
%'Rotator resistance R2';
R2 = Ps / Is^2 - R1m;
R2a = Psa / Isa^2 -R1a;
R2 = (R2+R2a)/2
%'main winding reactance X1m = X2 rotate winding recatance';

%'State copper loss';
Psl = R1m*I0^2;
Psla = R1a*I0a^2;
Psl = (Psl+Psla)/2;
%'rotator copper loss'
Prl = 0.25*R2*I0^2;
Prla = 0.25*R2a*I0a^2;
Prl = (Prl+Prla)/2;
%'Machine loss';

%'Iron loss';
Pc = P0 - Psl - Prl -PM;
Rc = Pc/I0^2

X1m = sqrt((Vs/Is)^2 -(R1m+R2)^2)/2
X1a = sqrt((Vsa/Isa)^2 -(R1a+R2)^2)/2
X2 = X1m
Xm = 2*(sqrt((V0/I0)^2 - (R1m+Rc+R2/4)^2) - X1m - X2/2);
Xma = 2*(sqrt((V0a/I0a)^2 - (R1a+Rc+R2a/4)^2) - X1a - X2/2);
Xm = (Xm+Xma)/2
'main winding forward backward impedence';
Calval = [R2 X1a X1m X2 Xm Pc];
%X1a = X1m;

syms f1(r2, x1a, x1m, x2, xm);
syms f2(r2, x1a, x1m, x2, xm);
syms f3(r2, x1a, x1m, x2, xm);
syms f4(r2, x1a, x1m, x2, xm);
syms f5(r2, x1a, x1m, x2, xm);
syms f6(r2, x1a, x1m, x2, xm);
syms f7(r2, x1a, x1m, x2, xm);
syms f8(r2, x1a, x1m, x2, xm);
syms f9(r2, x1a, x1m, x2, xm);
z0_re = R1m + r2/4;
z0_im = x1m + xm/2 + x2/2;
z0a_re = R1a + r2/4;
z0a_im = x1a + xm/2 + x2/2;
%zs_re = R1m + r2;
%zs_im = x1m + x2;
%zsa_re = R1a + r2;
%zsa_im = x1a + x2;


zs_re = R1m +  xm^2*r2/(r2^2+(x2+xm)^2);
zs_im = x1m +  (xm*x2*(x2+xm)+ xm*r2^2)/(r2^2+(x2+xm)^2);
zsa_re = R1a + xm^2*r2/(r2^2+(x2+xm)^2);
zsa_im = x1a + (xm*x2*(x2+xm)+ xm*r2^2)/(r2^2+(x2+xm)^2);
f1 = x1m - x2;
f2 = (V0a/I0a) - sqrt(z0a_re^2 + z0a_im^2);
f3 = (V0/I0) - sqrt(z0_re^2 + z0_im^2);
f4 = (P0-PM-Pc)/I0^2 - z0_re;
f5 = (P0a-PM-Pc)/I0a^2 - z0a_re;
f6 = (Vs/Is) - sqrt(zs_re^2 + zs_im^2);
f7 = (Vsa/Isa) - sqrt(zsa_re^2 + zsa_im^2);
f8 = Ps/Is^2 - zs_re;
f9 = Psa/Isa^2 - zsa_re;

f = [f1;f2;f3;f4;f5;f6;f7;f8;f9];
ff =function_handle(f);
jf = jacobian(f);
djf = function_handle(jf);

k=0.5;
X = [R2 X1a X1m X2 Xm]';

for i=1:100,
Y = ff(X(1), X(2), X(3), X(4), X(5));
J = djf(X(1), X(2), X(3), X(4), X(5));
X = X - k*inv(J'*J)*J'*Y;
%X = X - k*inv(J)*Y;

log(i,:) = Y';
  if (norm(Y) < 1e-6)
    break;
  endif
end

R2 = X(1);
X1a = X(2);
X1m = X(3);
X2 =  X(4);
Xm =  X(5);
Pc;

figure(100)
plot(log)

h=legend('f1','f2' ,'f3','f4','f5','f6','f7','f8','f9');
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("iteration");
ylabel ("error");
errorNorm = norm(Y);
disp( 'Motor estimatied parameter')
disp('  R2  X1a   X1m  X2   Xm  Pc')
estimated = [R2 X1a X1m X2 Xm Pc]
Calval
endfunction