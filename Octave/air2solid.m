#{ air
%   specie
       nMoles      =    1;
       molWeight    =   28.96;%g

%    equationOfState

        rho       =      1.21;% kg/m3

 %   thermodynamics

        Cp      =        1010;
        Hf       =       2.544e+06;

 %   transport

        mu       =       1.82e-05;
        Pr       =       0.713;

#}

kappa = Cp*mu/Pr