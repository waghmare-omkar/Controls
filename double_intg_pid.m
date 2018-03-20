function Xdot = double_intg_pid(t,x)
% This Function is a PID controller for double integrator with actuator
% constraints and real dynamics involved.

% Author: Mr. Omkar Waghmare (Masters Student, Department of Aerospace,
% University of Michigan, Ann Arbor)

%% Notes for reference :
% 1) Propotinal Term Controls how fast we go to set point. 
% 2) Derivative acts kind of damper, helps reduce overshoot and oscillations.
% 3) Integral eliminates final offset but increases oscillatory behaviour
% 4) PID has less oscillatory performance then PI conreollers 
% 5) PID somewhat overall has faster settling time + shorter rise time + small overshoot
% 6) Derivative term somewhat losses its benefits when there is noise in
%    measurement (Noise Degrades derivative action)
% 7) Derivative in pressence of noise switches very fast and produces
%    something called 'chatter' in PID.
% 8) Anti-windup must be used in practice due to actuator('u') saturation.
%    watch : https://youtu.be/H4YlL3rZaNw (for anti-windup)

%% setpoint input and timestep input
target = 5;                        % Specify setpoint target
tstep = 0.1;                       % Specify same tstep from simulation

%% Control Actuator Constraints
u_lower_limit = -10000;                % Minimum possible Output (If no actuator limit, then set = 10000)
u_upper_limit = 10000;                 % Maximum possible Output (If no actuator limit, then set = -10000)

%% Controller , Dynamics and Actuating Limits
% ===== Controller =====
persistent error  error_sum  error_last  i 
x1 = x(1);
x2 = x(2);
K = 5;                             % Specify Proptional Gain
ti = 10000;                        % Specify Integral tuner
td = 25;                           % Specify Derivative tuner
xset = target ;

if isempty(i)
    u = 0;
    error_sum = 0;
    error_last = 0;
    i = 1;
end
error = xset - x1;
error_sum = error_sum + error ;
u = K*error + (K/ti)*error_sum + (K*td)*(error - error_last)/tstep ;            % PID feedback Law
error_last = error;
    
% ===== Simulate Actuator Operating Limits =====   
if u >= u_upper_limit
    u = u_upper_limit;
elseif u <= u_lower_limit
     u = u_lower_limit;
else
    u = u;
end
    
% ===== Real Dynamics =====    
Xdot(1) = x2 ;
Xdot(2) = u ;
Xdot = Xdot';
end

% Notes:

