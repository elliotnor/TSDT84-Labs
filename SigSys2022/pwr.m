function p=pwr(x)
%PWR Effekt-/energiberäkning.
%
%    E = PWR(x) - x är tidskontinuerlig eller tidsdiskret signal.
%    E = PWR(C) - C är fourierserie.
%    
%    Beskrivning:
%    Beräknar energin hos signalen x, alt. signalmedeleffekten hos
%    den periodiska signalen med fourierserierepresentation C.
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(x)==4,  % Tidskontinuerlig signal
 p=sum(x(1:KlabL).^2)*x(KlabL+1);
elseif vtype(x)==8,  % Tidsdiskret signal
 p=sum(x(1:KlabL).^2);
elseif vtype(x)==7, % Periodisk signal, fourierserie - Lasse lagt till i augusti 2004
 D=abs(x(1:256)).^2;
 d=sqrt(sum(D(3:256))/sum(D(2:256)));
 if d<1e-5, d=0; end
 dc=real(x(1));
 p=2*sum(D(2:256))+dc^2;
else
 error('Input incorrect: not signal')
end
