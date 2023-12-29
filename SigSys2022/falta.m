% Faltning mellan x[n] och h[n]
% Lasse Alfredsson 2012
n=0:50;
x=inline('2*(n>=5 & n<20)','n');    % x[n]=2(u[n-5]-u[n-20])
h=inline('1*(n>=2 & n<10)','n');    % h[n]=u[n-2]-u[n-10]

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
