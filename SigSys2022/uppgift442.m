[B, A] = cheby1(N, 3, 2*pi*100, 'low', 's');
H_C = in(B, A, 's');
figure(443), pz(H_C); ohfig
title('Chebyshevfiltrets pol-nollställediagram')
figure(445), logspectmod(H_C,fmax); axis([0 fmax dBmin 5]),
ohfig;
hold on, plot([0 fmax],[-3 -3],'--k'), plot([0 fmax],[0 0],':k')
plot(100*[1 1],[-150 20],'--k'), hold off