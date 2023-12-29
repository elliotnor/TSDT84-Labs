x=in('cos(pi*n/6)*us(n)','n');
h=in('1.5*0.95^n*pulse(n,0,11)','n');

y = output(x,h);

figure(541)
subplot(2,1,1)
signalmod(x,60);
axis([-5 50 -1.2 1.2])
title('x[n]')
xlabel('')
grid on

subplot(2,1,2)
signalmod(h,60);
axis([-5 50 0 1.6])
title('h[n]')
xlabel('n')
grid on

figure(542)
signalmod(y,60);
axis([-5 50 -4 4])
title('y[n] = (x*h)[n]')
xlabel('n')
grid on