function spect(X,Y,fmax)
%SPECT Plottning av frekvensspektrum/-karaktäristik.
%
%    SPECT(X)        - X är fourier-, laplace- eller z-transform eller DFT.
%    SPECT(X,Y)      - X och Y är fourier-, laplace- eller z-transformer
%                      eller DFT:er.
%    SPECT(X,fmax)   - X är fourier-, laplace- eller z-transform, 
%                      fmax är reellt tal.
%    SPECT(X,Y,fmax) - X och Y är fourier-, laplace- eller z-transformer, 
%                      fmax är reellt tal.
%    SPECT(D)          - D är fourierserie.
%    SPECT(D1,D2)      - D1 och D2 är fourierserier.
%    SPECT(D,nmax)     - D är fourierserie, nmax är positivt heltal.
%    SPECT(C1,D1,nmax) - D1 och D2 är fourierserier, nmax är positivt heltal.
%    
%    Beskrivning:
%    Plottar (dubbelsidigt) amplitud- och fasspektrum för en transform eller 
%    amplitudspektrum för två transformer. För laplace- och z-transformer 
%    beräknas värdena på imaginära axeln resp. på enhetscirkeln. 
%    fmax kan användas för att definiera önskad maxfrekvens i det ritade 
%    frekvensintervallet. 
%
%    Om X eller Y är frekvensfunktion eller systemfunktion är det motsvarande
%    amplitud- och fasKARAKTÄRISTIK som plottas.
%
%    Funktionen plottar även ENKELSIDIGT amplitud- och fasspektrum för 
%    fourierserier och DFT:er. 
%    Spektrum kan, för fourierserier, ritas upp till delton nmax.
%    
%    Exempel:
%    X = in('1/(1+j*w)','w');
%    spect(X)
%    
%    H = butterw(3);
%    SPECT(H,5)
%    
%    Se även:
%    PWRSPECT, LOGSPECT, SIGNAL, SPECTMOD
%    

global pm1 pm2 pm3 pm4 KlabL FSMAX
if length(find(vtype(X)==[5 6 7 9 10 11]))>0,
% clf
 subplot(2,1,1)
 if nargin==1,
  spplot(X,2)
 elseif vtype(Y)==1 & nargin==2
  spplot(X,2,Y)
 elseif length(find(vtype(Y)==[5 6 7 9 10 11]))>0 &  nargin==2,
  if length(find([5 6]==vtype(X)))>0 & length(find(vtype(Y)==[5 6]))>0,
   fmax=min(bandwi(X),bandwi(Y));
   if fmax==inf, fmax=FSMAX/2; end  % OBS fmax=200 innan ändring augusti 2004!!
   spplot(X,1,fmax)
   subplot(2,1,2)
   spplot(Y,1,fmax)
  else
   spplot(X,1)
   subplot(2,1,2)
   spplot(Y,1)
  end
 elseif length(find(vtype(Y)==[5 6 7 9 10 11]))>0 & nargin==3
  spplot(X,1,fmax)
   subplot(2,1,2)
  spplot(Y,1,fmax)
 else
  error('Fel input: Ingen transform')
 end
 
 % Tillägg för att lägga till 'edit-boxar' för ändring av
 % utskriftsintervall,  Lasse A aug. 2004
%  subplot(2,1,1)
%  ax1_hand=gca;
%  ax1=axis;
%  subplot(2,1,2)
%  ax2_hand=gca;
%  fmin_hand=uicontrol('Style','edit','Units','normalized','Position',[0.12 .5 0.05 0.04],...
%       'String',num2str(ax1(1)), 'CallBack','faxchange(0)', ...
%       'foreground','black','background',0.7*[1 1 1],'horizontal','left');
%  fmax_hand=uicontrol('Style','edit','Units','normalized','Position',[0.88 .5 0.05 0.04],...
%       'String',num2str(ax1(2)),'CallBack','faxchange(1)', ...
%       'foreground','black','background',0.7*[1 1 1],'horizontal','left');
%  
%  set(gcf,'UserData',[ax1_hand ax2_hand fmin_hand fmax_hand]);
else
   error('Fel input: Ingen transform')
end
