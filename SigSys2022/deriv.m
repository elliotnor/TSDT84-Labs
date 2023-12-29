function y=deriv(x)
%DERIV Derivering av signaler.
%
%    y = DERIV(x) - x är tidskontinuerlig signal.
%    
%    Beskrivning:
%    Approximativ derivering av tidskontinuerliga signaler. Derivatan 
%    x'(t) approximeras till ungefär lika med (x(t+T)-x(t))/T, där T 
%    bestäms av sampelfrekvensen (kan ej påverkas av användaren).
%    
%    See also: 
%    INTEGR
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(x)==4,
 y=diff(x(1:KlabL));
 y=[[y(1) y]/x(KlabL+1) x(KlabL+1)];
else
 error('Input incorrect: not signal')
end



 
 
