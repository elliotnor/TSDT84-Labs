function D=fouser(u,To,fi,TT)
%FOUSER Definition av fourierserier.
%
%    D = FOUSER(uttryck,To) - uttryck är text och To är reellt tal.
%    D = FOUSER(Co,uttryck1,uttryck2,To) - Co och To är reella tal, 
%                                        uttryck1 och uttryck2 är text.
%    
%    Beskrivning:
%    I det första fallet beräknas den komplexa fourierserieutvecklingen Dn för 
%    en periodisk tidssignal med periodtid To. Tidssignalen anges som textsträngen 
%    uttryck, som beskriver det matematiska uttrycket som funktion av t i 
%    tidsintervallet 0 <= t < To. Textsträngen skall omges av apostrofer.
%
%    I det andra fallet beräknas den komplexa fourierserieutvecklingen Dn då den
%    periodiska signalen är given som en fourierserieutveckling med cosinussignaler;
%    Co+summa{Cn*cos((2*pi/To)*n*t+fi_n)}; n=1:inf. Argumenten uttryck1 och uttryck2 
%    är textsträngar som beskriver Cn resp. fi_n som matematiska funktioner av n. 
%    Textsträngarna skall omges av apostrofer. 
%    Funktionen beräknar 256 fourierkoefficienter.
%    
%    Example:
%    D = fouser('pulse(t,0,0.5)',1);
%    signal(D);
%    spect(D);
%    D = fouser(1,'1/n','atan(n)',1); 
%    
%    Vanliga fel:
%    De matematiska uttrycken får bara innehålla variablerna t (uttryck) respektive 
%    n (uttryck1 och uttryck2). Exempelvis funkerar *inte*
%    A = 5; D = FOUSER('A*pulse(t,0,0.5)',1);
%    eftersom kommandot fouser använder lokala variabler, och 
%    alltså inte hittar variabeln A när uttrycket skall beräknas. Använd i 
%    stället någon av de fyra fördefinierade globala variablerna pml...pm4.
%    
%    Ett annat vanligt fel är att man beskriver tidssignalen i fel tidsintervall.
%    Observera att i fallet D = FOUSER(uttryck,To) skall uttryck beskriva tidssignalen
%    från t = 0 till t = To!
%    
%    See also:
%    REMTONE, SIGNAL, SPECT, IN, SAMPLE 
%    

global pm1 pm2 pm3 pm4 KlabL
if nargin==2,
 t=To/512*(0:511);
 u=eval(chstr(u,'t'));
 U=1/512*fft(u);
 D=[U 1/To 0 0];
end
if nargin==4,
 D=zeros(1,515);
 D(513)=1/TT;
 D(1)=u;
 n=1:256;
 A=eval(chstr(To,'n'));
 V=eval(chstr(fi,'n'));
 D(2:257)=0.5*A.*cos(V)+j*0.5*A.*sin(V);
% D(2:257)=0.5*A.*sin(V)-j*0.5*A.*cos(V);
 A=A(256:-1:1);
 V=V(256:-1:1);
 D(257:512)=0.5*A.*cos(V)-j*0.5*A.*sin(V);
% D(257:512)=0.5*A.*sin(V)+j*0.5*A.*cos(V);
end

 
