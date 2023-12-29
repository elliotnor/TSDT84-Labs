function H=trfcn(X,Y)
%TRFCN Beräkning av frekvensfunktioner.
%
%    H = TRFCN(X,Y) - X och Y är fouriertransformer.
%    
%    Beskrivning:
%    Beräknar frekvensfunktionen (TRanser FunCtioN) H(f) = Y(f)/X(f) alt.
%    H[theta] = Y[theta]/X[theta] för ett system vars in- och
%    utsignaler har fouriertransformerna X respektive Y. 
%    
%    Example:
%    x = in('exp(-t)*sin(2*pi*t)*us(t)','t');
%    X = foutr(x);
%    Y = lp(X,2);
%    H = trfcn(X,Y);
%    
%    Vanliga fel:
%    För de frekvenser där insignalstransformen X är lika med noll, erhålls
%    inte korrekta värden för frekvensfunktionen H! 
%    

global pm1 pm2 pm3 pm4 KlabL
if vtype(X)==5 & vtype(Y)==5,
 k=log2(Y(KlabL+1)/X(KlabL+1));
 if k>0,
  Y=ifoutr(Y);
  for i=1:k,
   Y=decim(Y);
  end
  Y=foutr(Y);
 elseif k<0,
  X=ifoutr(X);
  for i=1:-k,
   X=decim(X);
  end
  X=foutr(X);
 end
 a=find(Y(1:KlabL)==0);
 X(a)=ones(1,length(a));
 a=find(X(1:KlabL)==0);
 if length(a)>0,
  X(a)=ones(1,length(a));
  Y(a)=zeros(1,length(a));
 end
 H=[Y(1:KlabL)./X(1:KlabL) X(KlabL+1:KlabL+2)];
elseif vtype(X)==9 & vtype(X)==9,
 a=find(Y==0);
 X(a)=ones(1,length(a));
 a=find(X==0);
 if length(a)>0,
  X(a)=ones(1,length(a));
  Y(a)=zeros(1,length(a));
 end
 H=Y./X;
else
 error('Input incorrect: not Fourier transform')
end
