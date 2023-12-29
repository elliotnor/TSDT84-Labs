function h=firwin(N,F0,wd)
%FIRWIN Beräkning av kausalt FIR-filter av LP-typ med fönstermetoden.
%
%    h = FIRWIN(L,theta_c,typ) - L är reellt heltal, theta_c är reellt tal och
%                              typ är en text.
%    
%    Beskrivning:
%    Beräknar impulssvaret för ett FIR-filter av längd L genom att utgå från 
%    ett idealt LP-filter med normerad gränsfrekvens theta_c och sedan fönstra 
%    detta. Fönstertypen anges med textsträngen typ, vilken skall omges av 
%    apostrofer. Tillgängliga fönstertyper finns i beskrivningen av kommandot 
%    window. Fönstringen sker symmetriskt runt n = (L-1)/2.
%    
%    Example:
%    h = firwin(21,0.2,'hann');
%    
%    See also:
%    WINDOW
%    

global pm1 pm2 pm3 pm4 KlabL
if N>KlabL/2, N=KlabL/2; end
n=floor(N/2);
n=-n:n;
if length(n)~=N,
 n(1)=[];
 n=n-.5;
end
h=fir(sinc(2*F0*n)*2*F0);
if nargin==3, h=window(h,wd,N); end
