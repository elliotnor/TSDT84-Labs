function pz_mod(H, range)
% PZ_MOD Ritar pol-nollst�llediagram. 
%     pz_mod �r en modifierad version av pz, d�r man anger gr�nserna p� 
%     x- och y-axel
%     
%     Exempel:
%     H =[6	0	1    0;
%         0	1	1	-1];
%     pz_mod(H, [10, 10]);
% 
% Se �ven pz

global pm1 pm2 pm3 pm4 KlabL
vh=vtype(H);
if vh==6 | vh==10,
 clf
 zero=H(1,4:3+H(1,2));
 pole=H(2,4:3+H(2,2));
 nz=num2str(H(1,2));
 np=num2str(H(2,2));
 zre=max(abs(real(zero)));
 zim=max(abs(imag(zero)));
 pre=max(abs(real(pole)));
 pim=max(abs(imag(pole)));
 if isempty(range), range=1; end
  if vh==10,
  range=max(1,range);
  t=0:.01:2*pi;
  circ=plot(sin(t),cos(t));
  set(circ,'color',.8*[1 1 1]);
  axis([-1.3*range 1.3*range -1.3*range 1.3*range]);
 else
  plot([0 0],[0 0])
  axis([-range(1) range(1) -1.15*range(2) 1.15*range(2)]);
 end
% axis;
 grid
 hold on
 if length(zero)>0,
  while length(zero)>0
   plot(real(zero(1)),imag(zero(1)),'ob','MarkerSize',16);
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
   plot(real(pole(1)),imag(pole(1)),'xr','MarkerSize',18);
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
  K = H(1,3)/H(2,3);
 if abs(K)>999
     Kstr=num2str(K,'%.5g');    % 5 v�rdesiffror
 else
     Kstr=num2str(K,'%.2f');    % 2 decimaler
 end
 xlabel(['K= ' Kstr '    # of zeros: ' nz '    # of poles: ' np])
 axis('square')
 
    % Till�gg juni 2017: Rita realaxeln & imagin�ra axeln
   
  pzax = axis;
  line([pzax(1) pzax(2)], [0 0],'color',[0 0 0])
  line([0 0], [pzax(3) pzax(4)],'color',[0 0 0])
  hold off

   
 hold off
else
 error('Input incorrect: not Laplace- or z-transform')
end
shg