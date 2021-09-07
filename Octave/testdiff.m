clear; clc; close all;
syms Zs2(R1m,X1m,Xm,R2,X2)
%Zs2 = abs( R1m + j*X1m + 1/(1/(j*Xm) + 1/(R2+j*X2)));
Zs2 = sqrt((R1m + R2/(R2^2+X2^2)/(((R2/(R2^2+X2^2))^2+((R2^2+X2^2+Xm*X2)/(Xm*(R2^2+X2^2)))^2)))^2)

diff(Zs2, R1m)