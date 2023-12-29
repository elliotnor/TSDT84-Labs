function [H] = MS4P1(B,A,omega);
% MS4P1.m : MATLAB Session 4, Program 1
% Function M-file computes frequency response for LTIC system
% INPUTS:   B = vector of feedforward coefficients
%           A = vector of feedback coefficients
%           omega = vector of frequencies [rad/s].
% OUTPUTS:  H =  frequency response

H = polyval(B,j*omega)./polyval(A,j*omega);
