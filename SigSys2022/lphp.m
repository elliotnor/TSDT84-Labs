function G=lphp(H,fc)
%LPHP LP->HP-transformation.
%
%    y = LPHP(X,fc) - X är en laplacetransform, fc är ett reellt tal.
%    
%    Beskrivning:
%    Transformerar ett LP-filter med gränsfrekvens 1 Hz till ett 
%    HP-filter med gränsfrekvens fc.
%    
%    Example:
%    H  =  butterw(3);
%    G =  lphp(H,5);
%    
%    See also:
%    LP, HP, LPLP
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(H)==6,
 zh=[H(1,4:3+H(1,2)) inf*ones(1,H(2,2)-H(1,2))];
 ph=H(2,4:3+H(2,2));
 G=[6 0 1;0 0 1];
 wisq=fc*(2*pi)^2;
 zg=wisq ./zh;
 pg=wisq ./ph;
 G=addze(G,zg);
 G=addpo(G,pg);
 Kh=abs(polyval(poly(zh),j*2*pi)/polyval(poly(ph),j*2*pi));
 Kg=abs(polyval(poly(zg),j*2*pi*fc)/polyval(poly(pg),j*2*pi*fc));
 G(1,3)=H(1,3)/H(2,3)*Kh/Kg;
else
 error('Input incorrect: not Laplace transform')
end


