function [lambda] = MS2P2(R,C)
% MS2P2.m : MATLAB Session 2, Program 2
% Function M-file determines characteristic roots of 
% op-amp circuit.
% INPUTS:   R = length-3 vector of resistances
%           C = length-2 vector of capacitances
% OUTPUTS:  lambda = characteristic roots

% Determine coefficients for characteristic equation:
a0 = 1;
a1 = (1/R(1)+1/R(2)+1/R(3))/C(2);
a2 = 1/(R(1)*R(2)*C(1)*C(2));
A = [a0 a1 a2];
% Determine characteristic roots:
lambda = roots(A);