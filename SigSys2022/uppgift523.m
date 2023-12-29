
if upg52     %  Uppgift 5.2 
 x=in('2*pulse(n,5,15)','n');
else         %  Uppgift 5.3
 pm1=M;
 x=in('2*pulse(n,5+pm1,15+pm1)','n');
end
h=in('pulse(n,2,6)','n');

y=output(x,h);

figure(552)
subplot(3,1,1)
signalmod(x,30);
axis([-5 30 0 2.2])
if upg52, title('x_1[n]'), else title('x_2[n]'), end
xlabel('')
grid on

subplot(3,1,2)
signalmod(h,30);
axis([-5 30 0 2.2])
title('h[n]')
xlabel('')
grid on

subplot(3,1,3)
signalmod(y,30);
axis([-5 30 0 10])
if upg52, title('y_1[n] = (x_1*h)[n]'), else title('y_2[n] = (x_2*h)[n]'), end
xlabel('n')
grid on
