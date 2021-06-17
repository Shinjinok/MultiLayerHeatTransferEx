
clear;
close all;
data = load('T copy 3');
plot(data(:,1),data(:,2)-273);
xlabel ("t(sec)");
ylabel ("T(temperature)");