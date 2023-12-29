function y=bp(u,fc1,fc2)
%BP Ideal bandpassfiltrering.
%
%    y = BP(x,fc1,fc2) - x är tidskontinuerlig signal, fc1 och fc2 är reella tal.
%    y = BP(x,theta_c1,theta_c2) - x är tidsdiskret signal,
%                                theta_c1 och theta_c2 är reella tal.
%    D = BP(C,fc1,fc2) - C är komplex fourierserieutveckling av tidskontinuerlig
%                      periodisk signal, fc1 och fc2 är reella tal.                            
%    Y = BP(X,fc1,fc2) - X är fouriertransform till tidskontinuerlig signal,
%    	              fc1 och fc2 är reella tal.
%    Y = BP(X,theta_c1,theta_c2) - X är fouriertransform till tidsdiskret signal, 
%                                theta_c1 och theta_c2 är reella tal.
%    
%    Beskrivning:
%    Ideal bandpassfiltrering med gränsfrekvenser fc1 och fc2 respektive 
%    normerade gränsfrekvenser theta_c1 och theta_c2.
%    
%    Example:
%    x = in('exp(-t)*sin(10*t)*us(t)','t');
%    y = bp(x,1,3);
%    
%    See also:
%    LP, HP, BS, OUTPUT
%    

global pm1 pm2 pm3 pm4 KlabL
if fc1<=0 | fc2<=0, error('Cutoff frequency must be positive'); end
fl=0;
if vtype(u)==4 | vtype(u)==5,
 if vtype(u)==5, u=ifoutr(u); fl=1; end
 a=ceil(2*KlabL*fc1*u(KlabL+1));
 b=ceil(2*KlabL*fc2*u(KlabL+1));
 if b>=KlabL,
  y=hp(u,fc1);
 else
  T=u(KlabL+1);
  u=[u(KlabL/2+1:KlabL) zeros(1,KlabL) u(1:KlabL/2)];
  u=fft(u);
  y=[u(1:b) zeros(1,2*(KlabL-b)+1) u(2*KlabL-b+2:2*KlabL)];
  y=[zeros(1,a) y(a+1:2*KlabL-a+1) zeros(size(2*KlabL-a+2:2*KlabL))];
  y=ifft(y);
  y=[y((1.5*KlabL+1):2*KlabL) y(1:KlabL/2) T];
  y=real(y);
  if fl==1, y=foutr(y); end
 end
elseif vtype(u)==8 | vtype(u)==9,
 if vtype(u)==9, u=ifoutr(u); fl=1; end
 a=ceil(2*KlabL*fc1);
 b=ceil(2*KlabL*fc2);
 if b>=KlabL,
  y=hp(u,fc1);
 else
  u=[u(KlabL/2+1:KlabL) zeros(1,KlabL) u(1:KlabL/2)];
  u=fft(u);
  y=[u(1:b) zeros(1,2*(KlabL-b)+1) u(2*KlabL-b+2:2*KlabL)];
  y=[zeros(1,a) y(a+1:2*KlabL-a+1) zeros(size(2*KlabL-a+2:2*KlabL))];
  y=ifft(y);
  y=[y((1.5*KlabL+1):2*KlabL) y(1:KlabL/2) 0 0 0 0];
  y=real(y);
  if fl==1, y=foutr(y); end
 end
elseif vtype(u)==7	% Filtrering av fourierserie. Tillägg Lasse A. 991115!
   y=remtone(u,'bp',[floor(fc1/u(513)) ceil(fc2/u(513))]); % wc/w1=fc*T: u(513)=1/T
else
 error('Input incorrect')
end

