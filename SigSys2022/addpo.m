function H=addpo(G,pole)
%ADDPO Adderar poler till laplace- eller z-transformer.
%
%    y = ADDPO(X,[p1 p2 ... pn]) - X ärlaplace- eller z-transform
%                                och p1...pn är komplexa tal.
%    
%    Beskrivning:
%    Polerna p1...pn läggs till X:s befintliga poler. Eventuella 
%    sammanfallande poler och nollställen tas bort. För komplexa 
%    poler adderas konjugatet automatiskt.
%    
%    Example:
%    X = in([1],[1],'s');
%    Y = addpo(X,[-1 -2+6*j -3+10*j]);
%    
%    See also:
%    IN, ADDZE, REMPO, REMZE, PO, ZE, PZ, COEFF
%    

global pm1 pm2 pm3 pm4 KlabL
if nargin==1, error('Input incorrect'); end
vg=vtype(G);
if vg==6 | vg==10,
 pp=[];
 i=length(pole);
 while i>0,
  p=pole(1);
  a=find(pole==conj(p) & imag(pole)~=0);
  if length(a)~=0,
   pp=[pp pole(a(1))];
   pole(a(1))=[];
   i=i-1;
  elseif imag(p)~=0,
   pp=[pp conj(p)];
  end
  pp=[pp pole(1)];
  pole(1)=[];
  i=i-1;
 end
 nn=G(1,2);
 nd=G(2,2)+length(pp);
 n=max(nd,nn);
 H=[G(1,1:3+G(1,2)) zeros(1,n-nn)];
 H=[H;[G(2,1) nd G(2,3:3+G(2,2)) pp zeros(1,n-nd)]];
 H=elimpz(H);
else
	error('Input incorrect: not Laplace- or z-transform')
end


