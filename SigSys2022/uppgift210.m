X = fouser('pulse(t,0,1)+pulse(t,7,8)',8);  % Funktionen anges i intervallet [0, To]

figure(2101)
signal(X,3);                                % 3 perioder av insignalen visas fr.o.m. t=0
title("Insignalen – en fyrkantpulsvåg");

ohfig  % Ökar fontstorleken och linjebredden i figuren
disp(' '), disp('Signalens enkelsidiga amplitud- och fasspektrum:'), 
disp(' ')
figure(2102)
spect(X), 
ohfig