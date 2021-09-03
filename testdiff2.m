
clear; clc; close all;
syms f(x,y)
f(x,y) = 2*x^2+y
d(x,y) = diff(f, x)
d(1,1)