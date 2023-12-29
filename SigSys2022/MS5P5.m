% MS5P5.m : MATLAB Session 5, Program 5
% Script M-file designs a 180th-order Butterworth lowpass discrete-time filter  
% with cutoff Omega_c = 0.6*pi using 90 cascaded second-order filter sections.  

omega_0 = 1; % Use normalized cutoff frequency for analog prototype
psi = [0.5:1:90]*pi/180; % Butterworth pole angles
Omega_c = 0.6*pi; % Discrete-time cutoff frequency
Omega = linspace(0,pi,1000); % Frequency range for magnitude response
Hmag = zeros(90,1000); p = zeros(1,180); z = zeros(1,180); % Pre-allocation
for stage = 1:90,
    Q = 1/(2*cos(psi(stage))); % Compute Q for stage
    B = omega_0^2; A = [1 omega_0/Q omega_0^2]; % Compute stage coefficients
    [B1,A1] = MS5P4(B,A,2/omega_0*tan(0.6*pi/2)); % Transform stage to DT
    p(stage*2-1:stage*2) = roots(A1); % Compute z-domain poles for stage
    z(stage*2-1:stage*2) = roots(B1); % Compute z-domain zeros for stage
    Hmag(stage,:) = abs(MS5P1(B1,A1,Omega)); % Compute stage mag response
end
ucirc = exp(j*linspace(0,2*pi,200)); % Compute unit circle for pole-zero plot
figure; 
plot(real(p),imag(p),'kx',real(z),imag(z),'ok',real(ucirc),imag(ucirc),'k:');
axis equal; xlabel('Real'); ylabel('Imaginary');
figure; plot(Omega,Hmag,'k'); axis tight 
xlabel('\Omega [rad]'); ylabel('Magnitude Response');
figure; plot(Omega,prod(Hmag),'k'); axis([0 pi -0.05 1.05]);
xlabel('\Omega [rad]'); ylabel('Magnitude Response');
output1=p;
output2=z;
output3=ucirc;
output4=Hmag;
