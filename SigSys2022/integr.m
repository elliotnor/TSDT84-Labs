function y=integr(x)
%INTEGR Integrering av signaler.
%
%    y = INTEGR(x) - x är en tidskontinuerlig signal.
%    
%    Beskrivning:
%    Approximativ integrering av tidskontinuerliga signaler. Integralen 
%    approximeras som integralen över x(t)dt som är ungefär lika med 
%    T*summa{x(nT)}, där T bestäms av sampelfrekvensen (kan ej påverkas 
%    av användaren).
%    
%    See also:
%    DERIV
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(x)==4,
 y=cumsum(x(1:KlabL))*x(KlabL+1);
 y=[y x(KlabL+1)];
else
 error('Input incorrect: not signal')
end

