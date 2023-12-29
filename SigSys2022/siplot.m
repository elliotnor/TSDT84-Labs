function siplot(x,tmax)
%siplot
% siplot används lokal av Kretslabfunktionen signal

global pm1 pm2 pm3 pm4 KlabL
msize1=6;	% Markersize, Changed marker by Lasse A. 980721
msize2=18;	% Use prefferably markersize=18. 6 is too small(?)

vx=vtype(x);
if vx==4,       % time continuous signal

 t=x(KlabL+1)*(-KlabL/2:(KlabL/2-1));
 % if nargin==1, tmax=x(KlabL+1)*KlabL/2; end  %Lars-Eriks tmax
 if nargin==1, % Lasses tmax, aug.2004
     xpos=x(KlabL/2+1:KlabL);   % x(t>=0)
     xneg=x(KlabL/2+1:-1:2);    % x(t<=0), length(xpos)=length(xneg)
     xmax=max(abs(x(1:KlabL)));     
     xposmore=find(abs(xpos) > xmax/50); 
     if isempty(xposmore), xposmore=1; end  % om x(t>=0) = 0
     xnegmore=find(abs(xneg) > xmax/50); 
     if isempty(xnegmore), xnegmore=1; end  % om x(t<=0) = 0
     tmax=min(t(KlabL),t(KlabL/2+max(xposmore(length(xposmore)),xnegmore(length(xnegmore))))*1.5);
 end 
 a=find(abs(t)<=tmax);
 % keyboard
 plot(t(a),x(a))
 axis([-tmax tmax 1.1*min(x(1:KlabL)) 1.1*max(x(1:KlabL))])
 xlabel('Tid t  [s]')
 grid
elseif vx==7, % 'signal' on a fourier serie
 T=1/x(513);
 if nargin==1, tmax=2; end
 t=T*tmax/512*(0:511);
 v=real(ifft(512*x(1:512)));
 x=[];

% Lasse A's comments:
% -------------------
% The following may not work so well on signals which only contain
% very high frequency components.
% In such a situation, the result will be like a envelop detector.
% The right signal is be plotted correctly if an *odd* number of periods
% are plotted.
% NOTE: Here, 'tmax' equals the number of *periods* that are to be plotted.
% -------------------------------------------------------------------------
 for i=1:tmax, x=[x v(rem(i*512,tmax)+1:tmax:512)]; end
 d=(max(x)-min(x))/2;
 e=(max(x)+min(x))/2;
 plot(t,x)
 axis([0 t(length(t)) e-1.1*d e+1.1*d]);
 xlabel('Tid  [s]')
 grid
elseif vx==8,
 if nargin==1, tmax=128; end
 if tmax>KlabL/2, tmax=KlabL/2; end
 t=-KlabL/2:(KlabL/2-1);
 a=find(abs(t)<=tmax);
 dotpl=plot(t(a),x(a),'.');
 set(dotpl,'MarkerSize',msize2)
hold on
 for i=a,
  plot([t(i) t(i)],[0 x(i)])
 end
 hold off
 xlabel('Sampelnummer n')
 grid
else
 error('Fel input - ingen signal')
end
shg



