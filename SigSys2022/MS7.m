% MATLAB Session 7: Fourier Transform Topics 
%echo on

% The Sinc Function and the Scaling Property:
%X = inline('tau*MS7P1(omega*tau/2)','omega','tau');
omega = linspace(-4*pi,4*pi,200);
tau =1;
X1 = tau*MS7P1(omega*tau/2);
tau = 0.5;
X2 = tau*MS7P1(omega*tau/2);
tau = 2;
X3 = tau*MS7P1(omega*tau/2);
plot(omega,X1,'k-',omega,X2,'k:',omega,X3,'k--'); 
grid; xlabel('\omega'); ylabel('X(\omega)');
legend('Baseline (\tau = 1)','Compressed (\tau = 0.5)',...
    'Expanded (\tau = 2.0)');
%pause; clf;

output1=X1;

% Parseval's Theorem and Essential Bandwidth:
%X_squared = inline('(tau*MS7P1(omega*tau/2)).^2','omega','tau');
X_squared = (tau*MS7P1(omega*tau/2)).^2;
%quad(X_squared,-1e6,1e6,[],[],1)
%pause

[W,E_W]=MS7P2(1,0.9,0.001)
%pause

output2=[W,E_W];

[W,E_W]=MS7P2(1,0.9,0.00005)
%pause
output3=[W,E_W];

% Spectral Sampling:
tau = pi; T_0 = 2*pi; n = [0:10];
D_n = tau/T_0*MS7P1(n*pi*tau/T_0);
stem(n,D_n); xlabel('n'); ylabel('D_n');
axis([-0.5 10.5 -0.2 0.55]);
%pause; clf;
output4=D_n;

tau = pi; T_0 = 4*pi; n = [0:20];
D_n = tau/T_0*MS7P1(n*pi*tau/T_0);
stem(n,D_n); xlabel('n'); ylabel('D_n');
axis([-1.0 21 -0.1 0.275]);
%pause; clf;
output5=D_n;

tau = pi; T_0 = 50*pi; n = [0:250];
D_n = tau/T_0*MS7P1(n*pi*tau/T_0);
plot(n,D_n,'.'); xlabel('n'); ylabel('D_n');
%pause; clf;
output6=D_n;

tau = pi; T_0 = pi; n = [0:10];
D_n = tau/T_0*MS7P1(n*pi*tau/T_0);
stem(n,D_n); xlabel('n'); ylabel('D_n');
%pause; clf;
output7=D_n;

% Kaiser Window Functions:
t = [-0.6:.001:0.6]; T = 1;
plot(t,MS7P3(t,T,'r'),'k-',t,MS7P3(t,T,'ham'),'k:',t,MS7P3(t,T,'b'),'k--');
axis([-0.6 0.6 -.1 1.1]); xlabel('t'); ylabel('w_K(t)');
legend('Rectangular','Hamming','Blackman');
output8=MS7P3(t,T,'r');
output9=MS7P3(t,T,'ham');
output10=MS7P3(t,T,'b');

%echo off
