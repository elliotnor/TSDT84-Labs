function H=firztr(h)
%FIRZTR z-transformering av ändliga sekvenser.
%
%    X = FIRZTR(x) - x är tidsdiskret signal.
%    
%    Beskrivning:
%    z-transformerar en ändlig sekvens, till exempel impulssvaret för ett 
%    FIR-filter. Alla poler hamnar således i origo.
%    
%    See also: 
%    IZTR, FIR
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(h)~=8, error('Input incorrect: not impulse response'); end
h=[h(1:KlabL) 0 0];
if all(h==0),
 h=0;
 L=0;
else
 m=find(diff(h==0)~=0);
% L=max(m)-512; % Tidigare felaktig!!  Utbytt mot nästa rad 2004-11-17
 L=max(m)-KlabL/2;
 h=h(min(m)+1:max(m));
end
if L>0,
 H=syst(h,[1 zeros(1,L-1)],'z');
else
 H=syst([h zeros(1,1-L)],1,'z');
end

