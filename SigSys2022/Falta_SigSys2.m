function Falta_SigSys2(x_str,h_str, time)
% Falta_SigSys2(x_str, h_str) är ekvivalent med Falta_SigSys2, med skillnaden 
% att här speglas och förskjuts impulssvaret h i stället för insignalen x.
% Se hjälptexten för Falta_SigSys2 för hjälp med funktionaliteten!
% 
% Används av Matlab Live Script i TSDT18/84 Signaler & System.
% 
% Lasse A. Sep 2020
%

% OBS: Här har jag gjort det enkelt för mig genom att bara ändra på x och h
% nedan och ändra i legend och ylabel (så när x speglas i koden så jobbar
% vi egentligen med h)

x = inline(h_str);  
h = inline(x_str);

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

plot(tau,x(t-tau),'b--',tau,h(tau),'k-',t,0,'ok'); %FRIDA - ÄNDRAD 20/10-2020
axis([tau(1) 5 -2.0 3]); 
patch([tau(1:end-1);tau(1:end-1);tau(2:end);tau(2:end)],...
    [zeros(1,lxh-1);xh(1:end-1);xh(2:end);zeros(1,lxh-1)],...
    [.8 .8 .8],'edgecolor','none'); 
xlabel('\tau'); legend('h(t-\tau)','x(\tau)','t','\int x(\tau)h(t-\tau)'); %FRIDA - ÄNDRAD 20/10-2020
c = get(gca,'children'); set(gca,'children',[c(2);c(3);c(4);c(1)]);

subplot(2,1,2);
plot(tvecDense,x(tvecDense),'b--',tvec,y,'r',tvec(ti),y(ti),'ok'); %FRIDA - ÄNDRAD 20/10-2020
axis([tau(1) 5 -1.0 2.0]);
xlabel('t'); ylabel('y(t) = \int x(\tau)h(t-\tau) d\tau');
legend('h(t)', 'y(t)', 't'); %FRIDA - ÄNDRAD 20/10-2020
grid;

%ohfig % Ökar fontstorlek och linjetjocklekar %FRIDA - ÄNDRAD 20/10-2020


    
