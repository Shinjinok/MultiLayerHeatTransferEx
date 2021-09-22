function estimated = motorEstmate4(Param,data1)
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
PM = Param(13)
Psa = Param(14);
Isa = Param(15);
Vsa = Param(16);
'Rotator resistance R2';
R2 = Ps / Is^2 - R1m;
R2a = Psa / Isa^2 -R1a;
R2 = (R2+R2a)/2;
'main winding reactance X1m = X2 rotate winding recatance';

'State copper loss';
Psl = R1m*I0^2;
Psla = R1a*I0a^2;
Psl = (Psl+Psla)/2;
'rotator copper loss'
Prl = 0.25*R2*I0^2;
Prla = 0.25*R2a*I0a^2;
Prl = (Prl+Prla)/2;
'Machine loss';

'Iron loss';
Pc = P0 - Psl - Prl -PM;
Rc = Pc/I0^2;

X1m = sqrt((Vs/Is)^2 -(R1m+R2)^2)/2;
X1a = sqrt((Vsa/Isa)^2 -(R1a+R2)^2)/2;
X2 = X1m ;
Xm = 2*(sqrt((V0/I0)^2 - (R1m+Rc+0.25*R2)^2) - X1m -0.5*X2);
Xma = 2*(sqrt((V0a/I0a)^2 - (R1a+Rc+0.25*R2a)^2) - X1a -0.5*X2);
Xm = (Xm+Xma)/2;
'main winding forward backward impedence';

%X1a = X1m;
Te0=data1(:,1)*1e-3;
Rpme=data1(:,2);
Ve = data1(:,3)
Ie=data1(:,4);
Poute=data1(:,5)*1e-3;
Pine=data1(:,6)*1e-3;
effa=data1(:,7)*1e-2;
pfe=data1(:,8);
%for i=1 : length(data)
  Vo = Ve
  Iin = Ie
%  Im = Ie(1)/2;
%  Ia = Ie(1)/2;
  pf = pfe
syms f1(ia,im,z1,z2,z3)
syms f2(ia,im,z1,z2,z3)
syms f3(ia,im,z1,z2,z3)
syms f4(ia,im,z1,z2,z3)
syms f5(ia,im,z1,z2,z3)
syms f6(ia,im,z1,z2,z3)
syms f7(ia,im,z1,z2,z3)
syms f8(ia,im,z1,z2,z3)
syms f9(ia,im,z1,z2,z3)

f1 = Vo(1) - (z1 * im + z2 * ia);
f2 = Vo(1) - (-z2 * im +z3 * ia);
f3 = pf(1)*Iin(1) - (im + ia); 

f = [f1;f2;f3]
ff =function_handle(f)
jf = jacobian(f);
djf = function_handle(jf)
X = [10 10 10 1 1]';
k=0.01;
for i=1:1000,
Y = ff(X(1), X(2), X(3), X(4), X(5));
J = djf(X(1), X(2), X(3), X(4), X(5));
%X = X - k*inv(J'*J)*J'*Y;
X = X - k*J'*inv(J*J')*Y;
%X = X - k*inv(J)*Y;

log(i,:) = Y';
  if (norm(Y) < 1e-6)
    break;
  endif
end
X
figure(100)
plot(log)

h=legend('f1','f2' ,'f3','f4','f5','f6','f7','f8','f9');
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("iteration");
ylabel ("error");
errorNorm = norm(Y);
%disp( 'Motor estimatied parameter')

return

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
ff =function_handle(f)
jf = jacobian(f);
djf = function_handle(jf)

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

R2 = X(1)
X1a = X(2)
X1m = X(3)
X2 =  X(4)
Xm =  X(5)
Pc

figure(100)
plot(log)

h=legend('f1','f2' ,'f3','f4','f5','f6','f7','f8','f9');
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("iteration");
ylabel ("error");
errorNorm = norm(Y);
%disp( 'Motor estimatied parameter')

estimated = [R2 X1a X1m X2 Xm Pc];
endfunction