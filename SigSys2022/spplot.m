function spplot(U,n,fmax)
% spplot
% Funktionen används lokalt av spect

global pm1 pm2 pm3 pm4 KlabL FSMAX
msize1=6;	% Markersize, Changed marker by Lasse A. 970824
msize2=18;

vu=vtype(U);
if vu==7,
 if nargin<3, fmax=30; end
 if fmax>255, fmax=255; end
 A=[real(U(1)) 2*abs(U(2:fmax+1))];
 dotpl=plot(0,A(1),'.');
 set(dotpl,'MarkerSize',msize2)
 axis([0 fmax 1.1*min([A 0]) 1.1*max([A 0])])
 %axis;
 hold on
 for i=1:fmax+1,
  dotpl=plot(i-1,A(i),'.');
  set(dotpl,'MarkerSize',msize2)
  plot([i-1 i-1],[A(i) 0])
 end
 grid
 title(['Grundtonens frekvens: ' num2str(U(513)) ' Hz'])
 xlabel('Delton nr')
 ylabel('Amplitud')
 hold off
 if n==2,
  fi=180/pi*(angle(U(1:fmax+1)));   % vid cos-serie
%  fi=180/pi*(pi/2+angle(U(1:fmax+1)));  % vid sin-serie
  a=find(fi>180);
  fi(a)=fi(a)-360;
  a=find(A==0);
  fi(a)=zeros(size(a));
  fi=fi(2:length(fi));
  subplot(2,1,2)
  dotpl=plot(1,fi(1),'.');
  set(dotpl,'MarkerSize',msize2)
  axmin=1.1*min([fi 0]);
  axmax=1.1*max([fi 0]);
  if axmin==axmax, axmin=-90; axmax=90; end
  axis([0 fmax axmin axmax])
%  axis;
  hold on
  for i=1:fmax,
   dotpl=plot(i,fi(i),'.');
   set(dotpl,'MarkerSize',msize2)
   plot([i i],[fi(i) 0])
  end
  grid
  xlabel('Delton nr')
  ylabel('Fas')
  hold off
 end
elseif vu==11,
 if nargin<3, fmax=U(129); end
 if fmax>U(129), fmax=U(129); end
 A=abs(U(1:fmax));
 if n==2, subplot(2,1,1); end
 dotpl=plot(0:fmax-1,A,'.');
 set(dotpl,'MarkerSize',msize2)
 axis([0 fmax 1.1*min([A 0]) 1.1*max([A 0])])
%axis;
 hold on
 for i=1:fmax,
  plot([i-1 i-1],[A(i) 0])
 end
 hold off
 grid
 xlabel('Punkt nummer')
 ylabel('Amplitud')
 if n==2,
  fi=180/pi*angle(U(1:fmax));
  a=find(fi>180);
  fi(a)=fi(a)-360;
  subplot(2,1,2)
  dotpl=plot(0:fmax-1,fi,'.');
  set(dotpl,'MarkerSize',msize2)
  axis([0 fmax 1.1*min([fi 0]) 1.1*max([fi 0])])
%  axis;
  hold on
  for i=1:fmax,
   plot([i-1 i-1],[fi(i) 0])
  end
  hold off
  grid
  xlabel('Punkt nummer')
  ylabel('Fas')
 end
else
 if vu==5,              % Fouriertransform av tidskontinuerlig signal
  f=U(KlabL+2)*(0:(KlabL/2-1));
  if nargin==2, fmax=U(KlabL+1)/2; end
  if fmax>U(KlabL+1)/2, fmax=U(KlabL+1)/2; end
 elseif vu==6,
  if nargin<3, fmax=bandwi(U); end
  if fmax==inf, fmax=FSMAX/2; end
  f=(0:512)*fmax/512;
  Ut=U(1,3)*poly(U(1,4:3+U(1,2)));
  Un=U(2,3)*poly(U(2,4:3+U(2,2)));
  U=polyval(Ut,j*2*pi*f)./polyval(Un,j*2*pi*f);
 elseif vu==9,
  f=(1/KlabL)*(0:(KlabL/2-1));
  if nargin==2, fmax=.5; end
  if fmax>.5, fmax=.5; end
 elseif vu==10,
  if nargin<3, fmax=.5; end
  if fmax>.5, fmax=.5; end
  f=(0:512)/1024;
  Ut=U(1,3)*poly(U(1,4:3+U(1,2)));
  Un=U(2,3)*poly(U(2,4:3+U(2,2)));
  U=polyval(Ut,exp(j*2*pi*f))./polyval(Un,exp(j*2*pi*f));
 end
 b=find(f<=fmax);
 plot(f(b),abs(U(b)))
 Umax=max(abs(U(b)));   % Tillägg Lasse augusti 2004
 if ~isnan(Umax), set(gca,'ylim',[0 Umax*1.1]), end % Tillägg Lasse augusti 2004
 grid
 title('Amplitudkaraktäristik (eller -spektrum)')
 % ylabel('Magnitude')
 if vu==5 | vu==6,
  xlabel('Frekvens  [Hz]')
 else
  xlabel('Normerad frekvens')
 end
 
 if n==2,
  fi=180/pi.*angle(U(b));
  a=find(fi>0);
  fi(a)=fi(a)-360;
  subplot(2,1,2)
  plot(f(b),fi), 
  grid
  ylabel('Fas')
  if vu==5 | vu==6,
   xlabel('Frekvens  [Hz]')
  else
   xlabel('Normerad frekvens')
  end
 end
end
shg





