function c=add(a,b)
%ADD Adderar signaler eller transformer.
%
%    z = ADD(x,y) - x och y är signaler.
%    Z = ADD(X,Y) - X och Y är fourier-, laplace- eller z-transformer.
%    
%    See also:
%    MULT, OUTPUT
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(a)==1,
 if vtype(b)==1,
  c=a+b;
 elseif vtype(b)==4 | vtype(b)==8,
  c=b;
  c(1:KlabL)=a+c(1:KlabL);
  c(KlabL+1:length(c))=abs(c(KlabL:length(c)));
 elseif vtype(b)==5 | vtype(b)==9,
  c=b;
  c(1:KlabL)=a+c(1:KlabL);
  if vtype(c)==5, c(KlabL+1:KlabL+2)=abs(c(KlabL+1:KlabL+2)); end
 else
  error('Input incorrect')
 end
elseif vtype(b)==1,
 if vtype(a)==4 | vtype(a)==8,
  c=a;
  c(1:KlabL)=b+c(1:KlabL);
  c(KlabL+1:length(c))=abs(c(KlabL+1:length(c)));
 elseif vtype(a)==5 | vtype(a)==9,
  c=a;
  c(1:KlabL)=b+c(1:KlabL);
  if vtype(c)==5, c(KlabL+1:KlabL+2)=abs(c(KlabL+1:KlabL+2)); end
 else
  error('Input incorrect')
 end
elseif vtype(a)==4 & vtype(b)==4,
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
 c=[a(1:KlabL)+b(1:KlabL) a(KlabL+1)];
elseif vtype(a)==5 & vtype(b)==5,
 a(KlabL+1:KlabL+2)=abs(a(KlabL+1:KlabL+2));
 b(KlabL+1:KlabL+2)=abs(b(KlabL+1:KlabL+2));
 a=ifoutr(a);
 b=ifoutr(b);
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
 c=[a(1:KlabL)+b(1:KlabL) a(KlabL+1)];
 c=foutr(c);
elseif vtype(a)==6 & vtype(b)==6,
 Na=a(1,3)*[poly(a(1,4:3+a(1,2))) 0];
 Da=a(2,3)*[poly(a(2,4:3+a(2,2))) 0];
 Nb=b(1,3)*[poly(b(1,4:3+b(1,2))) 0];
 Db=b(2,3)*[poly(b(2,4:3+b(2,2))) 0];
 N1=conv(Na,Db);
 N2=conv(Nb,Da);
 M=max(length(N1),length(N2));
 N=[zeros(1,M-length(N1)) N1]+[zeros(1,M-length(N2)) N2];
 D=conv(Da,Db);
 c=syst(N(1:length(N)-2),D(1:length(D)-2),'s');
 c=elimpz(c);
elseif vtype(a)==8 & vtype(b)==8,
 c=a+b;
elseif vtype(a)==9 & vtype(b)==9,
 c=a+b;
elseif vtype(a)==10 & vtype(b)==10,
 Na=a(1,3)*[poly(a(1,4:3+a(1,2))) 0];
 Da=a(2,3)*[poly(a(2,4:3+a(2,2))) 0];
 Nb=b(1,3)*[poly(b(1,4:3+b(1,2))) 0];
 Db=b(2,3)*[poly(b(2,4:3+b(2,2))) 0];
 N1=conv(Na,Db);
 N2=conv(Nb,Da);
 M=max(length(N1),length(N2));
 N=[zeros(1,M-length(N1)) N1]+[zeros(1,M-length(N2)) N2];
 D=conv(Da,Db);
 c=syst(N(1:length(N)-2),D(1:length(D)-2),'z');
 c=elimpz(c);
else
 error('Input incorrect')
end
