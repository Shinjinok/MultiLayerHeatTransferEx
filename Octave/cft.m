clear; clc; close all;

x = [0 0.1 0.2 0.3 0.47];
y = [0 0.01 0.06 0.20 0.5];
p = polyfit(x,y,4)
for i=1:length(x),
  ye(i) = p*[x(i)^4 x(i)^3 x(i)^2 x(i) 1]'
end

figure(1)
plot(x,y,x,ye)