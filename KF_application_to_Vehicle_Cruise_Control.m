%%
clc
clear
%% Printing Code Execution Date & time
disp('----------------- KF application to Vehicle Cruise Control -----------------');
Dtimes = datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z');
disp(['Code Executed on: ' char(Dtimes)] );

%% Load Data into workspace
load('Cruise_Control_Simulink_Data.mat')

%% Run Simulink Model
sim('Cruise_Control_Simulink')
%% Kalman Filter Estimation Starts from here
i = 1;
yhatOut = [];
for i=1:1:size(Meas.Data)

if i==1
% First time through the code so do some initialization
   xhat = 5;
   P = 0;
   A = 0.9998; % Discrete Version of actual A
   B = 9.9988e-06; % Discrete Version of actual B
   C = 1; % Discrete Version of actual C
   Q = 0.001^2;
   R = 0.2^2;
end
% Propagate the state estimate and covariance matrix:
xhat = A*xhat + B*ukm1.Data(i);
P = A*P*A' + Q;
% Calculate the Kalman gain
K = P*C'/(C*P*C' + R);
% Calculate the measurement residual
resid = Meas.Data(i) - C*xhat;

% Update the state and error covariance estimate
xhat = xhat + K*resid;
P = (eye(size(K,1))-K*C)*P;

% Post the results
xhatOut = xhat;
yhatOut(i) = C*xhat;   
i = i +1;
end 

%% Plot the data 
figure(1)
plot(yhatOut,'r');
hold on
plot(Trajectory.Data,'b');
legend('Estimated Trajectory','Original Trajectory');
title('Filtered Data')

figure(2)
plot(Meas.Data);
title('Original Unfiltered Data')

%% 
disp('Plots Created ...');
disp('----------------- Execution Completed Successfully -----------------');