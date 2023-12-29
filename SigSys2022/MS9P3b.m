function [h] = MS9P3b(N);
% MS9P3.m : MATLAB Session 9, Program 3
% Function M-file designs a length-N FIR filter by sampling the desired
% magnitude response H.  Phase is defined to shift h[n] by (N-1)/2.
% INPUTS:   N = desired FIR filter length
%           H_d = inline function that defines the desired magnitude response
% OUTPUTS:  h = impulse response (FIR filter coefficients)

% Create N equally spaced frequency samples:
Omega = linspace(0,2*pi*(1-1/N),N)';
% Sample the desired magnitude response:

H_d = (mod(Omega,2*pi)>pi/4)&(mod(Omega,2*pi)<pi/2)+ (mod(Omega,2*pi)>3*pi/2)&(mod(Omega,2*pi)<7*pi/4);
H = H_d
% Define phase to shift h[n] by (N-1)/2:
H = H.*exp(-j*Omega*((N-1)/2));
H(fix(N/2)+2:N,1) = H(fix(N/2)+2:N,1)*((-1)^(N-1));
h = real(ifft(H));
output=h;