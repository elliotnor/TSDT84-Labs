function Y=output(U,H)
%OUTPUT Filtrering.
%
%    y = OUTPUT(x,h)  - x och h är signaler.
%    Y = OUTPUT(X,H)  - X och H är fourier-, laplace- eller z-transformer.
%    D = OUTPUT(C,H)  - C är fourierserie, H är laplacetransform.
%    D = OUTPUT(C,Hf) - C är fourierserie, Hf är fouriertransform, uttryckt 
%                     som funktion av frekvensen f (se exemplet nedan).
%    
%    Beskrivning:
%    Varianten y = OUTPUT(x,h) beräknar utsignalen från ett LTI-system med insignal 
%    x och impulssvar h ( y(t) = (x*h)(t) alt. y[n] = (x*h)[n] där "*"  =  faltning).
%     
%    För varianten Y = OUTPUT(X,H) (exempelvis Y(s) = X(s)H(s), Y[theta] = X[theta]H[theta])
%    är det tillåtet att blanda fourier- och laplacetransformer resp. fourier- och 
%    z-transformer. Resultatet Y blir då en fouriertransform. 
%    Om laplacetransform används för att beskriva systemet kan även icke bandbegränsade 
%    filter användas, så länge insignalen är bandbegränsad till max 3200 Hz.
%    
%    Example:
%    x = in('exp(-t)*sin(2*pi*t)*us(t)','t');
%    h = ilaptr(butterw(3));
%    y = output(x,h);
%    
%    H = butterw(3);
%    C = fouser('pulse(t,0,1)',5);
%    D = OUTPUT(C,H);
%    E = OUTPUT(C,'1+1/(1+j*2*f)');
%    
%    See also:
%    LP, HP, BP, BS, TRFCN
%    

global pm1 pm2 pm3 pm4 KlabL
disp('Jobbar lite...');
vu=vtype(U);
vh=vtype(H);
if vu==4 & vh==4,
 vy=4;
elseif vu==5 & vh==5,
 vy=5;
elseif vu==6 & vh==6,
 Nu=U(1,3)*poly(U(1,4:3+U(1,2)));
 Du=U(2,3)*poly(U(2,4:3+U(2,2)));
 Nh=H(1,3)*poly(H(1,4:3+H(1,2)));
 Dh=H(2,3)*poly(H(2,4:3+H(2,2)));
 Y=syst(conv(Nu,Nh),conv(Du,Dh),'s');
 vy=6;
elseif vu==5 & vh==6,
 w=j*2*pi*U(KlabL+2)*(-KlabL/2:(KlabL/2-1));
 Nh=H(1,3)*poly(H(1,4:3+H(1,2)));
 Dh=H(2,3)*poly(H(2,4:3+H(2,2)));
 H=polyval(Nh,w)./polyval(Dh,w);
 w=[];
 H=[H(KlabL/2+1:KlabL) H(1:KlabL/2) U(KlabL+1) U(KlabL+2)];
 vy=5;
elseif vu==6 & vh==5,
 w=j*2*pi*H(KlabL+2)*(-KlabL/2:(KlabL/2-1));
 Nu=U(1,3)*poly(U(1,4:3+U(1,2)));
 Du=U(2,3)*poly(U(2,4:3+U(2,2)));
 U=polyval(Nu,w)./polyval(Du,w);
 w=[];
 U=[U(KlabL/2+1:KlabL) U(1:KlabL/2) H(KlabL+1) H(KlabL+2)];
 vy=5;
elseif vu==7 & vh==2,
 H=chstr(H,'f');
 f=U(513)*(-256:255);
 w=2*pi*f;
 H=eval(H);
 f=[];
 w=[];
 H=[H(257:512) H(1:256)];
 Y=[U(1:512).*H(1:512) U(513:515)];
 vy=7;
elseif vu==7 & vh==6,
 w=j*2*pi*U(513)*(-256:255);
 Nh=H(1,3)*poly(H(1,4:3+H(1,2)));
 Dh=H(2,3)*poly(H(2,4:3+H(2,2)));
 H=polyval(Nh,w)./polyval(Dh,w);
 w=[];
 H=[H(257:512) H(1:256)];
 Y=[U(1:512).*H(1:512) U(513:515)];
 vy=7;
elseif vu==8 & vh==8,
 vy=8;
elseif vu==9 & vh==9,
 vy=9;
elseif vu==10 & vh==10,
 Nu=U(1,3)*poly(U(1,4:3+U(1,2)));
 Du=U(2,3)*poly(U(2,4:3+U(2,2)));
 Nh=H(1,3)*poly(H(1,4:3+H(1,2)));
 Dh=H(2,3)*poly(H(2,4:3+H(2,2)));
 Y=syst(conv(Nu,Nh),conv(Du,Dh),'z');
 vy=10;
elseif vu==9 & vh==10,
 w=exp(j*2*pi/KlabL*(0:KlabL-1));
 Nh=H(1,3)*poly(H(1,4:3+H(1,2)));
 Dh=H(2,3)*poly(H(2,4:3+H(2,2)));
 H=polyval(Nh,w)./polyval(Dh,w);
 w=[];
 vy=9;
elseif vu==10 & vh==9,
 w=exp(j*2*pi/KlabL*(0:KlabL-1));
 Nu=U(1,3)*poly(U(1,4:3+U(1,2)));
 Du=U(2,3)*poly(U(2,4:3+U(2,2)));
 U=polyval(Nu,w)./polyval(Du,w);
 w=[];
 vy=9;
else
 error('Fel input')
end
if vy==5,
 K=U(KlabL+1);
 U=conj(U(1:KlabL));
 U=fft(U);
 U=K/KlabL*conj(U);
 U=real(U);
 U=[U(KlabL/2+1:KlabL) U(1:KlabL/2) 1/K];
 K=H(KlabL+1);
 H=conj(H(1:KlabL));
 H=fft(H);
 H=K/KlabL*conj(H);
 H=real(H);
 H=[H(KlabL/2+1:KlabL) H(1:KlabL/2) 1/K];
elseif vy==9,
 U=conj(U(1:KlabL));
 U=fft(U);
 U=conj(U)/KlabL;
 U=real(U);
 U=[U(KlabL/2+1:KlabL) U(1:KlabL/2) 0 0 0 0];
 H=conj(H(1:KlabL));
 H=fft(H);
 H=conj(H)/KlabL;
 H=real(H);
 H=[H(KlabL/2+1:KlabL) H(1:KlabL/2) 0 0 0 0];
end
if vy~=6 & vy~=7 & vy~=10,
 if vy==4 | vy==5,
  K=log2(U(KlabL+1)/H(KlabL+1));
  if K>0,
   H=[zeros(1,KlabL/4) H(1:2:KlabL) zeros(1,KlabL/4) 2*H(KlabL+1)];
   K=K-1;
  end
  if K>0,
   for i=1:K,
    T=U(KlabL+1)/2;
    U(1:2:KlabL)=U(.25*KlabL+1:.75*KlabL);
    U(2:2:KlabL)=zeros(1,KlabL/2);
    U=[U(KlabL/2+1:KlabL) zeros(1,KlabL) U(1:KlabL/2)];
    U=fft(U);
    U=[U(1:KlabL/2) zeros(1,KlabL) U(1.5*KlabL+1:2*KlabL)];
    U=conj(U);
    U=fft(U);
    U=conj(U)/KlabL;
    U=real(U);
    U=[U(1.5*KlabL+1:2*KlabL) U(1:KlabL/2) T];
   end
  elseif K<0,
   U=[zeros(1,KlabL/4) U(1:2:KlabL) zeros(1,KlabL/4) 2*U(KlabL+1)];
   K=K+1;
   if K<0,
    for i=1:-K,
     T=H(KlabL+1)/2;
     H(1:2:KlabL)=H(.25*KlabL+1:.75*KlabL);
     H(2:2:KlabL)=zeros(1,KlabL/2);
     H=[H(KlabL/2+1:KlabL) zeros(1,KlabL) H(1:KlabL/2)];
     H=fft(H);
     H=[H(1:KlabL/2) zeros(1,KlabL) H(1.5*KlabL+1:2*KlabL)];
     H=conj(H);
     H=fft(H);
     H=conj(H)/KlabL;
     H=real(H);
     H=[H(1.5*KlabL+1:2*KlabL) H(1:KlabL/2) T];
    end
   end
  end 
  K=U(KlabL+1);
  U=[U(KlabL/2+1:KlabL) zeros(1,KlabL) U(1:KlabL/2)];
  U=K*fft(U);
  H=[H(KlabL/2+1:KlabL) zeros(1,KlabL) H(1:KlabL/2)];
  H=fft(H);
  Y=U.*H;
  U=[];
  H=[];
  Y=conj(Y);
  Y=fft(Y);
  Y=conj(Y)/KlabL/2;
  Y=real(Y);
  Y=[Y(1.5*KlabL+1:2*KlabL) Y(1:KlabL/2) K];
  if vy==5,
   Y=[K*fft([Y(KlabL/2+1:KlabL) Y(1:KlabL/2)]) 1/K 1/K/KlabL];
  end
 else
  U=[U(KlabL/2+1:KlabL) zeros(1,KlabL) U(1:KlabL/2)];
  U=fft(U);
  H=[H(KlabL/2+1:KlabL) zeros(1,KlabL) H(1:KlabL/2)];
  H=fft(H);
  Y=U.*H;
  U=[];
  H=[];
  Y=conj(Y);
  Y=fft(Y);
  Y=conj(Y)/KlabL/2;
  Y=real(Y);
  Y=[Y(1.5*KlabL+1:2*KlabL) Y(1:KlabL/2) 0 0 0 0];
  if vy==9,
   Y=[fft([Y(KlabL/2+1:KlabL) Y(1:KlabL/2)])];
  end
 end
end
disp('Utsignalsform: ')
vartype(Y)
