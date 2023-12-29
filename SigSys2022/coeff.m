function [N,D]=coeff(H)
%COEFF Returnerar täljar- och nämnarpolynomskoefficienterna 
%    hos laplace- eller z-transformer.
%
%    [T,N] = COEFF(X) - X är laplace- eller z-transform.
%    
%    Beskriving:
%    T och N blir radvektorer med koefficienterna för transformens täljar- 
%    resp. nämnarpolynom. Högstagradskoefficienten står först i vektorn.
%    
%    See also:
%    IN, PO, ZE
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(H)==6 | vtype(H)==10,
 N=real(H(1,3)/H(2,3)*poly(H(1,4:3+H(1,2))));
 D=real(poly(H(2,4:3+H(2,2))));
else
 error('Input incorrect: not Laplace or z transform')
end
