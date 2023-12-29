figure(451), pz(H_BP); ohfig
title('Pol-nollställediagram för H_{BP}(s)')

if frekvensintervall    % 0 till 2000 Hz, |H| i linjär skala
    figure(452), spectmod(H_BP,'A',2000); ohfig
    hold on
    plot([0 2000],1/sqrt(2)*[1 1],'--k')
    plot(941*[1 1],[0 1.1],'--k'), plot(1209*[1 1],[0 1.1],'--k') 
    hold off
    title('BP-filtrets amplitudkaraktäristik'), ylim([0 1.05])
    xticks([0 500 941 1209 1500 2000])
else                    % 900 till 1250 Hz, |H| i dB-skala
    figure(452), logspectmod(H_BP,1250); ohfig
    hold on
    plot([900 1250],[-3 -3],'--k')
    plot(941*[1 1],[-20 1],'--k'), plot(1209*[1 1],[-20 1],'--k')
    hold off
    axis([900 1250 -10 1]), yticks(-10:1), xticks([900 941 1000:50:1150 1209 1250])
end