function y=decim(x)
%decim
% y=decim(x) - decimering av signal. Används lokalt av Kretslabfunktioner
global pm1 pm2 pm3 pm4 KlabL
if vtype(x)~=4, error('Input error: not signal'); end
if bandwi(x)<=12.5, error('Signal bandwidth too small'); end
y=[zeros(1,KlabL/4) x(1:2:KlabL) zeros(1,KlabL/4) 2*x(KlabL+1)];

