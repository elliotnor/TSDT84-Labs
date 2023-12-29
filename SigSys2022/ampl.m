function y=ampl(x,K)
%AMPL Multiplicerar signaler eller transformer med konstanter.
%
%    y = AMPL(x,K) - x är signal, K är reellt tal.
%    Y = AMPL(X,K) - X är fourier-, laplace- eller z-transform, K är reellt tal.
%    Y = AMPL(X,K) - X är DFT, K är reellt tal.
%    
%    Beskrivning:
%    Signalen eller transformen multipliceras med konstanten K.
%    
%    See also:
%    MULT, OUTPUT, NORMAL
%    

global pm1 pm2 pm3 pm4 KlabL
vx=vtype(x);
if vtype(K)~=1, error('Input incorrect'); end
if vx==4 | vx==8 | vx==5 | vx==9,
  y=x;
  y(1:KlabL)=K*y(1:KlabL);
elseif vx==6 | vx==10,
 y=x;
 y(1,3)=K*y(1,3);
elseif vx==11,
 y=x;
 y(1:128)=k*y(1:128);
else
 error('Input incorrect')
end
