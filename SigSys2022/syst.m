function H=syst(T,N,var)

% SYST
%
%     SYST används av kretslabfunktionen in
%     för skapande av laplace- och/eller z-transform
%

global pm1 pm2 pm3 pm4 KlabL
if var=='s',
 vt=6;
elseif var=='z',
 vt=10;
else
 error('Input incorrect')
end
while T(1)==0 & length(T)>0,
 T=T(2:length(T));
end
while N(1)==0 & length(N)>0,
 N=N(2:length(N));
end
nn=length(T);
nd=length(N);
if nn==0 | nd==0,
 error('Input incorrect')
end
n=max(nd,nn);
H=[vt nn-1 T(1) roots(T)' zeros(1,n-nn)];
H=[H;[0 nd-1 N(1) roots(N)' zeros(1,n-nd)]];
H=elimpz(H);
