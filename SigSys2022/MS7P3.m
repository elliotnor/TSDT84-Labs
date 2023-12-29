function [w_K] = MS7P3(t,T,alpha)
% MS7P3.m : MATLAB Session 7, Program 3
% Function M-file computes a width-T Kaiser window using parameter alpha.  
% Alpha can also be a string identifier: 'rectangular', 'Hamming', or 
% 'Blackman'.
% INPUTS:   t = independent variable of the window function
%           T = window width
%           alpha = Kaiser parameter or string identifier
% OUTPUTS:  w_K = Kaiser window function
if strncmpi(alpha,'rectangular',1),
    alpha = 0;
elseif strncmpi(alpha,'Hamming',3),
    alpha = 5.4414;
elseif strncmpi(alpha,'Blackman',1),
    alpha = 8.885;
elseif isa(alpha,'char')
    disp('Unrecognized string identifier.'); return
end
w_K = zeros(size(t)); i = find(abs(t)<T/2);
w_K(i) = besseli(0,alpha*sqrt(1-4*t(i).^2/(T^2)))/besseli(0,alpha);
    
output=w_K;