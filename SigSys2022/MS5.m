% MATLAB Session 5: Discrete-Time IIR Filters 
%echo on

% Frequency Response and Pole-Zero Plots:
% (refer to function M-file MS5P1 for frequency response calculations)
% (refer to function M-file MS5P2 for pole-zero calculations)
%pause

% Transformation Basics:
% (no associated code)

% Transformation by First-Order Backward Difference:
% (refer to function M-file MS5P3)
%pause

% Bilinear Transformation:
% (refer to function M-file MS5P4)
%pause

% Bilinear Transformation with Prewarping
% (prewarping adjusts T = 2/omega_c*tan(Omega_c/2))
%pause

% Example: Butterworth Filter Transformation:
omega_c = 2*pi*3000; N=10;
poles = roots([(j*omega_c)^(-2*N),zeros(1,2*N-1),1]);
poles = poles(find(poles<0));
B = 1; A = poly(poles); A = A/A(end);

Omega = linspace(0,pi,200); T = 1/10000; Omega_c = omega_c*T;
[B1,A1] = MS5P3(B,A,T); % First-order backward difference transformation
[B2,A2] = MS5P4(B,A,T); % Bilinear transformation
[B3,A3] = MS5P4(B,A,2/omega_c*tan(Omega_c/2)); % Bilinear with prewarping

H1mag = abs(MS5P1(B1,A1,Omega));
H2mag = abs(MS5P1(B2,A2,Omega));
H3mag = abs(MS5P1(B3,A3,Omega));
plot(Omega,(Omega<=Omega_c)*1,'k',Omega,H1mag,'k-.',Omega,H2mag,'k--',Omega,H3mag,'k:');
axis([0 pi -.05 1.5]); xlabel('\Omega [rad]'); ylabel('Magnitude Response');
legend('Ideal','First-Order Backward Difference','Bilinear','Bilinear with Prewarping');
%pause; clf

% Problems Finding Polynomial Roots:
roots([1 4 6 4 1])'
%pause

[p,z] = MS5P2(B3,A3);
%pause; clf;

% Improved Design Using Cascaded Second-Order Sections:
%echo off
disp('MS5P5')
MS5P5
