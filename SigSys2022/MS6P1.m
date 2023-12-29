function [x_N,t] = MS6P1(A);
% MS6P1.m : MATLAB Session 6, Program 1
% Function M-file approximates x(t) using Fourier series
% truncated at |n|=N for (0 <= N <= 100).
% INPUTS:   A = width of rising edge
% OUTPUTS:  x_N = output matrix, where x_N(N+1,:) is the |n| = N truncation 
%           t = time vector for x_N

t = linspace(-pi/4,2*pi+pi/4,1000); % Time vector exceeds one period.
sumterms = zeros(101,length(t)); % Pre-allocate memory
sumterms(1,:) = (2*pi-A)/(4*pi); % Compute DC term
for n = 1:100, % Compute N remaining terms
    D_n = 1/(2*pi*n)*((exp(-j*n*A)-1)/(n*A) + j*exp(-j*n*pi));
    sumterms(1+n,:) = real(D_n*exp(j*n*t) + conj(D_n)*exp(-j*n*t));
end
x_N = cumsum(sumterms);
output=x_N;