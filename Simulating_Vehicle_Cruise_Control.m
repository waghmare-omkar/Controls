%% Simulating Vehicle Cruise Control 
% Cruise Control State Space form 
% Find Model Here : http://ctms.engin.umich.edu/CTMS/index.php?example=CruiseControl&section=SystemModeling

%% Printing Code Execution Date & time
close; clc; clear all
disp('================= Simulating Vehicle Cruise Control =================');
Dtimes = datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z');
disp(['Code Executed on: ' char(Dtimes)] );

%% Initialiaze 
global m b initial_force i
global n_switch std_dev_velocity %Control on/off of noise by 1/0.
rng('default'); %Generates repeatable values for randn function  
%% Set/Control parameters  % ==> Change this to play with code and Cruise Equations
m = 1000 ; % Mass of vehicle in Kg
b = 25; %Damping coefficient N.s/m
Simulation_time = 500; % Simulation time in seconds
Simulation_step = 0.01 ; % Simulation Step in seconds
initial_velocity = 0 ; % Initial Velocity in m/s
initial_force = 10 ; % Initial Velocity in N
n_switch = 1; %Control Noise addition by setting On =1/Off =0
std_dev_velocity = 0.5; %Standard Deviation Parameter Control

disp('-----------------Parameters-----------------');
fprintf('Mass of Car : %d Kg\n', m);
fprintf('Damping Coefficient : %d N.s/m \n', b);
fprintf('Initial Velocity : %d m/s \n', initial_velocity);
fprintf('Initial Force : %d N \n', initial_force);
disp('--------------------------------------------');
%% Create Data
tspan = 0 : Simulation_step : Simulation_time; % Passing time to ODE 
X0 = initial_velocity; %[initial_velocity , initial_force]; % Initial Condition for ODE integration 
u = 1000 ;% Setting Control Input for Dynamics
[Tp,Xp]= ode45(@cruise_dyn,tspan,X0,[],u) ; % Propogate Trajectory for specified simulation time in future
X_noise = Xp(:,1) + n_switch*randn(size(Xp(:,1)))*std_dev_velocity;

%% Plot Figures
figure(1)
plot(Tp,X_noise,'DisplayName','Noise added Velocity'); % Plot Noise added velovity
hold on
plot(Tp,Xp(:,1),'DisplayName','Original Velocity','LineWidth',2); % Plot Original Velocity
xlabel('Time(s)')
ylabel('Velocity of Car')
legend

% figure(2)
% plot(Tp,Xp(:,2),'DisplayName','Control Force','LineWidth',2); % Plot Original Velocity
% xlabel('Time(s)')
% ylabel('Control Force (N)')
% legend

%% 
disp('Plots Created ...');
disp('================= Execution Completed Successfully =================');

%% Supporting Functions

function [xdot] = cruise_dyn(t,x0,u0)
global m b initial_force i
if isempty(i)
    u0 = initial_force;
    i = 1;
end
v = x0 ;
u = u0 ;
xdot = (-b/m)*v + (1/m)*u ;
end
