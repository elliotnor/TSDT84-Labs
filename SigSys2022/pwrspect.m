function pwrspect(X,Y,fmax)
%PWRSPECT Plottning av energispektra.
%
%    PWRSPECT(X)        - X är fouriertransform.
%    PWRSPECT(X,Y)      - X och Y är fouriertransformer.
%    PWRSPECT(X,fmax)   - X är fouriertransform, fmax är reellt tal.
%    PWRSPECT(X,Y,fmax) - X och Y är fouriertransformer, fmax är reellt tal.
%    
%    Beskrivning:
%    Plottar energispektrum för en eller två fouriertransformer. 
%    fmax kan användas för att ändra frekvensområdet.
%    
%    Example:
%    X = in('1/(1+j*w)','w');
%    pwrspect(X)
%    pause
%    pwrspect(X,2)
%    
%    See also:
%    SPECT, LOGSPECT
%    

global pm1 pm2 pm3 pm4 KlabL
vx=vtype(X);
if nargin >1, vy=vtype(Y); end
if vx==5 | vx==9,  
 clf
 if nargin==1,
  pwrplot(X)
 elseif vy==1 & nargin==2,
  pwrplot(X,Y)
 elseif nargin==2 & (vy==5 | vy==9)
  if vx==5 & vy==5,
   bx=bandwi(X);
   by=bandwi(Y);
   fmax=min(bx,by);
   if fmax==inf, fmax=200; end
   subplot(2,1,1)
   pwrplot(X,fmax)
   subplot(2,1,2)
   pwrplot(Y,fmax)
  else
   subplot(2,1,1)
   pwrplot(X)
   subplot(2,1,2)
   pwrplot(Y)
  end
 elseif nargin==3 & (vy==5 | vy==9),
  subplot(2,1,1)
  pwrplot(X,fmax)
  subplot(2,1,2)
  pwrplot(Y,fmax)
 else
  error('Input incorrect: not Fourier transform')
 end
else
 error('Input incorrect: not Fourier transform')
end


