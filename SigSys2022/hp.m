function y=hp(u,fc)
%HP Ideal högpassfiltrering.
%
%    y = HP(x,fc ) - x är tidskontinuerlig signal, fc är reellt tal.
%    y = HP(x,theta_c) - x är tidsdiskret signal, theta_c är reellt tal.
%    D = bp(C,fc) - C är komplex fourierserieutveckling av tidskontinuerlig
%                      periodisk signal, fc är reellt tal.                            
%    Y = HP(X,fc) - X är fouriertransform till tidskontinuerlig signal, 
%                 fc är reellt tal.
%    Y = HP(X,theta_c) - X är fouriertransform till tidsdiskret signal, 
%                      theta_c är reellt tal.
%    
%    Beskrivning:
%    Ideal högpassfiltrering med gränsfrekvens fc respektive normerad 
%    gränsfrekvens theta_c.
%    
%    Example:
%    x = in('exp(-t)*sin(10*t)*us(t)','t');
%    y = hp(x,3);
%    
%    See also: 
%    LP, BP, BS, LPLP, LPHP, OUTPUT
%    

global pm1 pm2 pm3 pm4 KlabL
if fc<=0, error('Cutoff frequency must be positive'); end
fl=0;
if vtype(u)==4 | vtype(u)==5,
 if vtype(u)==5, u=ifoutr(u); fl=1; end
 a=ceil(2*KlabL*fc*u(KlabL+1));
 if a<KlabL,
  T=u(KlabL+1);
  u=[u(KlabL/2+1:KlabL) zeros(1,KlabL) u(1:KlabL/2)];
  u=fft(u);
  y=[zeros(1,a) u(a+1:2*KlabL-a+1) zeros(size(2*KlabL-a+2:2*KlabL))];
  y=ifft(y);
  y=[y((1.5*KlabL+1):2*KlabL) y(1:KlabL/2) T];
  y=real(y);
 else
  y=[zeros(1,KlabL) u(KlabL+1)];
 end
 if fl==1, y=foutr(y); end
elseif vtype(u)==8 | vtype(u)==9,
 if vtype(u)==9, u=ifoutr(u); fl=1; end
 a=ceil(2*KlabL*fc);
 if a<KlabL,
  u=[u(KlabL/2+1:KlabL) zeros(1,KlabL) u(1:KlabL/2)];
  u=fft(u);
  y=[zeros(1,a) u(a+1:2*KlabL-a+1) zeros(size(2*KlabL-a+2:2*KlabL))];
  y=ifft(y);
  y=[y((1.5*KlabL+1):2*KlabL) y(1:KlabL/2) 0 0 0 0];
  y=real(y);
 else
  y=zeros(1,KlabL+4);
 end
 if fl==1, y=foutr(y); end
elseif vtype(u)==7	% Filtrering av fourierserie. Tillägg Lasse A. 991115!
   y=remtone(u,'hp',floor(fc/u(513))); % wc/w1=fc*T: u(513)=1/T
else
 error('Input incorrect')
end

