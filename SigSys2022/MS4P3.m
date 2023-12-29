function [C_N] = MS4P3(N);
% MS4P3.m : MATLAB Session 4, Program 3
% Function M-file computes Chebyshev polynomial coefficients
% using the recursion relation C_N(x) = 2xC_{N-1}(x) - C_{N-2}(x)
% INPUTS:   N = degree of Chebyshev polynomial
% OUTPUTS:  C_N =  vector of Chebyshev polynomial coefficients

C_Nm2 = 1; C_Nm1 = [1 0];       % Initial polynomial coefficients:
for t = 2:N;
    C_N = 2*conv([1 0],C_Nm1)-[zeros(1,length(C_Nm1)-length(C_Nm2)+1),C_Nm2];
    C_Nm2 = C_Nm1; C_Nm1 = C_N;
end
