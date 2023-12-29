function U=dft32(u,type,n0)
%DFT32 32 punkters DFT.
%
%    X = DFT32(x,typ) - x är tidsdiskret signal, typ är text.
%    X = DFT32(x,typ,n0) - x är tidsdiskret signal, typ är text, 
%                        n0 är reellt heltal.
%    
%    Beskrivning:
%    Fönstrar signalen x och beräknar en 32 punkters DFT av den fönstrade 
%    signalen. Fönstertypen anges med textsträngen typ, vilken skall omges 
%    av apostrofer. Tillgängliga fönstertyper finns angivna i hjälptexten för 
%    kretslabfunktionen window. 
%    Fönstringen börjar i n = n0. Om n0 utelämnas sätts den till 0.
%    
%    Example:
%    x = sample('sin(2*pi*t)',5);
%    X = dft32(x,'hann',10);
%    
%    See also:
%    WINDOW, DFT8, DFT16, DFT64, DFT128
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(u)~=8, error('Input incorrect: not signal'); end
if nargin<3, n0=0; end
if n0<-KlabL/2 | n0+32>KlabL/2, error('Input incorrect'); end
u=window(u,type,32,n0);
U=[fft(u(KlabL/2+1+n0:KlabL/2+32+n0)) zeros(1,96) 32];
