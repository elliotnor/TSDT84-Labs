function X=foutr(x,b)
%FOUTR Fouriertransformering.
%
%    X = FOUTR(x) - x är tidskontinuerlig eller tidsdiskret signal.
%    Y = FOUTR(X) - X är laplace- eller z-transform.
%    
%    Beskrivning:
%    I andra fallet beräknas Y(f) = X(s) för s = j*2*pi*f,
%    respektive Y(theta) = X[z] för z = exp(j*2*pi*theta).
%    För laplacetransform krävs att motsvarande signal är bandbegränsad med 
%    bandbredd högst 200 Hz. Det krävs också att systemen har sina poler strikt
%    i vänster halvplan (för laplacetransformen) respektive strikt innanför 
%    enhetscirkeln (för z-transformen).
%    
%    Example:
%    x = in('exp(-t)*us(t)','t');
%    X = foutr(x);
%    
%    Vanliga fel:
%    Om signalen som transformeras har för stor bandbredd (till exempel om brus
%    har adderats) visas en varningstext. Om detta händer bör man kontrollera 
%    att spektrum ser rimligt ut innan man fortsätter.
%    
%    See also:
%    IFOUTR
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(x)==4, 
 X=fft(swap(x(1:KlabL)))*x(KlabL+1);
 X=[X 1/x(KlabL+1) 1/(x(KlabL+1)*KlabL)];
 if max(abs(X(1:KlabL/2)))<50*max(abs(X(.375*KlabL:KlabL/2))),
  disp('Warning: signal bandwidth may be too large');
 end
elseif vtype(x)==6,
 if any(real(x(2,4:3+x(2,2)))>0),
  error('Poles in rhpl, Fourier transform does not exist');
 end
 if nargin==1,
  if x(1,2)>=x(2,2),
   error('Infinite bandwidth')
  end
  x=ilaptr(x);
  X=x(KlabL+1)*fft(swap(x(1:KlabL)));
  X=[X 1/x(KlabL+1) 1/(x(KlabL+1)*KlabL)];
 else
  xt=x(1,3)*poly(x(1,4:3+x(1,2)));
  xn=x(2,3)*poly(x(2,4:3+x(2,2)));
  w=j*2*pi*(2*b/KlabL*(-KlabL/2:(KlabL/2-1)));
  X=polyval(xt,w)./polyval(xn,w);
  X=swap([X 2*b 2*b/KlabL]);
 end
elseif vtype(x)==8,
 X=fft(swap(x(1:KlabL)));
elseif vtype(x)==10,
 if any(abs(x(2,4:3+x(2,2)))>1),
  error('Poles outside |z|=1, Fourier transform does not exist');
 end
 x=iztr(x);
 X=fft(swap(x(1:KlabL)));
else
 error('Input incorrect: not signal or Laplace- or z-transform');
end


