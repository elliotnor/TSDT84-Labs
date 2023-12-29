function [h] = MS9P2(N);
% MS9P2.m : MATLAB Session 9, Program 2
% Function M-file designs a length-N FIR filter by sampling the desired
% magnitude response H.  Phase of magnitude samples is left as zero.
% INPUTS:   N = desired FIR filter length
%           H_d = inline function that defines the desired magnitude response
% OUTPUTS:  h = impulse response (FIR filter coefficients)

% Create N equally spaced frequency samples:
Omega = linspace(0,2*pi*(1-1/N),N)';
% Sample the desired magnitude response and create h[n]:
H_d = (mod(Omega,2*pi)<pi/4)+(mod(Omega,2*pi)>2*pi-pi/4);
H = 1.0*H_d; h = real(ifft(H));
output=h;