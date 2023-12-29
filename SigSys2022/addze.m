function H=addze(G,zero)
%ADDZE Adderar nollställen till laplace- eller z-transformer.
%
%    Y = ADDZE(X,[z1 z2...zn]) - X är laplace- eller z-transform och
%                              z1...zn är komplexa tal.
%    
%    Beskrivning:
%    Nollställena z1...zn läggs till X:s befintliga nollställen. Eventuella
%    sammanfallande poler och nollställen tas bort. För komplexa nollställen
%    adderas konjugatet automatiskt.
%    
%    See also:
%    IN, ADDPO, REMPO, REMZE, PO, ZE, PZ, COEFF.
%    

global pm1 pm2 pm3 pm4 KlabL
if nargin==1, error('Input incorrect'); end
if vtype(G)==6 | vtype(G)==10,
 zz=[];
 i=length(zero);
 while i>0,
  z=zero(1);
  a=find(zero==conj(z) & imag(zero)~=0);
  if length(a)~=0,
   zz=[zz zero(a(1))];
   zero(a(1))=[];
   i=i-1;
  elseif imag(z)~=0,
   zz=[zz conj(z)];
  end
  zz=[zz zero(1)];
  zero(1)=[];
  i=i-1;
 end
 nn=G(1,2)+length(zz);
 nd=G(2,2);
 n=max(nd,nn);
 H=[G(1,1) nn G(1,3:3+G(1,2)) zz zeros(1,n-nn)];
 H=[H;[G(2,1:3+G(2,2)) zeros(1,n-nd)]];
 H=elimpz(H);
else
	error('Input incorrect: not Laplace- or z-transform')
end



