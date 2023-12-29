% MATLAB Session 9: Working with the DTFS and the DTFT
%echo on

% Computing the Discrete-Time Fourier Series:
T = 1/1000; N_0 = 100; n = (0:N_0-1)';
x = cos(2*pi*50*n*T);
X = fft(x)/N_0; f = (0:N_0-1)/(T*N_0);
stem(f-500,fftshift(abs(X)),'k'); axis([-500 500 -0.1 0.6]);
xlabel('f [Hz]'); ylabel('|X(f)|');
%pause; clf;
output1=fftshift(abs(X));

x_hat = real(ifft(X)*N_0);
stem(n,x_hat,'k'); axis([0 99 -1.1 1.1]);
xlabel('n'); ylabel('x_{hat}[n]');
%pause; clf;
output2=x_hat;

W = MS9P1(100); X = W*x/N_0;
stem(f-500,fftshift(abs(X)),'k'); axis([-500 500 -0.1 0.6]);
xlabel('f [Hz]'); ylabel('|X(f)|');
%pause; clf;
output3=fftshift(abs(X));

% Measuring Code Performance:
tic; W*x/N_0; toc
%pause

tic; for i=1:1000, W*x/N_0; end; toc
%pause

tic; for i=1:1000, fft(x)/N_0; end; toc
%pause

y1 = rand(1015,1);
tic; for i=1:1000; fft(y1)/1015; end; T1=toc
%pause

y2 = [y1;zeros(4,1)];
tic; for i=1:1000; fft(y2)/1019; end; T2=toc
T2/T1
%pause

y3 = [y2;zeros(5,1)];
tic; for i=1:1000; fft(y3)/1024; end; T3=toc
T3/T1
%pause

factor(1015)
factor(1019)
factor(1024)
%pause

% FIR Filter Design by Frequency Sampling:
%H_d = inline('(mod(Omega,2*pi)<pi/4)+(mod(Omega,2*pi)>2*pi-pi/4)');
N = 21;
Omega = linspace(0,2*pi,1000);
H_d = (mod(Omega,2*pi)<pi/4)+(mod(Omega,2*pi)>2*pi-pi/4);
h = MS9P2(N);
samples = linspace(0,2*pi*(1-1/N),N)';
H = MS5P1(h,1,Omega);
H_d_samples = (mod(samples,2*pi)<pi/4)+(mod(samples,2*pi)>2*pi-pi/4);
subplot(2,1,1); stem([0:N-1],h,'k'); xlabel('n'); ylabel('h[n]');
subplot(2,1,2); 
plot(samples,H_d_samples,'ko',Omega,H_d,'k:',Omega,abs(H),'k');
axis([0 2*pi -0.1 1.6]); xlabel('\Omega'); ylabel('|H(\Omega)|'); 
legend('Samples','Desired','Actual','0');
%pause, clf
output4=h;
output5=H_d_samples;
output6=H_d;
output7=abs(H);

N = 41; h = MS9P2(N);
Omega = linspace(0,2*pi,1000); samples = linspace(0,2*pi*(1-1/N),N)';
H = MS5P1(h,1,Omega);
H_d_samples = (mod(samples,2*pi)<pi/4)+(mod(samples,2*pi)>2*pi-pi/4);
subplot(2,1,1); stem([0:N-1],h,'k'); xlabel('n'); ylabel('h[n]');
subplot(2,1,2); 
plot(samples,H_d_samples,'ko',Omega,H_d,'k:',Omega,abs(H),'k');
axis([0 2*pi -0.1 1.6]); xlabel('\Omega'); ylabel('|H(\Omega)|'); 
legend('Samples','Desired','Actual','0');
%pause, clf
output8=h;
output9=H_d_samples;
output10=H_d;
output11=abs(H);

N = 21; h = MS9P3(N);
Omega = linspace(0,2*pi,1000); samples = linspace(0,2*pi*(1-1/N),N)';
H = MS5P1(h,1,Omega);
H_d_samples = (mod(samples,2*pi)<pi/4)+(mod(samples,2*pi)>2*pi-pi/4);
subplot(2,1,1); stem([0:N-1],h,'k'); xlabel('n'); ylabel('h[n]');
subplot(2,1,2); 
plot(samples,H_d_samples,'ko',Omega,H_d,'k:',Omega,abs(H),'k');
axis([0 2*pi -0.1 1.3]); xlabel('\Omega'); ylabel('|H(\Omega)|'); 
legend('Samples','Desired','Actual','0');
%pause, clf
output12=h;
output13=H_d_samples;
output14=H_d;
output15=abs(H);

N = 41; h = MS9P3(N);
Omega = linspace(0,2*pi,1000); samples = linspace(0,2*pi*(1-1/N),N)';
H = MS5P1(h,1,Omega);
H_d_samples = (mod(samples,2*pi)<pi/4)+(mod(samples,2*pi)>2*pi-pi/4);
subplot(2,1,1); stem([0:N-1],h,'k'); xlabel('n'); ylabel('h[n]');
subplot(2,1,2); 
plot(samples,H_d_samples,'ko',Omega,H_d,'k:',Omega,abs(H),'k');
axis([0 2*pi -0.1 1.3]); xlabel('\Omega'); ylabel('|H(\Omega)|'); 
legend('Samples','Desired','Actual','0');
%pause, clf
output16=h;
output17=H_d_samples;
output18=H_d;
output19=abs(H);

%H_d = inline(['(mod(Omega,2*pi)>pi/4)&(mod(Omega,2*pi)<pi/2)+',...
%       '(mod(Omega,2*pi)>3*pi/2)&(mod(Omega,2*pi)<7*pi/4)']);
Omega = linspace(0,2*pi,1000); samples = linspace(0,2*pi*(1-1/N),N)';
H_d = (mod(Omega,2*pi)>pi/4)&(mod(Omega,2*pi)<pi/2)+ (mod(Omega,2*pi)>3*pi/2)&(mod(Omega,2*pi)<7*pi/4);
N = 50; h = MS9P3b(N); 
H = MS5P1(h,1,Omega);
H_d_samples = (mod(samples,2*pi)>pi/4)&(mod(samples,2*pi)<pi/2)+ (mod(samples,2*pi)>3*pi/2)&(mod(samples,2*pi)<7*pi/4);
 H_d_samples = H_d_samples*1; H_d =H_d*1;
subplot(2,1,1); 
stem([0:N-1],h,'k'); xlabel('n'); ylabel('h[n]'); axis([0 49 -.25 .25]);
subplot(2,1,2);
plot(samples,H_d_samples,'ko',Omega,H_d,'k:',Omega,abs(H),'k');
axis([0 2*pi -0.1 1.3]); xlabel('\Omega'); ylabel('|H(\Omega)|'); 
legend('Samples','Desired','Actual','0');
output20=h;
output21=H_d_samples;
output22=H_d;
output23=abs(H);

%echo off
