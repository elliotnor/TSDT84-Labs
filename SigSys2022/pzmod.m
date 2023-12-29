function pzmod(H)
%PZMOD Ritar pol-nollställediagram
%   pzmod(H) är en modifierad version av pz(H) 
%   pzmod tömmer inte skärmen först, samt gör inte axis('square') 
%
%   See also pz


global pm1 pm2 pm3 pm4 KlabL
vh=vtype(H);
if vh==6 | vh==10,
%  clf				% Ar med i PZ
 zero=H(1,4:3+H(1,2));
 pole=H(2,4:3+H(2,2));
 nz=num2str(H(1,2));
 np=num2str(H(2,2));
 zre=max(abs(real(zero)));
 zim=max(abs(imag(zero)));
 pre=max(abs(real(pole)));
 pim=max(abs(imag(pole)));
 range=1.1*max([zre zim pre pim]);
 if isempty(range), range=1; end
  if vh==10,
  range=max(1,range);
  t=0:.01:2*pi;
  plot(sin(t),cos(t))
  axis([-1.3*range 1.3*range -1.3*range 1.3*range]);
 else
  plot([0 0],[0 0])
  axis([-range range -1.15*range 1.15*range]);
 end
% axis;
 grid
 if ~ishold, hold on, end
 if length(zero)>0,
  while length(zero)>0
   plot(real(zero(1)),imag(zero(1)),'ob','MarkerSize',6);
   a=1;
   for b=length(zero):-1:2,
    if abs(zero(b)-zero(1))<1e-4,
     a=a+1;
     zero(b)=[];
    end
   end
   if a>1, 
    text(real(zero(1)),imag(zero(1)),[' (' int2str(a) ')'],'color','b'),
   end
   zero(1)=[];
  end
 end
 if length(pole)>0,
  while length(pole)>0,
   plot(real(pole(1)),imag(pole(1)),'xr','MarkerSize',8,'EraseMode','xor');
   a=1;
   for b=length(pole):-1:2,
    if abs(pole(b)-pole(1))<1e-4,
     a=a+1;
     pole(b)=[];
    end
   end
   if a>1, 
    text(real(pole(1)),imag(pole(1)),[' (' int2str(a) ')'],'color','r'),
   end
   pole(1)=[];
  end
 end
 K=num2str(H(1,3)/H(2,3));
 xlabel(['K= ' K '    # of zeros: ' nz '    # of poles: ' np])
% axis('square')		% Ar med i PZ
 %hold off
else
 error('Input incorrect: not Laplace- or z-transform')
end
