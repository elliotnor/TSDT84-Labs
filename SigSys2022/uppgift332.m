TONER = foutr(toner);
figure(332)
spectmod(TONER, 'A');
title('Amplitudspektrumet för DTMF-signalen ''toner''')
xlabel('Frekvens  [Hz]'), xlim([0,2000]), ohfig