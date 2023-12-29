function [Bd,Ad] = MS5P4(B,A,T);
% MS5P4.m : MATLAB Session 5, Program 4
% Function M-file bilinear transformation of a continuous-time filter
% described by vectors B and A into a discrete-time filter.
% Length of B must not exceed A.
% INPUTS:   B = vector of continuous-time filter feedforward coefficients
%           A = vector of continuous-time filter feedback coefficients
%           T = sampling interval
% OUTPUTS:  Bd = vector of discrete-time filter feedforward coefficients
%           Ad = vector of discrete-time filter feedback coefficients

if (length(B)>length(A)),
    disp('Numerator order must not exceed denominator order.');
    return
end
z = roots(B); p = roots(A); % s-domain roots
gain = real(B(1)/A(1)*prod(2/T-z)/prod(2/T-p));
zd = (1+z*T/2)./(1-z*T/2); pd = (1+p*T/2)./(1-p*T/2); % z-domain roots
Bd = gain*poly([zd;-ones(length(A)-length(B),1)]); Ad = poly(pd);

output1=Bd;
output2=Ad;