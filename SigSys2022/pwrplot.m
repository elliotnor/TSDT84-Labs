function pwrplot(X,fmax)
%pwrplot
% pwrplot används av Kretslabfunktionen pwrspect

global pm1 pm2 pm3 pm4 KlabL
if vtype(X)==5,
 P=real(abs(X(1:KlabL/2)).^2);
 f=X(KlabL+2)*(0:(KlabL/2-1));
 if nargin<2, fmax=X(KlabL+1)/2; end
 b=find(f<=fmax);
 plot(f(b),P(b))
 grid
 p=sum(abs(X(1:KlabL)).^2)*X(KlabL+2);
 p=num2str(p);
 xlabel(['Total energy ' p ' Ws         Frequency (Hz)'])
 title('Power spectrum')
else
 P=real(abs(X(1:KlabL/2)).^2);
 f=(0:(KlabL/2-1))/KlabL;
 if nargin<2, fmax=.5; end
 b=find(f<=fmax);
 plot(f(b),P(b))
 grid
 p=sum(abs(X).^2)/KlabL;
 p=num2str(p);
 xlabel(['Total energy ' p ' Ws         Normalized frequency'])
 title('Power spectrum')
end


