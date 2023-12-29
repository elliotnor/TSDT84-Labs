function y=delay(x,n)
%DELAY Fördröjning av signaler.
%
%    y = DELAY(x,t0) - x är signal, t0 är reellt tal.
%    y = DELAY(x,n0) - x är tidsdiskret signal, n0 är reellt heltal.
%    
%    Beskrivning:
%    Returnerar x(t-t0) respektive x[n-n0].
%    Notera att t0 och n0 även kan vara negativa. Då erhålls en
%    "vänsterskiftad" signal.
%    
%    Observera:
%    Kommandot gör egentligen ett cykliskt skift av den samplade 
%    signalvektorn x, varför den del av signalen som "försvinner
%    ut till höger" dyker upp igen till vänster. 
%    Detta görs för att få rätt resultat i frekvensdomänen.
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(x)==4,
 n=round(n/x(KlabL+1));
 if n<0, n=n+KlabL; end
 y=[x(KlabL-n+1:KlabL) x(1:KlabL-n) x(KlabL+1)];
elseif vtype(x)==8,
 if n<0, n=n+KlabL; end
 y=[x(KlabL-n+1:KlabL) x(1:KlabL-n) x(KlabL+1:KlabL+4)];
else
 error('Input incorrect: not signal');
end

