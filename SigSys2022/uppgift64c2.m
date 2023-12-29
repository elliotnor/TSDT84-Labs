if exist('HBPs') & exist('HBPz') % Både H(s) och H[z] är skapade

if PNs   % Visa pol-nollställediagrammet för H(s)
    figure(644)
    pz(HBPs);
    title('Systemfunktionen H(s)')
    ohfig;
end


if PNz   % Visa pol-nollställediagrammet för H[z]
   figure(645)
     pz(HBPz);
     title('Systemfunktionen H[z]')
     ohfig;
end


if AMli  % Visa |H(f)| och |H[theta]| i linjär skala
    figure(646)
        spect(HBPs, HBPz);
        subplot(2,1,1)
        title('|H(f))|')
        xlim([0 3200])
        subplot(2,1,2)
        title('|H[\theta])|')
    ohfig
end


if AMdB  % Visa % Visa |H(f)| och |H[theta]| i dB-skala
    figure(647)
        subplot(2,1,1)
        logspectmod(HBPs);
        xlim([0 3200])
        titxt=get(get(gca,'title'),'string');
        title(['|H(f))|_{dB}:  ' titxt])
        subplot(2,1,2)
        logspectmod(HBPz);
        titxt=get(get(gca,'title'),'string');
        title(['|H[\theta])|_{dB}:  ' titxt])
    ohfig
end
   
else
   disp("Du har inte skapat H(s) och H[z] än!");
   disp(' ')
end