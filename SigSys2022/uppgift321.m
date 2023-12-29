s1 = in('sin(2*pi*200*t)*pulse(t,0,1/5)', 't');
s2 = in('sin(2*pi*200*t)*pulse(t,0,1/40)', 't');
signal(s1, s2);
subplot(2,1,1); title("Signalen s_1(t)"), xlim([-0.05, 0.3]);
subplot(2,1,2); title("Signalen s_2(t)"), xlim([-0.005, 0.03]); ohfig