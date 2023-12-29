function x=ilaptr(X)
%ILAPTR Invers laplacetransformering.
%
%    x = ILAPTR(X) - X är laplacetransform.
%    
%    Beskrivning:
%    Funktionen beräknar invers laplacetransform för laplacetransformer med
%    högersidigt konvergensområde och vars poler är enkla och finns i
%    vänster halvplan eller på jw-axeln.
%    
%    Example:
%    X = in([1],[1 1],'s');
%    x = ilaptr(X);
%    
%    Vanliga fel:
%    ilaptr använder en partialbråksuppdelning från Matlabs bibliotek, och 
%    denna klarar inte multipelpoler. Se även till att transformen inte har 
%    några poler i höger halvplan. Notera att signalen måste vara 
%    bandbegränsad med ett frekvensinnehåll under 3200 Hz.
%    
%    See also: 
%    IFOUTR, IZTR
%    

global pm1 pm2 pm3 pm4 KlabL FSMAX
if vtype(X)~=6, error('Input incorrect: not Laplace transform'); end
if any(real(X(2,4:3+X(2,2)))>0), error('Poles in rhpl'); end
b=bandwi(X);
if b==Inf, error('Infinite bandwidth'); end

% Test 2020-11-27 för att få en inverstransform med högre upplösning längs
% tidsaxeln, dvs. som inte ä lika hackig:
MAXPO = max(abs(imag(po(X))))/2/pi;  % Imaginärdelen/2pi av den pol som är längst från origo
if b<5*MAXPO
    b=min(5*MAXPO, FSMAX/2);   % Välj en högre bandbredd än den rätta/rimliga, så att inte inverstransformen blir så hackig när den ritas.
end

t=(0:KlabL/2-1)/(2*b);
Xt=X(1,3)*poly(X(1,4:3+X(1,2)));
Xn=X(2,3)*poly(X(2,4:3+X(2,2)));
[r,p,k]=residue(Xt,Xn);
r=r';
p=p';
x=[zeros(1,KlabL) 1/(2*b)];
for i=1:length(r)
 x(1+KlabL/2:KlabL)=x(1+KlabL/2:KlabL)+r(i)*exp(p(i)*t);
end
if max(imag(x))>.01*max(real(x)),
 disp('Varning: Signalen är komplexvärd, realdelen används.')
end
x=real(x);




 
