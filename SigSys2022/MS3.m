% MATLAB Session 3: Discrete-Time Signals and Systems
echo on

figure(11)

% Discrete-Time Functions and Stem Plots:
f = inline('exp(-n/5).*cos(pi*n/5).*(n>=0)','n');

n = (-10:10)';
stem(n,f(n),'k');
xlabel('n'); title('f[n]');
ylim([-.5 1.1])
ohfig
grid
pause; 

figure(22)

subplot(2,1,1); stem(n,f(-2*n),'k'); title('f[-2n]');
ylim([-.5 1.1])
grid
subplot(2,1,2); stem(n,f(-2*n+1),'k'); title('f[-2n+1]'); xlabel('n');
ylim([-.5 1.1])
grid
ohfig
pause; 

clf;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% System Responses through Filtering

figure(11)

b = [1 0 0]; a = [1 -1 1];
n = (0:30)'; delta = inline('n==0','n');
h = filter(b,a,delta(n));
stem(n,h,'k'); axis([-.5 30.5 -1.1 1.1]);
xlabel('n'); title('h[n]');
ohfig
grid
pause; 

figure(22)

x = inline('cos(2*pi*n/6).*(n>=0)','n');
y = filter(b,a,x(n));
subplot(2,1,1);
  stem(n,x(n),'k'); xlabel('n'); title('x[n]');
subplot(2,1,2);
  stem(n,y,'k'); xlabel('n'); title('y[n]');
ohfig
grid
pause; 

figure(33)

z_i = filtic(b,a,[1 2]);
y_0 = filter(b,a,zeros(size(n)),z_i);
stem(n,y_0,'k'); xlabel('n'); title('y_{0} [n]'); 
axis([-0.5 30.5 -2.1 2.1]);
grid
ohfig
pause; 

figure(44)

y_total = filter(b,a,x(n),z_i);
sum(abs(y_total-(y + y_0)))
grid
ohfig
pause; 

clf;

% A Custom Filter Function
% (refer to function M-file MS3P1)

grid
ohfig
pause

% Discrete-Time Convolution
conv([1 1 1 1],[1 1 1 1])
ohfig
grid
pause; 

clf;

h = inline('(cos(pi*n/3)+sin(pi*n/3)/sqrt(3)).*(n>=0)','n');
y = conv(h(n),x(n));
stem([0:60],y,'k'); xlabel('n'); title('y[n]');
ohfig
grid
pause; 

clf;

stem(n,y(1:31),'k'); xlabel('n'); title('y[n]');
grid
ohfig
    
