function [T, X] = eulerF(odeFun, tspan, x0)
%This function uses forward euler integration technique to numerically integrate
%the EOM.
%Best way to use this function is to call this function as a
%'ODE45-type-solver' to do numerical integration or discretization.

%% Check Input Arguments and suggest input to user ==================
if nargin < 3
    disp('Please Input appropriate arguments!')
    disp('Input Arguments: eulerF(Model to discretize/integrate , tspan, initial_guess)')
    disp('1) Model : model(t,x) -> Eg. odeFun = @(t,x)Model(x, u);')
    disp('2) tspan : tspan = [start_time: step_size : end_time]; -> You automatically specify step size in tspan')
    disp('3) Model : initial_guess -> Eg. x0 =[0;0;...];')
    return
end 

%% Apply Forward Euler Technique ====================================
X = []; 
T = [];
Pk = [];
h = tspan(2) - tspan(1); % Finding Step Size
Pk = x0;
Pk1 = Pk;
t = 0;
k = 1;
while k <= length(tspan)
    X = [X , Pk1];
    Pk1 = Pk + odeFun(t , Pk).* h ;
    T(k) = t;
    t = k*h;
    Pk = Pk1;
    k = k+1;
end
end 