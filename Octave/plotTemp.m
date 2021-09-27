clear; close all;
dname = "temperature";
data1 = load("tempdata.4ch");
figure(5)
plot(data1(:,2:5))
%axis([0 1800 0 1]);
h=legend('coil','stator','case','ambient');
legend (h, "location", "northwest");
set (h, "fontsize", 10);
xlabel ("t(sec)");
ylabel ("Temperature(^oC)");
title('Efficiency-Rpm')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);