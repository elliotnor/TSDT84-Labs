function H=butterw(n)
%BUTTERW Butterworthfilter.
%
%    H = BUTTERW(n) - n är positivt heltal.
%    
%    Beskrivning:
%    Beräknar systemfunktionen för ett tidskontinuerligt butterworthfilter 
%    av LP-typ, med gränsfrekvens 1 Hz och gradtal n.
%    

global pm1 pm2 pm3 pm4 KlabL
if n/2==round(n/2),
 i=0:n/2-1;
 pole=exp(j*pi*(1-.5/n-i/n));
else
 i=1:n/2;
 pole=[-1 exp(j*pi*(1-i/n))];
end
H=in(1,1,'s');
H=addpo(H,2*pi*pole);
H=normal(H,0);
