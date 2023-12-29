[B, A] = butter(N, 2*pi*100, 'low', 's');
H_B = in(B, A,'s');
figure(441), pz(H_B); ohfig;
title('Butterworthfiltrets pol-nollställediagram')
figure(442), logspectmod(H_B,fmax); axis([0 fmax dBmin 5]),
ohfig;
hold on, plot([0 fmax],[-3 -3],'--k'), plot([0 fmax],[0 0],'--k')
plot(100*[1 1],[-150 20],'--k'), hold off