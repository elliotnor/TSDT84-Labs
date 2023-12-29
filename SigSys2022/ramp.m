function x=ramp(t,t1,t2)
%RAMP Rampfunktionen
%    x = RAMP(t,t1,t2) är lika med ((t-t1)/(t2-t1))*(u(t-t1)-u(t-t2)),
%    dvs. en rät linje från (t,x)=(t1,0) till (t,x)=(t2,1)

global pm1 pm2 pm3 pm4 KlabL
if nargin==2, t2=t1; t1=0; end
x=pulse(t,t1,t2).*(t-t1)/(t2-t1);
