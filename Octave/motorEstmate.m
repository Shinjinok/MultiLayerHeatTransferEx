function estimated = motorEstmate(Param)
  %param = [R1m P0 V0 I0 Ps Is Vs R1a Psa Isa Vsa C PM];
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
PM = Param(13)
'Rotator resistance R2';
R2 = Ps / Is^2 - R1m
'main winding reactance X1m = X2 rotate winding recatance';

%X1a = sqrt((Vsa/Isa)^2 -(R1a+R2a)^2)/2


'State copper loss';
Psl = R1m*I0^2;
'rotator copper loss';
Prl = 0.25*R2*I0^2;
'Machine loss';

'Iron loss';
Pc = P0 - Psl - Prl -PM
Rc = Pc/I0^2
X1m = sqrt((Vs/Is)^2 -(R1m+R2)^2)/2
X2 = X1m 
Xm = 2*(sqrt((V0/I0)^2 - (R1m+Rc+0.25*R2)^2) - X1m -0.5*X2)
'main winding forward backward impedence';

X1a = X1m;

syms f1(r2, x1a, x1m, x2);
syms f2(r2, x1a, x1m, x2);
syms f3(r2, x1a, x1m, x2);
syms f4(r2, x1a, x1m, x2);
%syms f5(r2, x1a, x1m, x2, xm);
%syms f6(r2, x1a, x1m, x2, xm);
xm = Xm;
z0_re = R1m + r2/4;
z0_im = x1m + xm/2 + x2/2;

%zs_re = R1m + r2;
%zs_im = x1m + x2;
%zsa_re = R1a + r2;
%zsa_im = x1a + x2;


%zs_re = R1m +  xm^2*r2/(r2^2+(x2+xm)^2);
%zs_im = x1m +  (xm*x2*(x2+xm)+ xm*r2^2)/(r2^2+(x2+xm)^2);
zsa_re = R1a + xm^2*r2/(r2^2+(x2+xm)^2);
zsa_im = x1a + (xm*x2*(x2+xm)+ xm*r2^2)/(r2^2+(x2+xm)^2);
f1 = x1m - x2;
f2 = (Vsa/Isa)^2 - (zsa_re^2 + zsa_im^2);
f3 = (V0/I0)^2 - (z0_re^2 + z0_im^2);
f4 = (P0-PM-Pc)/I0^2 - z0_re;
%f5 = (Vs/Is)^2 - (zs_re^2 + zs_im^2);
%f6 = Ps/Is^2 - zs_re;

f = [f1;f2;f3;f4];
ff =function_handle(f)
jf = jacobian(f);
djf = function_handle(jf)

k=1;
X = [R2 X1a X1m X2]';

for i=1:100,
Y = ff(X(1), X(2), X(3), X(4));
J = djf(X(1), X(2), X(3), X(4));
%X = X - k*inv(J'*J)*J'*Y;
X = X - k*inv(J)*Y;

log(i,:) = Y';
  if (norm(Y) < 1e-6)
    break;
  endif
end

R2 = X(1)
X1a = X(2)
X1m = X(3)
X2 =  X(4)
Xm
Pc

figure(100)
plot(log)
legend('R2','X1a' ,'X1m','X2','Xm');
xlabel ("iteration");
ylabel ("error");
errorNorm = norm(Y);
%disp( 'Motor estimatied parameter')

estimated = [R2 X1a X1m X2 Xm Pc];
endfunction