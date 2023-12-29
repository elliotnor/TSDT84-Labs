function [H] = MS5P1(B,A,Omega);
% MS5P1.m : MATLAB Session 5, Program 1
% Function M-file computes frequency response for LTID systems
% INPUTS:   B = vector of feedforward coefficients
%           A = vector of feedback coefficients
%           Omega = vector of frequencies [rad], typically -pi<=Omega<=pi
% OUTPUTS:  H =  frequency response

N_1 = length(B)-1; N_2 = length(A)-1;
H = polyval(B,exp(j*Omega))./polyval(A,exp(j*Omega)).*exp(j*Omega*(N_2-N_1));
output=H;