%motor impedance

%main winding 
R1m = 41.67;
R1a = 41.59;
%60Hz impedance
Zm = 72.418 + j*46.797;
'Zm pf'
pf = acos(real(Zm)/abs(Zm))*180/pi
Za = 72.373 + j*45.049;
pf = acos(real(Za)/abs(Za))*180/pi
C = 4*1e-6;%F
Zc = 1/(j*2*3.14*60*C)
Zc = -j*652.61
'Zm+Za;'
Zm+Za;
Zall = 143.65 + j*91.435
'1/(1/Zm + 1/(Zc+Za))'
1/(1/Zm + 1/(Zc+Za))
Zwc = 81.966 + j*38.823
pf = acos(real(Zwc)/abs(Zwc))*180/pi
'1/(1/Zm+1/Za)'
1/(1/Zm+1/Za)
Zp = 36.045 + j*22.880
pf = acos(real(Zp)/abs(Zp))*180/pi


V =216.3
I = 0.5
Z = V/I
abs(Zall)
