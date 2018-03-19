function [ Xdot ] = spacecraft_attitude_dynamics( t,X,U )
%Authour : Mr. Omkar Waghmare (Masters Student, Department of Aerospace, University of Michigan, Ann
%Arbor)
%This Function contains spacecraft attitude dynamics.
% Details of Input arguments
% X = [w1 w2 w3 phi theta pssi]'    % Input the function -> note the order
% phi -> roll angle, theta -> pitch angle , pssi-> yaw angle
% U = [u1 u2 u3]'                   % Input control moments
clc
clear all
%% Check input validity
if nargin < 2 
disp('Function needs more argument!')
disp('Details of Input arguments:')
disp('spacecraft_attitude_dynamics( t,X,U ) function where,')
disp('1) X = [w1; w2; w3; phi; theta; pssi] ==>> phi -> roll angle, theta -> pitch angle , pssi-> yaw angle')
disp('2) U = [u1; u2; u3]  -> Input control moments (considered zero vector if not given)')
return
elseif nargin == 2
    U = [0;0;0];
end

%% Some System Constants of Spacecraft
J = [918 920 1365];                 % Inertia of spacecraft -> Units: kg/m3

%% Reading and assiging values from input arguments
J1 = J(1);  J2 = J(2);  J3 = J(3);
u1 = U(1);  u2 = U(2);  u3 = U(3);
w1 = X(1);  w2 = X(2);  w3 = X(3);
phi =  X(4);    theta =  X(5);  pssi =  X(6);

%% Equations
Xdot(1) = (u1 - (J3-J2)*w2*w3)/J1;
Xdot(2) = (u2 - (J1-J3)*w1*w3)/J2;
Xdot(3) = (u3 - (J2-J1)*w1*w2)/J3;
Xdot(4) = w1 + sin(phi)*tan(theta)*w2 + cos(phi)*tan(theta)*w3;
Xdot(5) = cos(phi)*w2 - sin(phi)*w3;
Xdot(6) = sin(phi)*sec(theta)*w2 + cos(phi)*sec(theta)*w3;

Xdot = Xdot(:);                     % making a Column Vector
end