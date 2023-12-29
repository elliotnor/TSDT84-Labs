function h=fir(a,n)
%FIR Definition av FIR-filter.
%
%    h = FIR([h0 h1...hm]) - h0...hm är reella tal.
%    h = FIR([h0 h1...hm],n0) - h0...hm är reella tal, n0 är reellt heltal.
%    
%    Beskrivning:
%    Ger ett FIR-filter vars impulssvar börjar i n = n0 och ges av h0...hm. 
%    Om n0 utelämnas sätts den till 0.
%    
%    Example:
%    h = fir([1 3 2 7 3 0.2],-2);
%    
%    See also: 
%    FIRWIN, FIROPT, FIRZTR, PZCHANGE
%    

global pm1 pm2 pm3 pm4 KlabL
if nargin==1, n=0; end
if abs(n)>KlabL/2, error('Illegal start value'); end
if n+length(a)>KlabL/2, error('Sequence too long'); end
h=zeros(1,KlabL+4);
h((KlabL/2+1+n):(KlabL/2+length(a)+n))=a;



