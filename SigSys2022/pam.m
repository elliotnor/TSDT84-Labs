function y=pam(u,fs,str)
%PAM Pulsampitudmodulering.
%
%    y = PAM(x,fs)         - x är tidsdiskret signal, fs är reellt tal.
%    y = PAM(x,fs,uttryck) - x är tidsdiskret signal, fs är reellt tal, 
%                          uttryck är text.
%    
%    Beskrivning:
%    Funktionen pulsamplitudmodulerar x[n] med avståndet T = 1/fs mellan pulserna. 
%    Pulsformen p(t) ges som textsträngen uttryck innehållande det matematiska 
%    uttrycket som funktion av t. T och fs är tillåtna konstanter i uttrycket. 
%    Textsträngen skall omges av apostrofer. Om ingen pulsform anges används 
%    p(t) = sinc(t/T), vilket motsvarar ideal rekonstruktion.
%    
%    Example:
%    x = sample('exp(-t)*us(t)',10);
%    y = pam(x,10);
%    
%    Vanliga fel:
%    Om x[n] innehåller många punkter skilda från noll kan beräkningen ta 
%    väldigt lång tid. Spara gärna dina variabler innan du använder pam,
%    om du skulle behöva avbryta och starta om Matlab...
%    
%    See also:
%    SAMPLE
%    

global pm1 pm2 pm3 pm4 KlabL
if nargin<3, str='sinc(t*fs)'; end
if vtype(u)~=8, error('Input incorrect'); end
if vtype(str)~=1 & vtype(str)~=2, error('Input incorrect'); end
str=chstr(str,'t');
b=50;
T=1/fs;
for i=1:3
 t=1/(2*b)*(-256:255);
 X=eval(str);
 X=fft(X);
 if max(abs(X(1:256)))<=50*max(abs(X(193:256))),break; end
 b=b/2;
end
if b==6.25, b=12.5; end
v=abs(u(1:KlabL));
a=find(v>1e-3*max(v));
t0=(-KlabL/2:KlabL/2-1)/(4*b);
y=zeros(1,KlabL);
for i=a-KlabL/2-1,
 t=t0-i*T;
 y=y+u(i+KlabL/2+1)*eval(str);
end
y=[y 1/(4*b)];
