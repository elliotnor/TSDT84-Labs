function hw=window(h,type,L,n0)
%WINDOW Fönstring.
%
%    y = WINDOW(x,typ,L) - x är tidsdiskret signal, typ är text, 
%                        L är reellt heltal.
%    y = WINDOW(x,typ,L,n0) - x är tidsdiskret signal, typ är text, 
%                           L och  n0 är reella heltal.
%    
%    Beskrivning:
%    Fönstrar signalen x med ett fönster av längd L med början i n = n0. 
%    Om n0 utelämnas sätts den till 0. 
%    
%    Följande fönstertyper finns tillgängliga:
%    'rect'  = > Rektangulärt fönster
%    'bart'  = > Bartlettfönster
%    'hamm'  = > Hammingfönster
%    'hann'  = > Hanningfönster
%    'blac'  = > Blackmanfönster
%    'kais'  = > Kaiser-Besselfönster
%    'flat'  = > Flat top-fönster
%    
%    Example:
%    x = sample('sin(10*pi*t)',20);
%    y = window(x,'hann',21);
%    
%    Tips:
%    För att ta fram och studera en viss fönsterfunktion, kan man
%    man lämpligen göra enligt följande:
%    x = in('1',n);
%    y = WINDOW(...); 
%    Då blir y identiskt lika med vald fönsterfunktion.
%    
%    See also:
%    FIRWIN, PART, DFT8, DFT16, DFT32, DFT64, DFT128.
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(h)~=8, error('Input incorrect: not signal'); end
if length(type)~=4, error('Illegal window type'); end
if nargin<3, error('Input incorrect'); end
if L>KlabL, L=KlabL; end
if nargin<4, n0=0; end
if n0<-KlabL/2 | n0>KlabL/2-L, error('Illegal start value'); end
k=0:L-1;
if type=='rect',
 w=ones(size(k));
elseif type=='bart',
 Lh=floor(L/2);
 w(1:Lh)=2*(0:Lh-1)/(L-1);
 w(Lh+1:L)=2-2*(Lh:L-1)/(L-1);
elseif type=='hann',
 w=.5*(1-cos(2*pi*k/(L-1)));
elseif type=='hamm',
 w=.54-.46*cos(2*pi*k/(L-1));
elseif type=='blac',
 k=2*pi*k/(L-1);
 w=.42-.5*cos(k)+.08*cos(2*k);
elseif type=='kais',
 k=2*pi*k/(L-1);
 w=1-1.24*cos(k)+.244*cos(2*k)-.00305*cos(3*k);
elseif type=='flat',
 k=2*pi*k/(L-1);
 w=1-1.93*cos(k)+1.29*cos(2*k)-.388*cos(3*k)+.0322*cos(4*k);
else
 error('Illegal window type')
end
a=KlabL/2+1+n0;
hw=[zeros(1,a-1) h(a:a+L-1).*w zeros(1,KlabL-a-L+1) 0 0 0 0];

