clear; close all;
dname = "temperature";
data1 = load("before.prn");
time = (1:length(data1));
figure(1)
subplot(1,2,1)
plot(data1(:,:))

axis([0 3000 0 70]);

k = text(3000,data1(3000,1),num2str(data1(3000,1)))
set (k, "fontsize", 20);
k = text(3000,data1(3000,2),num2str(data1(3000,2)))
set (k, "fontsize", 20);
k = text(3000,data1(3000,3),num2str(data1(3000,3)))
set (k, "fontsize", 20);
k = text(3000,data1(3000,4),num2str(data1(3000,4)))
set (k, "fontsize", 20);
h=legend('coil','stator','case','ambient');
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("t(sec)");
ylabel ("Temperature(^oC)");
title('Temperature Experiment(before)')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
data1 = load("after.prn");
subplot(1,2,2)
plot(data1(:,:))
axis([0 3000 0 70]);
k = text(3000,data1(3000,1),num2str(data1(3000,1)))
set (k, "fontsize", 20);
k = text(3000,data1(3000,2),num2str(data1(3000,2)))
set (k, "fontsize", 20);
k = text(3000,data1(3000,3),num2str(data1(3000,3)))
set (k, "fontsize", 20);
k = text(3000,data1(3000,4),num2str(data1(3000,4)))
set (k, "fontsize", 20);
h=legend('coil','stator','case','ambient');
legend (h, "location", "northwest");
set (h, "fontsize", 16);
xlabel ("t(sec)");
ylabel ("Temperature(^oC)");
title('Temperature Experiment(after)')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
RETURN
subplot(1,3,2)
plot(data1(1:1000,2:4))
%axis([0 120 30 50]);
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
data1 = load("T_coil11");
data3 = load("T_case11");
data2 = load("T_stator11");

hold on
plot(data1(:,1),data1(:,2)-273,data2(:,1),data2(:,2)-273,data3(:,1),data3(:,2)-273)
subplot(1,3,3)
data1 = load("T_coil12");
data3 = load("T_case12");
data2 = load("T_stator12");
hold on
plot(data1(:,1),data1(:,2)-273,data2(:,1),data2(:,2)-273,data3(:,1),data3(:,2)-273)
axis([0 1000 30 80]);
h=legend('coil','stator','case','ambient');
legend (h, "location", "northwest");
set (h, "fontsize", 10);
xlabel ("t(sec)");
ylabel ("Temperature(^oC)");
title('Temperature Simulation')
grid on
h=get(gcf, "currentaxes");
set(h, "fontsize", 16);
