function y=part(x,t1,t2)
%PART Tar ut delar av signaler.
%
%    y = PART(x,t1,t2) - x är tidskontinuerlig signal, t1 och t2 är reella tal.
%    
%    Beskrivning:
%    Ger y(t) = x(t) för t1 < =  t < =  t2 och y(t) = 0 för övrigt.
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(x)~=4, error('Input incorrect: not signal'); end
if nargin==2, t2=t1; t1=0; end
n1=round(t1/x(KlabL+1))+KlabL/2;
n2=round(t2/x(KlabL+1))+KlabL/2;
if n1<1, n1=1; end
if n2>KlabL, n2=KlabL; end
y=[zeros(1,n1-1) x(n1:n2) zeros(1,KlabL-n2) x(KlabL+1)];

