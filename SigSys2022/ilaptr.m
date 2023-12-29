function x=ilaptr(X)
%ILAPTR Invers laplacetransformering.
%
%    x = ILAPTR(X) - X �r laplacetransform.
%    
%    Beskrivning:
%    Funktionen ber�knar invers laplacetransform f�r laplacetransformer med
%    h�gersidigt konvergensomr�de och vars poler �r enkla och finns i
%    v�nster halvplan eller p� jw-axeln.
%    
%    Example:
%    X = in([1],[1 1],'s');
%    x = ilaptr(X);
%    
%    Vanliga fel:
%    ilaptr anv�nder en partialbr�ksuppdelning fr�n Matlabs bibliotek, och 
%    denna klarar inte multipelpoler. Se �ven till att transformen inte har 
%    n�gra poler i h�ger halvplan. Notera att signalen m�ste vara 
%    bandbegr�nsad med ett frekvensinneh�ll under 3200 Hz.
%    
%    See also: 
%    IFOUTR, IZTR
%    

global pm1 pm2 pm3 pm4 KlabL FSMAX
if vtype(X)~=6, error('Input incorrect: not Laplace transform'); end
if any(real(X(2,4:3+X(2,2)))>0), error('Poles in rhpl'); end
b=bandwi(X);
if b==Inf, error('Infinite bandwidth'); end

% Test 2020-11-27 f�r att f� en inverstransform med h�gre uppl�sning l�ngs
% tidsaxeln, dvs. som inte � lika hackig:
MAXPO = max(abs(imag(po(X))))/2/pi;  % Imagin�rdelen/2pi av den pol som �r l�ngst fr�n origo
if b<5*MAXPO
    b=min(5*MAXPO, FSMAX/2);   % V�lj en h�gre bandbredd �n den r�tta/rimliga, s� att inte inverstransformen blir s� hackig n�r den ritas.
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
 disp('Varning: Signalen �r komplexv�rd, realdelen anv�nds.')
end
x=real(x);




 
