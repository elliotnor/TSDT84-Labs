function x=in(a,b,var)
%IN Definition av signaler och transformer.
%
%    x = IN(uttryck,'t') - uttryck är text.
%    x = IN(uttryck,'n') - uttryck är text.
%    X = IN(uttryck,'w') - uttryck är text.
%    X = IN(uttryck,'f') - uttryck är text.
%    X = IN(uttryck,'W') - uttryck är text.
%    X = IN(uttryck,'F') - uttryck är text.
%    X = IN([bm...b0],[an...a0],'s') - bm...b0 och an...a0 är reella tal.
%    X = IN([b0...bm],[a0...ak],'z') - b0...bm och a0...ak är reella tal.
%    
%    Beskrivning:
%    Inmatning av signaler och transformer på matematisk form. uttryck skall
%    vara en textsträng som beskriver signalen eller transformen som funktion 
%    av den variabel som väljs med det andra argumentet. Textsträngen skall 
%    omges av apostrofer. W betecknar den normerade vinkelfrekvensen Omega 
%    och F betecknar den normerade frekvensen theta. 
%    För laplace- och z-transformer anges täljar- och nämnarkoefficienterna
%    (se kursböckerna för definitioner och se nedan för ett par exempel). 
%    
%    Tidskontinuerliga signaler och transformer måste vara bandbegränsade med 
%    bandbredd högst 3200 Hz.
%    
%    Example:
%    x = in('exp(-t)*us(t)','t');   % x(t) = exp(-t)*u(t)
%    x = in('exp(-n/4)*us(n)','n'); % x[n] = exp(-n/4)*u[n]
%    X = in('1/(1+j*w)','w');       % X(w) = 1/(1+j*w)
%    X = in('1/(1+j*2*pi*f)','f');  % X(f) = 1/(1+j*2*pi*f)
%    X = in('1/(1-0.9*exp(-j*3*W))','W');    % X[Omega] = 1/(1-0.9*exp(-j*3*Omega))
%    X = in('1/(1-0.9*exp(-j*6*pi*F))','F'); % X[theta] = 1/(1-0.9*exp(-j*6*pi*theta))
%    X = in([1 2],[1 2 3],'s');     % X(s) = (s+2)/(s^2+2s+3)
%    X = in([1 2],[3 2 1],'z');     % X[z] = (z+2)/(3z^2+2z+1)
%    
%    Vanliga fel:
%    De matematiska uttrycken får bara innehålla den variabel som ges av 
%    det andra argumentet. Exempelvis fungerar *inte*
%    A = 5; x = IN('A*exp(-t)*us(t)','t');
%    eftersom funktionen in använder lokala variabler, och alltså inte 
%    "hittar" variabeln A när uttrycket skall beräknas. Använd i stället 
%    någon av de fyra fördefinierade globala variablerna pm1...pm4.
%    
%    See also: 
%    FOUSER, SAMPLE, PZCHANGE
%    

global pm1 pm2 pm3 pm4 KlabL FSMAX
if nargin==1, error('Variable must be specified'); end
if nargin==2, str=a; var=b; end
if nargin==2 & all('tfwnFW'~=var), error('Illegal variable'); end
if nargin==3 & all('sz'~=var), error('Illegal variable'); end

if var=='t',
 if vtype(str)~=1 & vtype(str)~=2, error('Input incorrect'); end
 str=chstr(str,var);
 b=bandwi(str,var);
 if b==Inf,
  b=FSMAX/2;
  disp('Warning: signal bandwidth may be too large')
 end
 fs=2*b;
 T=1/fs;
 t=T*(-KlabL/2:(KlabL/2-1));
 x=[eval(str) T];
elseif var=='f' | var=='w',
 if vtype(str)~=1 & vtype(str)~=2, error('Input incorrect'); end
 str=chstr(str,var);
 b=bandwi(str,var);
 if b==inf,
  b=FSMAX/2;
  disp('Warning: signal bandwidth may be too large')
 end
 fs=2*b;
 f=fs/KlabL*(-KlabL/2:(KlabL/2-1));
 w=2*pi*f;
 x=swap([eval(str) fs fs/KlabL]);
elseif var=='n',
 if vtype(str)~=1 & vtype(str)~=2, error('Input incorrect'); end
 str=chstr(str,var);
 n=-KlabL/2:(KlabL/2-1);
 x=[eval(str) 0 0 0 0];
elseif var=='F' | var=='W',
 if vtype(str)~=1 & vtype(str)~=2, error('Input incorrect'); end
 str=chstr(str,var);
 F=1/KlabL*(-KlabL/2:(KlabL/2-1));
 W=2*pi*F;
 x=swap(eval(str));
elseif var=='s',
 x=syst(a,b,'s');
% x=elimpz(x);
elseif var=='z',
 x=syst(a,b,'z');
% x=elimpz(x);
else
 error('Input incorrect')
end
%disp('Variable type:')
%vartype(x)


% Lasses tillägg aug. 2004:
% Efter ändring till KlabL=65536 och FSMAX=6400 Hz
% kan det vid inmatningar av typen 'exp(-10*t)*sin(t)*us(t)'
% bli så att exp(-10*t) evalueras till Inf för t<<0,
% samtidigt som us(t<<0)=0, vilket resulterar i Inf*0 = NaN
% för dessa t-värden. Nedanstående rader ersätter NaN med 0 (noll)
% Detta borde inte medföra problem/fel vid andra inmatningar!!??

x_is_NaN=find(isnan(x)==1);
x(x_is_NaN)=zeros(size(x_is_NaN));
