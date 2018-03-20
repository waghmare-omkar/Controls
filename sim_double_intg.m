function sim_double_intg
% This function simulates double integrator behaviour for different controllers

% Author: Mr. Omkar Waghmare (Masters Student, Department of Aerospace,
% University of Michigan, Ann Arbor)

%% Input and initial conditions
clear all; clc;
x0 = [0;0];                                 %Initial Conditions
target = 5;                                 % Setpoint Target ( Remember to change same in other file)
tstart = 0;                                 % Start Time
tend = 10;                                  % End Time (secs)
tstep = 0.1;                                % Time Step ( Remember to change same in other file)
tspan = tstart:tstep:tend;                  % Time Interval and time for simulation

%% Call ODE solver to simulate PID controller                              ==> PID Controller
[T,X] = ode45(@double_intg_pid,tspan,x0);
Xset = ones(length(T))*target;              % Create data to plot target line

%% Plot Figures
figure(1)
plot(T,X(:,1));
hold on
grid on
plot(T,Xset,'--r');
xlabel('Time');
ylabel('Position')
legend('Position','Setpoint');
title('Double Integrator');                 % Title of figure
text(5,1,'PID Controller','Fontsize',20)    %Specify Controller Type and Position on graph (x,y) -> (5,1)
end