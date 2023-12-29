function Falta_SigSys2(x_str,h_str, time)
% Falta_SigSys2(x_str, h_str) �r ekvivalent med Falta_SigSys2, med skillnaden 
% att h�r speglas och f�rskjuts impulssvaret h i st�llet f�r insignalen x.
% Se hj�lptexten f�r Falta_SigSys2 f�r hj�lp med funktionaliteten!
% 
% Anv�nds av Matlab Live Script i TSDT18/84 Signaler & System.
% 
% Lasse A. Sep 2020
%

% OBS: H�r har jag gjort det enkelt f�r mig genom att bara �ndra p� x och h
% nedan och �ndra i legend och ylabel (s� n�r x speglas i koden s� jobbar
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

plot(tau,x(t-tau),'b--',tau,h(tau),'k-',t,0,'ok'); %FRIDA - �NDRAD 20/10-2020
axis([tau(1) 5 -2.0 3]); 
patch([tau(1:end-1);tau(1:end-1);tau(2:end);tau(2:end)],...
    [zeros(1,lxh-1);xh(1:end-1);xh(2:end);zeros(1,lxh-1)],...
    [.8 .8 .8],'edgecolor','none'); 
xlabel('\tau'); legend('h(t-\tau)','x(\tau)','t','\int x(\tau)h(t-\tau)'); %FRIDA - �NDRAD 20/10-2020
c = get(gca,'children'); set(gca,'children',[c(2);c(3);c(4);c(1)]);

subplot(2,1,2);
plot(tvecDense,x(tvecDense),'b--',tvec,y,'r',tvec(ti),y(ti),'ok'); %FRIDA - �NDRAD 20/10-2020
axis([tau(1) 5 -1.0 2.0]);
xlabel('t'); ylabel('y(t) = \int x(\tau)h(t-\tau) d\tau');
legend('h(t)', 'y(t)', 't'); %FRIDA - �NDRAD 20/10-2020
grid;

%ohfig % �kar fontstorlek och linjetjocklekar %FRIDA - �NDRAD 20/10-2020


    
