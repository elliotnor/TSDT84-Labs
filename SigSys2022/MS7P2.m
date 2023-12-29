function [W,E_W] = MS7P2(tau,beta,tol)
% MS7P2.m : MATLAB Session 7, Program 2
% Function M-file computes essential bandwidth W for square pulse.
% INPUTS:   tau = pulse width
%           beta = fraction of signal energy desired in W
%           tol = tolerance of relative energy error
% OUTPUTS:  W = essential bandwidth [rad/s]
%           E_W = Energy contained in bandwidth W
W = 0; step = 2*pi/tau; % Initial guess and step values
%X_squared = inline('(tau*MS7P1(omega*tau/2)).^2','omega','tau');
X_squared = (tau*MS7P1(omega*tau/2)).^2;
E = beta*tau; % Desired energy in W
relerr = (E-0)/E; % Initial relative error is 100 percent 
while(abs(relerr) > tol),
    if (relerr>0), % W too small
        W=W+step; % Increase W by step
    elseif (relerr<0), % W too large
        step = step/2; W = W-step; % Decrease step size and then W.
    end
    E_W = 1/(2*pi)*quad(X_squared,-W,W,[],[],tau);
    relerr = (E - E_W)/E;
end
 
    
output=[W,E_W];