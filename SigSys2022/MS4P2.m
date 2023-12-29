% MS4P2.m : MATLAB Session 4, Program 2
% Script M-file computes Sallen-Key component values and magnitude 
% responses for each of the five cascaded second-order filter sections.  

omega_0 = 3000*2*pi; % Filter cut-off frequency
psi = [9 27 45 63 81]*pi/180; % Butterworth pole angles
f = linspace(0,6000,200); % Frequency range for magnitude response calculations
Hmag_SK = zeros(5,200); % Pre-allocate array for magnitude responses
for stage = 1:5,
    Q = 1/(2*cos(psi(stage))); % Compute Q for current stage
    % Compute and display filter components to the screen:
    disp(['Stage ',num2str(stage),... 
            ' (Q = ',num2str(Q),... 
            '):  R1 = R2 = ',num2str(56000),... 
            ', C1 = ',num2str(2*Q/(omega_0*56000)),... 
            ', C2 = ',num2str(1/(2*Q*omega_0*56000))]); 
    B = omega_0^2; A = [1 omega_0/Q omega_0^2]; % Compute filter coefficients
    Hmag_SK(stage,:) = abs(MS4P1(B,A,2*pi*f)); % Compute magnitude response
end
plot(f,Hmag_SK,'k',f,prod(Hmag_SK),'k:')
xlabel('f [Hz]'); ylabel('Magnitude Response')