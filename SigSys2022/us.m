function x=us(t,t0)
% US Heavisidefunktionen (enhetssteget)
% x = US(t,t0) returnerar heavisidefunktionen u(t-t0)
%
%    See also:
%    PULSE

global pm1 pm2 pm3 pm4 KlabL
if nargin==1, t0=0; end
a=find(t-t0>=0);
x=zeros(size(t));
x(a)=x(a)+1;

