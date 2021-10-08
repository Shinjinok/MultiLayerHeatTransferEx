clear; close all;
dname = "temperature";
data1 = load("tempdata.4ch");
figure(5)
subplot(1,3,1)
plot(data1(:,2:5))
%axis([0 1800 0 1]);
h=legend('coil','stator','case','ambient');
legend (h, "location", "northwest");
set (h, "fontsize", 10);
xlabel ("t(sec)");
ylabel ("Temperature(^oC)");
title('Temperature Experiment')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);

subplot(1,3,2)
plot(data1(1:100,2:4))
axis([0 100 30 60]);
h=legend('coil','stator','case');
legend (h, "location", "northwest");
set (h, "fontsize", 10);
xlabel ("t(sec)");
ylabel ("Temperature(^oC)");
title('Temperature Experiment')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
dname = "coil";
data1 = load("T_coil4");
data3 = load("T_case4");
data2 = load("T_stator4");
subplot(1,3,3)
plot(data1(:,1),data1(:,2)-273,data2(:,1),data2(:,2)-273,data3(:,1),data3(:,2)-273)
%axis([0 100 30 60]);
h=legend('coil','stator','case','ambient');
legend (h, "location", "northwest");
set (h, "fontsize", 10);
xlabel ("t(sec)");
ylabel ("Temperature(^oC)");
title('Temperature Simulation')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
