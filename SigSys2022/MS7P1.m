function [y] = MS7P1(x);
% MS7P1.m : MATLAB Session 7, Program 1
% Function M-file computes the sinc function, y = sin(x)/x.

y = ones(size(x)); i = find(x~=0);
y(i) = sin(x(i))./x(i);
output=y;