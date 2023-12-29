function Y=addtone(U,n,A,fi)
%ADDTONE Adderar deltoner till fourierserier.
%
%    D = ADDTONE(C,[k1 k2...kn],[A1 A2...An],[fi1 fi2...fin]) 
%                  - C är fourierserie, k1...kn är reella heltal, 
%                    A1...An är reella tal, fi1...fin är reella tal.
%    
%    Beskrivning:
%    Deltonerna k1...kn ändras så att de får motsvarande 
%    amplitud A1...An och fas fi1...fin .
%    
%    Example:
%    C = fouser('pulse(t,0,0.5)',1);
%    D = addtone(C,[1 3 8],[2 1 0.2],[0 pi/5 pi/10]);
%    
%    See also:
%    FOUSER, REMTONE, VALUE
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(U)~=7, error('Input incorrect: not Fourier series'); end
Y=U;
for i=1:length(n),
 if n(i)==0,
  Y(1)=A(i);
 else
  C=A(i)/2*sin(fi(i))-j*A(i)/2*cos(fi(i));
  Y(n(i)+1)=C;
  Y(513-n(i))=conj(C);
 end
end

