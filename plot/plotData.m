
clear;
close all;
data = load('T copy 6');
plot(data(:,1),data(:,2));
xlabel ("t(sec)");
ylabel ("T(temperature)");