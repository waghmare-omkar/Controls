%% Complimentary file for Simulink Model of Lateral Dynamics
% Error from centre-line based dynamic model
%  Note to mention Vx in your model is controlled from here
%% Vehicle Parameters   
m = 1573; %Kg
Izz = 2873;
l_f = 1.58;
l_r = 1.58;
C_alpha_f = 80000;
C_alpha_r = 80000;

%% Vehicle Longitudnal velocity
Vx = 10;