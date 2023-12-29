if exist('toner')  % toner är hämtad i föregående sektion

TONER=foutr(toner); 
DTONER=foutr(Dtoner);

figure(643)
    spect(TONER,DTONER);
    fskala=[0 3200;640 1600];
    nfskala=[0 0.5; 0.1 0.25];


    subplot(2,1,1), 
      axis([fskala(ZoomaIn+1,:) 0 2])
      title("Amplitudspektrum |X(f)| för x(t)=toner");
    subplot(2,1,2)
      title("Amplitudspektrum |X[\theta]| för x[n]=Dtoner");
      axis([nfskala(ZoomaIn+1,:) 0 2*6400])
  
ohfig

else  % toner är inte hämtad
    disp('Du har inte hämtat DTMF-signalen toner än!')
    disp('Klicka på knappen [Undersök toner] ovan för att göra just detta.')
end
