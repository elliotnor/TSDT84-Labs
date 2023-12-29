function thd(C)
%THD Beräkning av klirrfaktor.
%
%    THD(C) - C är fourierserie.
%    
%    Beskrivning:
%    Beräknar total harmonisk distorsion (klirrfaktor), signalmedeleffekten 
%    (vid 1 ohm), medelvärde, RMS-värde och likriktat medelvärde för den 
%    periodiska signal som beskrivs av C.
%    
%    Example:
%    C = fouser('pulse(t,0,1)',2);
%    thd(C)
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(C)~=7, error('Input incorrect: not Fourier series'); end
D=abs(C(1:256)).^2;
d=sqrt(sum(D(3:256))/sum(D(2:256)));
if d<1e-5, d=0; end
dc=real(C(1));
p=2*sum(D(2:256))+dc^2;
if dc<1e-5*sqrt(p), dc=0; end
c=real(ifft(C(1:512)));
am=sum(abs(c));
disp(['Total harmonic distorsion ' num2str(d*100) ' %'])
disp(['Normalized (1 Ohm) signal power ' num2str(p) ' Watts'])
disp(['DC level ' num2str(dc)])
disp(['RMS value ' num2str(sqrt(p))])
disp(['Absolute mean ' num2str(am)])


