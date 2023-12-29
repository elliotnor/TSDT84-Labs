 if thetaP1>0 & thetaP1<0.5 & thetaP2>0 & thetaP2<0.5  % Båda normerade gränsfrekvenserna måste ligga mellan 0 och 0.5
     
     save MinaTheta thetaP1 thetaP2     % Förutsätter att ThetaP1 < thetaP2...
     disp('Gränsfrekvenserna sparade!')
 else
     disp('De normerade frekvenserna måste ligga mellan 0 och 0.5')
 end