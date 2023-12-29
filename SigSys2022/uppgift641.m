% Punkt 1:
load dtmf
T=toner(65537); 

% Punkt 2:
figure(641)
  signal(toner)
  axis([-0.01 0.21 -6.5 6.5])
  set(gca,'ytick',-6:2:6)
  title('Den första DFTMF-pulsen i x(t)=toner')
  
figure(642)  % Öppna ett fönster

% Punkt 3:
subplot(2,1,1)
  signalmod(toner,30*T)
  axis([-5*T 30*T -6.5 6.5])
  title('Början av x(t)=toner')

% Punkt 4:
  hold on
  plot(-5*T:T:30*T,toner(32769+(-5:30)),'o')
  set(gca,'ytick',-6:2:6)
  hold off

% Punkt 5:
subplot(2,1,2)
  Dtoner=[toner 0 0 0]; 
  signalmod(Dtoner,30)
  axis([-5 30 -6.5 6.5])
  set(gca,'ytick',-6:2:6)
  title('Början av x[n]=Dtoner')
  ohfig  % Förstorar fönster i graferna och gör linjer bredare