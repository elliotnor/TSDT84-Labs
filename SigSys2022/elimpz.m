function Y=elimpz(X)
% elimpz
% Y=elimpz(X) - X är laplace- eller z-transform

% Funktion & Beskrivning:
% Tar bort kancellerande poler och nollställen samt för
% samman relativt nära intilliggande enkelpoler till multipelpoler.
% Används av vissa Kretslabfunktioner.

global pm1 pm2 pm3 pm4 KlabL
xz=X(1,4:3+X(1,2));
xp=X(2,4:3+X(2,2));
yz=[];
d=0;
i=X(1,2);
while i>0,
 z=xz(1);
 a=find(abs(xp-z)<1e-4);
 if length(a)==0,
  yz=[yz z];
 else
  xp(a(1))=[];
  d=d+1;
 end
 xz(1)=[];
 i=i-1;
end
nn=X(1,2)-d;
nd=X(2,2)-d;
n=max(nd,nn);
Y=[X(1,1) nn X(1,3) yz zeros(1,n-nn)];
Y=[Y;[0 nd X(2,3) xp zeros(1,n-nd)]];

% Tillägg, Lasse Alfredsson November 2004:
% Relativt nära intilliggande enkelpoler görs till multipelpoler:

% yp=Y(2,4:3+Y(2,2)); % Polerna (efter pol-nollställeeliminering)
% i=Y(1,2); % Antal poler
% pnew=[];
% while i>0,
%  p=yp(1);
%  a=find(abs(yp-p)<1e-4); % Alla poler inom 1e-4 från p
%  pnew=[pnew p*ones(size(a))];
%  yp(a)=[];
%  i=length(yp);
% end
% Y(2,4:3+Y(2,2))=pnew;   % Uppdatera justerade poler

