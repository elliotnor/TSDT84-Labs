function Hd=bilintr(Hc,fc,Fc)
%BILINTR Bilinjär transformation.
%
%    G = BILINTR(H,fc,theta_c) - H är laplacetransform, fc och theta_c är reella tal.
%    G = BILINTR(H,gamma) - H är laplacetransform, gamma är reellt tal.
%    
%    Beskrivning:
%    Systemfunktionen H(s) transformeras till en systemfunktion G[z] med 
%    transformationen s = gamma*(z-1)/(z+1). Om fc och theta_c anges beräknas 
%    gamma så att frekvensen fc motsvaras av normerade frekvensen theta_c.
%    I detta fall normeras också G så att båda filtren får samma 
%    förstärkning vid fc respektive theta_c.
%    
%    Example:
%    H = butterw(3);
%    G = bilintr(H,1,0.2);
%    G2 = bilintr(H,0.5);
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(Hc)~=6, error('Input incorrect, not a Laplace transform'); end
if Hc(1,2)>Hc(2,2), error('Too many zeros'); end
if nargin==2, K=fc; end
if nargin==3, K=2*pi*fc/tan(pi*Fc); end
zc=Hc(1,4:3+Hc(1,2));
pc=Hc(2,4:3+Hc(2,2));
zd=[(1+zc/K)./(1-zc/K) -ones(1,Hc(2,2)-Hc(1,2))];
pd=(1+pc/K)./(1-pc/K);
Hd=[10 0 1;0 0 1];
Hd=addze(Hd,zd);
Hd=addpo(Hd,pd);
%if nargin==3,
% Kc=abs(polyval(poly(zc),j*2*pi*fc)/polyval(poly(pc),j*2*pi*fc));
% Kd=abs(polyval(poly(zd),exp(j*2*pi*Fc))/polyval(poly(pd),exp(j*2*pi*Fc)));
% if Kd~=0, Hd(1,3)=Hc(1,3)/Hc(2,3)*Kc/Kd; end
%end
%
% The following is added, instead of the above commented, to get the same
% magnitude for Hd as for Hc:
t=poly(Hc(1,4:3+Hc(1,2)));
n=poly(Hc(2,4:3+Hc(2,2)));
Hd(1,3)=Hc(1,3)/Hc(2,3)*polyval(t,K)/polyval(n,K);
