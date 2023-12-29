% Faltning mellan x[n] och h[n]
% Kopia av falta.m, för uppgift 5.4
n=0:50;
x=inline('cos(pi*n/6).*(n>=0)','n');            % x[n]=cos(n*pi/6)*u[n]
h=inline('(1.5*0.95.^n).*(n>=0 & n<11)','n');   % h[n]=1.5*(0.95)^n*(u[n]-u[n-11])



subplot(2,1,1)
stem(n,x(n),'b');hold on, 
stem(n,h(n),'r');hold off
xlabel('n')
title('x[n]  (blå)  & h[n]  (röd)')

y=conv(x(n),h(n));       % y[n]=x[n]*h[n]  (faltning)
subplot(2,1,2) 
stem(n,y(1:length(n)));  % Ty length(y) = length(x)+length(h)-1
xlabel('n')
title('y[n]')
