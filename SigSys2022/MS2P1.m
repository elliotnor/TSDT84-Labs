% MS2P1.m : MATLAB Session 2, Program 1
% Script M-file determines characteristic roots of op-amp circuit.

% Set component values:
R = [1e4, 1e4, 1e4];
C = [1e-6, 1e-6];
% Determine coefficients for characteristic equation:
a0 = 1;
a1 = (1/R(1)+1/R(2)+1/R(3))/C(2);
a2 = 1/(R(1)*R(2)*C(1)*C(2));
A = [a0 a1 a2];
% Determine characteristic roots:
lambda = roots(A);