
clear;
close all;
data = load('T copy 7');

len = length(data)
j=0;
for i=1:len,
  j=j+1;
  if(j*100 > len) break;
  endif
  data2(j,:) = data(j*100,:);
end

plot(data2(:,1),data2(:,2));
xlabel ("t(sec)");
ylabel ("T(temperature)");