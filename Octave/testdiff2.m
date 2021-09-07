
clear; clc; close all;
#{
syms R1m R2 X1m Xm X2
f = real(R1m + j*X1m + 1/(1/(j*Xm) + 1/(R2+j*X2)));
fd = diff(f,Xm)
dfh = function_handle(fd)
#}

syms f(x, y)
syms g(x,y)
a = x^2;
b = y^3;
f = a + b;
g = 2*x + 3*y^2;
ff = jacobian([f;g])
fd = function_handle(ff)
fd(5,2)
