s1 = in('sin(2*pi*200*t)*pulse(t,0,1/5)', 't');
S1 =  foutr(s1);
s2 = in('sin(2*pi*200*t)*pulse(t,0,1/40)', 't');
S2 = foutr(s2);
spect(S1, S2); xlim([0 400]); yticks([0 0.005 0.0125]);
subplot(2,1,1); xlim([175, 225]);
title("Amplitudspektrum |S_1(f)|")
xlabel('Frekvens [Hz]'), ylabel('')
subplot(2,1,2);
title("Amplitudspektrum |S_2(f)|")
xlabel('Frekvens [Hz]'), ylabel(''), ohfig