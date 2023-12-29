function p=po(H)
%PO Pollägen.
%
%    p = PO(X) - X är laplace- eller z-transform.
%    
%    Beskrivning:
%    Returnerar en radvektor med X:s poler.
%    
%    See also:
%    ZE
%    

global pm1 pm2 pm3 pm4 KlabL
vh=vtype(H);
if vh==6 | vh==10,
 p=H(2,4:3+H(2,2));
else
 error('Input incorrect: not Laplace- or z-transform')
end

