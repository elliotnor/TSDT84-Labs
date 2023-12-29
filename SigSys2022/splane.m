function splane(H, RE)
%SPLANE Plottning av belopp av laplacetransformer.
%
%    SPLANE(X,RE) - X är laplacetransform.
%    
%    Beskrivning:
%    Plottar absolutbeloppet av X(s) i ett område i vänster halvplan 
%    i s-planet. Imaginära axeln ligger på den kant av plotten som är vänd 
%    mot betraktaren - där är |X(w)| ritad i rött.
%    En nollreferens är inlagd och poler och nollställen är markerade i s-planet.
%    Plotten kan vridas genom att "dra" i plotten med musen!
%
%    Om RE ingår i anropet så bestämmer den hur REaldelen av 
%    det ritade området kan ändras:  
%          RE = 1 (default) => Området är kvadratiskt (bestäms av polernas imaginärdel)  
%          RE > 1 => realdelen skalas med faktorn RE (default/RE) 
%
%    Example:
%    H = butterw(3);
%    splane(H)
%    
%    See also:
%    ZPLANE
   
% (c) Lasse Alfredsson

global pm1 pm2 pm3 pm4 KlabL 
if vtype(H)~=6, error('Fel input: Ingen laplacetransform'); end
if max(real(po(H)))>0, error('Poler i höger halvplan'); end
clf
hold on
for i=1:H(1,2),
 plot(real(H(1,3+i)),imag(H(1,3+i)),'ob','Markersize',12,'linewidth',2);
end
for i=1:H(2,2),
 plot(real(H(2,3+i)),imag(H(2,3+i)),'xr','Markersize',16,'linewidth',2);
end
imm=max(abs(po(H)))*2;
if isempty(imm), imm=max(abs(ze(H)))*2; end  % Om inga poler i H
if imm==0, imm=bandwi(H)*pi; end
if imm==inf, imm=200*pi; end
RElim = 2*imm;
if nargin == 2, RElim = RElim/RE; end
x=0:-imm/30:-RElim;
y=-imm:imm/40:imm;
[re,im]=meshgrid(x,y);
s=re+j*im;
N=H(1,3)*poly(H(1,4:3+H(1,2)));
D=H(2,3)*poly(H(2,4:3+H(2,2)));
pts=polyval(N,s)./polyval(D,s);
cut=5*max(abs(pts(:,1)));
if cut==inf, cut=5; end
pts=min(cut*ones(size(pts)),abs(pts));
% pts=[zeros(size(pts(:,1))) pts];  % Behovs ej langre - axlarna ar graderade !!
surfc(x,y,pts)
axis([-RElim 0  -imm imm 0 cut/2])
v=25;
h=60;
view(h,v)
xlabel('Re\{s\}')
ylabel('Im\{s\}')
zlabel('Amplitud')





tt = uicontrol('style','text','units','normal','position',[.012 .94 .25 .04], ...
	'string','Zaxelns maxvärde:','fore','red','back',get(gcf,'color'),'horizontal','left','fontsize',14);

limz = uicontrol('Style','edit','Units','normalized', ...
       'Position',[0.012 .9 .08 .04],'String',num2str(cut/2),'CallBack', ...
       'TEMAXIS=axis; axis([TEMAXIS(1:5) str2num(get(get(gcf,''currentobject''),''string''))]); clear TEMAXIS;', ...
       'foreground','black','background','yellow','horizontal','left','fontsize',14);

title('Använd musen för att rotera grafen!','fontsize',12)

rotate3d on % Möjliggör rotering av plotten med musen
ohfig

% Rita |H(w)|
plot3(zeros(size(y)),y,pts(:,1),'linewidth',4,'color','red')
% Egentligen är det lämpligt att även ha axis('square'), eftersom området 
% i s-planet är kvadratiskt, men då blir grafen så liten
hold off

POS = get(gcf,'position');
POS(3:4) = [770 700];
set(gcf,'position',POS);
