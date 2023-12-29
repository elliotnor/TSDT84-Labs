function [W] = MS9P1(N_0);
% MS9P1.m : MATLAB Session 9, Program 1
% Function M-file computes the N_0-by-N_0 DFT matrix W.

W = (exp(-j*2*pi/N_0)).^((0:N_0-1)'*(0:N_0-1));
output=W;