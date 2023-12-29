function y=noise(x,var)
%NOISE Addition av brus.
%
%    y = NOISE(x,sigma_2) - x är en signal och sigma_2 är ett reellt tal.
%    
%    Beskrivning:
%    Adderar x med vitt normalfördelat brus med varians sigma_2
%    (notera att variansen är ungefär lika med signaleffekten).
%    
%    Example:
%    x = in('sin(10*pi*t)','t');
%    y = noise(x,0.5);
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(x)==4 | vtype(x)==8,
 if nargin==1, var=1; end
 y=x;
 y(1:KlabL)=y(1:KlabL)+sqrt(var)*randn(1,KlabL);
else
 error('Input incorrect: not signal')
end


