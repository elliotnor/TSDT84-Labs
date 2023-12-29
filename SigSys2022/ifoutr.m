function u=ifoutr(U)
%IFOUTR Invers fouriertransformering.
%
%    x = IFOUTR(X) - X är fouriertransform.
%    
%    Example:
%    X = in('1/(1+j*w)','w');
%    x = ifoutr(X);
%    
%    Observera:
%    Om signalen skulle bli komplexvärd används realdelen.
%    
%    See also:
%    FOUTR, ILAPTR, IZTR
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(U)==5,
 u=U(KlabL+1)*swap(ifft(U(1:KlabL)));
 if max(imag(u))>.01*max(real(u)),
  disp('Warning: signal is complex, real part is used')
 end
 u=[real(u) 1/U(KlabL+1)];
elseif vtype(U)==9,
 u=swap(ifft(U));
 if max(imag(u))>.01*max(real(u)),
  disp('Warning: signal is complex, real part is used')
 end
 u=[real(u) 0 0 0 0];
else
 error('Input incorrect: not Fourier transform')
end
