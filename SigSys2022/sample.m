function u=sample(str,fs)
%SAMPLE Sampling av signaler.
%
%    x = SAMPLE(uttryck,fs) - uttryck är text, fs är reellt tal.
%    
%    Beskrivning:
%    Samplar en signal med sampelfrekvensen fs. Signalen ges som textsträngen 
%    uttryck, innehållande det matematiska uttrycket som funktion av t. 
%    Textsträngen skall omges av apostrofer.
%    
%    Example:
%    x = sample('exp(-t)*sin(2*pi*t)*us(t)',10);
%    
%    Vanliga fel:
%    En tidskontinuerlig signal inmatad med funktionen in kan inte samplas, 
%    eftersom den i själva verket redan är samplad.
%    I exemplet ovan kan man alltså INTE mata in x som
%        xs = in('exp(-t)*sin(2*pi*t)*us(t)','t');
%        x = SAMPLE(x,10);
%        
%    Man kan inte heller använda lokala variabler i argumentet uttryck, 
%    eftersom funktionen sample inte kommer åt sådana variabler.
%    Man kan alltså INTE mata in enligt följande:
%    	A = 5;    
%        x = SAMPLE('A*exp(-t)*us(t)',10);
%    Använd i stället någon av de fyra fördefinierade globala 
%    kretslab variablerna pm1...pm4.
%    
%    See also:
%    IN, PAM
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(str)~=1 & vtype(str)~=2, error('Input incorrect'); end
str=chstr(str,'t');
T=1/fs;
t=T*(-KlabL/2:(KlabL/2-1));
u=[eval(str) 0 0 0 0];

% Samma tillägg som i slutet av in.m, för att eliminera NaN:
u_is_NaN=find(isnan(u)==1);
u(u_is_NaN)=zeros(size(u_is_NaN));

