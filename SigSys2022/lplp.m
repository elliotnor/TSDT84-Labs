function G=lplp(H,fc)
%LPLP LP->LP-transformation.
%
%    y = LPLP(X,fc) - X är en laplacetransform, fc är ett reellt tal.
%    
%    Beskrivning:
%    Transformerar ett LP-filter med gränsfrekvens 1 Hz till ett LP-filter 
%    med gränsfrekvens fc.
%    
%    Example:
%    H = butterw(3);
%    G = lplp(H,5);
%    
%    See also:
%    LP, HP, LPHP
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(H)==6,
 G=[6 0 H(1,3);0 0 H(2,3)];
 G=addze(G,fc*H(1,4:3+H(1,2)));
 G=addpo(G,fc*H(2,4:3+H(2,2)));
 G(1,3)=G(1,3)*fc^(H(2,2)-H(1,2));
else
 error('Input incorrect: not Laplace transform')
end

