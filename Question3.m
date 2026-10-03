clc;
clear;

syms theta l r u1 u2 u3 real

% Wheel orientation angles
beta = [sym(pi)/2; 7*sym(pi)/6; 11*sym(pi)/6];

% matrix mapping [x_dot; y_dot; theta_dot] to wheel speeds:
% u = (1/r) * G * [x_dot; y_dot; theta_dot]
G = [cos(theta + beta(1)), sin(theta + beta(1)), l;
        cos(theta + beta(2)), sin(theta + beta(2)), l;
        cos(theta + beta(3)), sin(theta + beta(3)), l];

% Invert G to express [x_dot; y_dot; theta_dot] in terms of [u1; u2; u3]
Ginv = simplify(inv(G));

fprintf('--- Forward Kinematic Matrix G ---\n');
disp(G);

fprintf('\n--- Inverse Matrix ---\n');
disp(Ginv);

% General forward kinematic calculation: u = (1/r) * G * q_dot
syms x_dot y_dot theta_dot real
q_dot = [x_dot; y_dot; theta_dot];
u_general = (1/r) * G * q_dot;

fprintf('\n--- Forward Kinematics: u = (1/r) * G * q_dot ---\n');
disp(u_general);

%% Part (b).II.1: Straight line with a slope of 60 degrees
fprintf('\n--- Part (b).II.1: Control Signals for 60 deg Slope ---\n');
q_dot_slope60 = [1; sqrt(sym(3)); 0];
u_slope60 = subs((1/r) * G * q_dot_slope60, {theta, r, l}, {0, sym(1)/10, sym(25)/100});

fprintf('[u1; u2; u3]:\n');
disp(u_slope60);

%% Part (b).II.2: R=1 Circle
fprintf('\n--- Part (b).II.2: R=1 Circle with [cos(theta); sin(theta); 1] ---\n');
q_dot_circle = [cos(theta); sin(theta); 1];
u_circle_sym = simplify((1/r) * G * q_dot_circle);

fprintf('Symbolic [u1; u2; u3]:\n');
disp(u_circle_sym);

% Numerical values with r = 0.10 m, l = 0.25 m:
u_circle_num = double(subs(u_circle_sym, {l, r}, {0.25, 0.10}));
fprintf('Numeric [u1; u2; u3] (rad/s) with r=0.10, l=0.25:\n');
disp(u_circle_num);
