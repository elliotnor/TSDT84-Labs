% MATLAB Session 8: The Discrete Fourier Transform 
%echo on; 
clf

% Computing the Discrete Fourier Transform:
T = 1/50; N_0 = 50; n = (0:N_0-1);
x = T*cos(2*pi*10*n*T);
X = fft(x);
f = (0:N_0-1)/(T*N_0);
stem(f,abs(X),'k'); axis([0 50 -0.05 0.55]);
xlabel('f [Hz]'); ylabel('|X(f)|');
%pause; clf;
output1=abs(X);

stem(f-1/(T*2),fftshift(abs(X)),'k'); axis([-25 25 -0.05 0.55]);
xlabel('f [Hz]'); ylabel('|X(f)|');
%pause; clf;
output2=fftshift(abs(X));


stem(f-1/(T*2),fftshift(angle(X)),'k'); axis([-25 25 -1.1*pi 1.1*pi]);
xlabel('f [Hz]'); ylabel('\angle X(f)');
%pause; clf;
output3=fftshift(angle(X));

% Improving the Picture with Zero-Padding:
y = T*exp(j*2*pi*(10+1/3)*n*T); Y = fft(y);
stem(f-25,fftshift(abs(Y)),'k'); axis([-25 25 -0.05 1.05]);
xlabel('f [Hz]'); ylabel('|Y(f)|');
%pause; clf;
output4=fftshift(abs(Y));

y_zp = [y,zeros(1,11*length(y))]; Y_zp = fft(y_zp);
f_zp = (0:12*N_0-1)/(T*12*N_0);
stem(f_zp-25,fftshift(abs(Y_zp)),'k.'); axis([-25 25 -0.05 1.05]);
xlabel('f [Hz]'); ylabel('|Y_{zp}(f)|');
%pause; clf;
output5=fftshift(abs(Y_zp));

% Quantization:
x = (-10:.0001:10);
xsq = MS8P1(x,10,3,'sym');
plot(x,xsq,'k'); grid; 
xlabel('Quantizer input'); ylabel('Quantizer output');
%pause; clf;
output6=xsq;

xaq = MS8P1(x,10,3,'asym');
plot(x,xaq,'k'); grid; 
xlabel('Quantizer input'); ylabel('Quantizer output');
%pause; clf;
output7=xaq;

x = cos(2*pi*n*T); X = fft(x);
xaq = MS8P1(x,1,2,'asym'); Xaq = fft(xaq);
subplot(2,2,1); stem(n,x,'k'); axis([0 49 -1.1 1.1]);
xlabel('n');ylabel('x[n]');
subplot(2,2,2); stem(f-25,fftshift(abs(X)),'k'); axis([-25,25 -1 26])
xlabel('f');ylabel('|X(f)|');
subplot(2,2,3); stem(n,xaq,'k');axis([0 49 -1.1 1.1]);
xlabel('n');ylabel('x_{aq}[n]');
subplot(2,2,4); stem(f-25,fftshift(abs(fft(xaq))),'k'); axis([-25,25 -1 26]);
xlabel('f');ylabel('|X_{aq}(f)|');
output8=x;
output9=fftshift(abs(X));
output10=xaq
output11=fftshift(abs(fft(xaq)));

%echo off
