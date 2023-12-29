function logspectmod(X,fmax)
%LOGSPECTMOD Ritar spektrum i dB-skala
%    logspectmod(X,fmax) är som logspect, men utan 
%    att rensa skärmen först.
%    Endast amplitudspektrum/-karaktäristik ritas (i dB-skala).
%    X är fourier-, laplace- eller z-transform.
% 
% See also logspect

global pm1 pm2 pm3 pm4 KlabL
if length(find(vtype(X)==[5 6 9 10 11]))>0,
 if nargin==1,
  splplot(X,1)
 else
  splplot(X,1,fmax)
 end
end

