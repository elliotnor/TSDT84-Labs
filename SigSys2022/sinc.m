function x=sinc(t)
% SINC Sinc-funktionen
% x = SINC(t) = sin(pi*t)/(pi*t)
%
global pm1 pm2 pm3 pm4 KlabL
t=t+eps*(t==0);
x=sin(pi*t)./(pi*t);
