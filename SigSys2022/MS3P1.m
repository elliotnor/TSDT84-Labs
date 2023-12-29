function [y] = MS3P1(b,a,x,yi);
% MS3P1.m : MATLAB Session 3, Program 1
% Function M-file filters data x to create y
% INPUTS:   b = vector of feedforward coefficients
%           a = vector of feedback coefficients
%           x = input data vector
%           yi = vector of initial conditions [y[-1], y[-2], ...]
% OUTPUTS:  y = vector of filtered output data

yi = flipud(yi(:)); % Properly format IC's.
y = [yi;zeros(length(x),1)]; % Preinitialize y, beginning with IC's.
x = [zeros(length(yi),1);x(:)]; % Append x with zeros to match size of y.
b = b/a(1);a = a/a(1); % Normalize coefficients.
for n = length(yi)+1:length(y),
    for nb = 0:length(b)-1,
        y(n) = y(n) + b(nb+1)*x(n-nb); % Feedforward terms.
    end
    for na = 1:length(a)-1,
        y(n) = y(n) - a(na+1)*y(n-na); % Feedback terms.
    end
end
y = y(length(yi)+1:end); % Strip off IC's for final output.
output=y;