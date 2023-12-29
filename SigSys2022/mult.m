function c=mult(a,b)
%MULT Multiplicerar signaler.
%
%    z = MULT(x,y) - x och y är signaler.
%    
%    Beskrivning:
%    Funktionen multiplicerar signaler. 
%    För multiplikation med konstant skall ampl användas.
%    För multiplikation av transformer skall output användas.
%    
%    See also:
%    AMPL, OUTPUT, ADD
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(a)==4 & vtype(b)==4,
 a(KlabL+1)=abs(a(KlabL+1));
 b(KlabL+1)=abs(b(KlabL+1));
 k=log2(a(KlabL+1)/b(KlabL+1));
 if k>0,
  for i=1:k,
   a=intp(a);
  end
 elseif k<0,
  for i=1:-k,
   b=intp(b);
  end
 end
 c=a(1:KlabL).*b(1:KlabL);
 c=fft(c);
 if max(abs(c(1:KlabL/2)))<50*max(abs(c(.375*KlabL:KlabL/2))),
  a=intp(a);
  b=intp(b);
 end
 c=[a(1:KlabL).*b(1:KlabL) a(KlabL+1)];
elseif vtype(a)==8 & vtype(b)==8,
 c=a.*b;
else
 error('Input incorrect')
end
