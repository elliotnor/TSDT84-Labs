function Falta_SigSys(x_str,h_str, time)
% Falta_SigSys(x_str, h_str) faltar x(t) och h(t),
% lämpligast så att y(t) har hunnit gå till ca. 0 vid t=4 sek.
% Används av Matlab Live Script i TSDT18/84 Signaler & System.
% 
% Lasse A. Nov 2013 & Sep 2020
%
%
% Ex 1: Falta_SigSys('1.5*sin(pi*t).*(t>=0&t<1)','1.5*(t>=0&t<1.5)-(t>=2&t<2.5)')
% Ex 2: Falta_SigSys('1.5*(t>=0&t<1.5)-(t>=2&t<2.5)','1.5*sin(pi*t).*(t>=0&t<1)')
% Ex 3: Falta_SigSys('1.5*sin(pi*t).*(t>=0&t<1)','1.5*(t+0.2>=0&t+0.2<1.5)-(t+0.2>=2&t+0.2<2.5)')
% Ex 4: Falta_SigSys('1.5*sin(pi*(t-0.5)).*(t-0.5>=0&t-0.5<1)','1.5*(t+0.2>=0&t+0.2<1.5)-(t+0.2>=2&t+0.2<2.5)')
%
% Ytterligare ett exempel att "leka" med:
% Ex 5:  Falta_SigSys('2*exp(-3*t).*(t>=0&t<1)','1.5*(t>=0.5&t<2.5)')

%
% MATLAB Session 2, Program 4
% Script M-file graphically demonstrates the convolution process.

% x = inline('1.5*sin(pi*t).*(t>=0&t<1)');  
% h = inline('1.5*(t>=0&t<1.5)-(t>=2&t<2.5)');

x = inline(x_str);  
h = inline(h_str);

dtau = 0.005; tau = -1:dtau:4;
ti = 0; tvec = -.3:.1:4;
tvecDense = tvec(1):dtau:tvec(end);
y = NaN*zeros(1,length(tvec)); % Pre-allocate memory

t = max(tvec(1), min(tvec(end), time));
ti = find(tvec >= t, 1); 

for i = 1:ti
    xh = x(tvec(i)-tau).*h(tau); 
    y(i) = sum(xh.*dtau);
    lxh = length(xh);
end
figure(1) % Create figure window and make visible on screen
subplot(2,1,1);

plot(tau,x(t-tau),'b--',tau,h(tau),'k-',t,0,'ok'); 
axis([tau(1) 5 -2.0 3]); 
patch([tau(1:end-1);tau(1:end-1);tau(2:end);tau(2:end)],...
    [zeros(1,lxh-1);xh(1:end-1);xh(2:end);zeros(1,lxh-1)],...
    [.8 .8 .8],'edgecolor','none'); 
xlabel('\tau'); legend('x(t-\tau)','h(\tau)','t','\int x(t-\tau)h(\tau)');
c = get(gca,'children'); set(gca,'children',[c(2);c(3);c(4);c(1)]);

subplot(2,1,2);
plot(tvecDense,x(tvecDense),'b--',tvec,y,'r',tvec(ti),y(ti),'ok'); 
axis([tau(1) 5 -1.0 2.0]);
xlabel('t'); ylabel('y(t) = \int x(t-\tau)h(\tau) d\tau');
legend('x(t)', 'y(t)', 't');
grid;

%ohfig % Ökar fontstorlek och linjetjocklekar %FRIDA - ÄNDRAD 20/10-2020


    
