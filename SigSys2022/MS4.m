% MATLAB Session 4: Analog Filters
echo on

% Frequency Response and Polynomial Evaluation:
% (refer to function M-file MS4P1)
pause

% Design and Evaluation of a Simple RC Filter:
omega_c = 2*pi*3000;
C = 1e-9;
R = 1/sqrt(C^2*omega_c^2)
pause

f = linspace(0,20000,200);
B = 1; A = [R*C 1]; Hmag_RC = abs(MS4P1(B,A,f*2*pi));
plot(f,abs(f*2*pi)<=omega_c,'k-',f,Hmag_RC,'b--'); 
xlabel('f [Hz]'); ylabel('|H_{RC}(j2\pi f)|');
axis([0 20000 -0.05 1.05]); legend('Ideal','First-Order RC');

pause; 
clf;

% A Cascaded RC Filter and Polynomial Expansion:
R = sqrt(2^(1/10)-1)/(C*omega_c)
pause

B = 1; A = poly(-1/(R*C)*ones(10,1));A = A/A(end);
Hmag_cascade = abs(MS4P1(B,A,f*2*pi));
plot(f,(abs(f*2*pi)<=omega_c)*1,'k-',f,Hmag_cascade,'b--'); 
xlabel('f [Hz]'); ylabel('|H_{cascade}(j\pi f)|'); 
axis([0 20000 -0.05 1.05]); legend('Ideal','Tenth-Order Cascaded RC');

pause; 
clf;

% Butterworth Filters:
% --------------------
% OBS: I slutet av sid. 472 står det "poles of |H_B(jw)|^2" på 4 ställen.
% Det skall vara "poles of H(s)H(-s)" !!

pause

N=10;
poles = roots([(j*omega_c)^(-2*N),zeros(1,2*N-1),1]);
plot(poles,'xb'); xlabel('Real'); ylabel('Imaginary'); axis equal;
pause; 
clf;

B_poles = poles(find(real(poles)<0));
A = poly(B_poles); A = A/A(end);
Hmag_B = abs(MS4P1(B,A,f*2*pi));

pause
% Nedanstående funktionsanrop för Butterworthfilter står inte i boken!
plot(f,(abs(f*2*pi)<=omega_c)*1,'k-',f,Hmag_B,'b--'); 
xlabel('f [Hz]'); ylabel('|H_{B}(j\pi f)|'); 
axis([0 20000 -0.05 1.05]); legend('Ideal','Tenth-Order Butterworth');
pause; 
clf;

plot(f,(abs(f*2*pi)<=omega_c)*1,'k-',f,Hmag_RC,'k-.',f,Hmag_cascade,'k--',f,Hmag_B,'b:')
axis([0 20000 -.05 1.05]); xlabel('f [Hz]'); ylabel('Magnitude Response');
legend('Ideal','First-Order RC','Tenth-Order Cascaded RC','Tenth-Order Butterworth')
pause; 
clf;

% Butterworth Filter Realization using Cascaded Second-Order Sections
%echo off
disp('MS4P2')
MS4P2
pause;

%echo on

% Chebyshev Filters
MS4P3(2)
MS4P3(3)
%pause

omega_c = 2*pi*1000; R = 1; N = 8;
epsilon = sqrt(10^(R/10)-1);
CN  = MS4P3(N).*((1/(j*omega_c)).^[N:-1:0]);
CP = epsilon^2*conv(CN,CN); CP(end) = CP(end)+1;
poles = roots(CP); i = find(real(poles)<0); C_poles = poles(i);
plot(real(C_poles),imag(C_poles),'bx'); axis equal;
axis(omega_c*[-1.1 1.1 -1.1 1.1]);
xlabel('\sigma'); ylabel('\omega');
pause; 
clf;

A = poly(C_poles);
B = A(end)/sqrt(1+epsilon^2);
omega = linspace(0,2*pi*2000,2001);
H = MS4P1(B,A,omega);
plot(omega/2/pi,abs(H),'b'); grid
xlabel('f [Hz]'); ylabel('|H(j2\pi f)|');
axis([0 2000 0 1.1]);
pause; 
clf;

k = [1:N]; xi = 1/N*asinh(1/epsilon); phi = (k*2-1)/(2*N)*pi;
C_poles = omega_c*(-sinh(xi)*sin(phi)+j*cosh(xi)*cos(phi));
plot(real(C_poles),imag(C_poles),'bx'); axis equal;
axis(omega_c*[-1.1 1.1 -1.1 1.1]);
xlabel('\sigma'); ylabel('\omega');


