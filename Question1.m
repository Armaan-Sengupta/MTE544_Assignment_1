clc;

useSymbolic = false;

theta = -pi / 2;
alpha = pi / 6;
gamma = pi / 4;
psi = -pi / 2;
l1 = 1;
l2 = 1;
l_B = 0.5;
x = 0.8;
y = 0.8;

if useSymbolic
    syms theta alpha gamma l1 l2 l_B x y real % adding real at the end states theese are real numbers only
    psi = -sym(pi) / 2;
end

G_E_2 = [cos(psi), -sin(psi), l2;
         sin(psi),  cos(psi),  0;
                0,         0,  1];

G_2_1 = [cos(gamma), -sin(gamma), l1;
         sin(gamma),  cos(gamma),  0;
                  0,           0,  1];

G_1_B = [cos(alpha), -sin(alpha), l_B;
         sin(alpha),  cos(alpha),   0;
                  0,           0,   1];

G_B_S = [cos(theta), -sin(theta), x;
         sin(theta),  cos(theta), y;
                  0,           0, 1];

% Part A
G_E_S = G_B_S * G_1_B * G_2_1 * G_E_2;
if useSymbolic
    G_E_S = simplify(G_E_S);
    fprintf('G_E^S = %s\n', latex(G_E_S));
else
    fprintf('G_E^S =\n');
    disp(G_E_S);
end

if ~useSymbolic
       % Part B
       p_1_E = [0; 0; 1]; % Homogeneous coordinates
       p_2_E = [0.5; 1; 1]; % Homogeneous coordinates

       p_1_S = G_E_S * p_1_E;
       p_2_S = G_E_S * p_2_E;

       fprintf('p_1^S =\n');
       disp(p_1_S(1:2));
       fprintf('p_2^S =\n');
       disp(p_2_S(1:2));

       % Part C
       q_B = [1; 2; 1]; %Homogeneous coordinates
       q_E = (G_E_2^-1)*(G_2_1^-1)*(G_1_B^-1)*q_B
       fprintf('q^E =\n');
       disp(q_E(1:2));
end
