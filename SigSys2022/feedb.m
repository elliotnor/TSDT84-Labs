function H=feedb(H1,H2,K)
%FEEDB Återkopplar system.
%
%    G = FEEDB(H1,H2) - H1 och H2 är laplace- eller z-transformer.
%    G = FEEDB(H1,H2,K) - H1 och H2 är laplace- eller z-transformer, 
%                       K är ett reellt tal.
%    
%    Beskrivning:
%    Ger den totala systemfunktionen för systemet Hl återkopplat 
%    med systemet K*H2 (obs: negativ återkoppling), 
%    dvs G  =  H1/(1+K*H1*H2). Om K utelämnas sätts den till 1.
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(H1)==6 & vtype(H2)==6,
 if nargin<3, K=1; end
 N1=H1(1,3)*poly(H1(1,4:3+H1(1,2)));
 D1=H1(2,3)*poly(H1(2,4:3+H1(2,2)));
 N2=H2(1,3)*poly(H2(1,4:3+H2(1,2)));
 D2=H2(2,3)*poly(H2(2,4:3+H2(2,2)));
 N=conv(N1,D2);
 Da=conv(D1,D2);
 Db=K*conv(N1,N2);
 na=length(Da);
 nb=length(Db);
 n=max(na,nb);
 D=[zeros(1,n-na) Da]+[zeros(1,n-nb) Db];
 H=syst(N,D,'s');
 H=elimpz(H);
elseif vtype(H1)==10 & vtype(H2)==10,
 if nargin<3, K=1; end
 N1=H1(1,3)*poly(H1(1,4:3+H1(1,2)));
 D1=H1(2,3)*poly(H1(2,4:3+H1(2,2)));
 N2=H2(1,3)*poly(H2(1,4:3+H2(1,2)));
 D2=H2(2,3)*poly(H2(2,4:3+H2(2,2)));
 N=conv(N1,D2);
 Da=conv(D1,D2);
 Db=K*conv(N1,N2);
 na=length(Da);
 nb=length(Db);
 n=max(na,nb);
 D=[zeros(1,n-na) Da]+[zeros(1,n-nb) Db];
 H=syst(N,D,'z');
 H=elimpz(H);
else
 error('Input incorrect: not Laplace- or z-transform')
end

