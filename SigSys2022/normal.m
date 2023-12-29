function H=normal(G,f)
%NORMAL Amplitudnormering av transformer.
%
%    Y = NORMAL(X)    - X är fourier-, laplace- eller z-transform eller DFT.
%    Y = NORMAL(X,f0) - X är fourier-, laplace- eller z-transform, 
%                     f0 är ett reellt tal.
%    Y = NORMAL(X,k0) - X är DFT, k0 är ett reellt heltal.
%    
%    Beskrivning:
%    Normerar en transform med avseende på största amplitudvärde eller med 
%    avseende på amplitud i frekvensen f0 resp. amplitud i punkten k0. 
%    Laplace- och z-transformer normeras med avseende på värden på imaginära 
%    axeln resp. enhetscirkeln.
%    
%    Example:
%    H = in([1 1],[1 2 1],'s');
%    G = normal(H);
%    
%    See also:
%    AMPL, VALUE
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(G)==5,
 if nargin==2,
  a=round(KlabL*f/G(KlabL+1));
  if a<0 | a>KlabL/2-1, error('Input incorrect'); end
  nf=abs(G(a+1));
 else
  nf=max(abs(G(1:KlabL)));
 end
 H=ampl(G,1/nf);
elseif vtype(G)==6,
 N=G(1,3)*poly(G(1,4:3+G(1,2)));
 D=G(2,3)*poly(G(2,4:3+G(2,2)));
 if nargin==2,
  H=polyval(N,j*2*pi*f)./polyval(D,j*2*pi*f);
  nf=abs(H);
 else
  r=max([imag(po(G)) 1]);
  w=j*(0:r/50:5*r);
  H=polyval(N,w)./polyval(D,w);
  nf=max(abs(H));
 end
 H=ampl(G,1/nf);
elseif vtype(G)==9,
 if nargin==2,
  a=round(KlabL*f);
  if a<0 | a>KlabL/2-1, error('Input incorrect'); end
  nf=abs(G(a+1));
 else
  nf=max(abs(G));
 end
 H=ampl(G,1/nf);
elseif vtype(G)==10,
 N=G(1,3)*poly(G(1,4:3+G(1,2)));
 D=G(2,3)*poly(G(2,4:3+G(2,2)));
 if nargin==2,
  H=polyval(N,exp(j*2*pi*f))./polyval(D,exp(j*2*pi*f));
  nf=abs(H);
 else
  w=1/512*(0:256);
  H=polyval(N,exp(j*2*pi*w))./polyval(D,exp(j*2*pi*w));
  nf=max(abs(H));
 end
 H=ampl(G,1/nf);
elseif vtype(G)==11,
 if nargin==2,
%  if f<0 | a>U(129)-1, error('Input incorrect'); end FELAKTIG RAD! NÄSTA RÄTT?
  if f<0 | a>G(129)-1, error('Input incorrect'); end
  nf=abs(G(f+1));
 else
  nf=max(abs(G(1:128)));
 end
 H=[G(1:128)/nf G(129)];
else
 error('Input incorrect: not transform')
end
