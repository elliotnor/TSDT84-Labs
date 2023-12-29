function [Bd,Ad] = MS5P3(B,A,T);
% MS5P3.m : MATLAB Session 5, Program 3
% Function M-file first-order backward difference transformation
% of a continuous-time filter described by B and A into a discrete-time filter. 
% INPUTS:   B = vector of continuous-time filter feedforward coefficients
%           A = vector of continuous-time filter feedback coefficients
%           T = sampling interval
% OUTPUTS:  Bd = vector of discrete-time filter feedforward coefficients
%           Ad = vector of discrete-time filter feedback coefficients

z = roots(B); p = roots(A); % s-domain roots
gain = B(1)/A(1)*prod(1/T-z)/prod(1/T-p);
zd = 1./(1-T*z); pd = 1./(1-T*p); % z-domain roots
Bd = gain*poly(zd); Ad = poly(pd);
output1=Bd;
output2=Ad;