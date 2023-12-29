function [p,z] = MS5P2(B,A);
% MS5P2.m : MATLAB Session 5, Program 2
% Function M-file computes and plots poles and zeros for LTID systems
% INPUTS:   B = vector of feedforward coefficients
%           A = vector of feedback coefficients

N_1 = length(B)-1; N_2 = length(A)-1;
p = roots([A,zeros(1,N_1-N_2)]); z = roots([B,zeros(1,N_2-N_1)]);
ucirc = exp(j*linspace(0,2*pi,200)); % Compute unit circle for pole-zero plot
plot(real(p),imag(p),'xk',real(z),imag(z),'ok',real(ucirc),imag(ucirc),'k:');
xlabel('Real'); ylabel('Imaginary');
ax = axis; dx = 0.05*(ax(2)-ax(1)); dy = 0.05*(ax(4)-ax(3));
axis(ax+[-dx,dx,-dy,dy]);
output=p;
    
