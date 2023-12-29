% MATLAB Session B: Elementary Operations
%echo on

% MATLAB Overview:
% Refer to text regarding an overview of MATLAB

% Calculator Operations:
z = -3-j*4
%pause;
output1=z;

z_real = real(z); z_imag = imag(z);
z_mag = sqrt(z_real^2 + z_imag^2)
%pause;
output2=z_real;
output3=z_imag;
output4=z_mag;

z_mag = sqrt(z*conj(z))
%pause;
output5=z_mag;

z_mag = abs(z)
%pause;
output6=z_mag;

z_rad = angle(z)
%pause;
output7=z_rad;

z_deg = angle(z)*180/pi
%pause;
output8=z_deg;

z_rad = atan2(z_imag,z_real)
%pause;
output9=z_rad;

cos(j)
%pause;
output10=cos(j);

log(-1)
%pause;
output11=log(-1);

% Vector Operations:
k = 0:2:11
%pause;
output12=k;

k = 11:-10/3:0
%pause;
output13=k;

k = 0:11
%pause;
output14=k;


k = 0:2;
w = exp(j*(pi/3 + 2*pi*k/3))
%pause;
output15=w;
    
k = 0:99;
w = exp(j*(pi/100 + 2*pi*k/100));
w(5)
%pause;
output16=w(5);

k(5)
%pause;
output17=k(5);

w(98:100)
%pause;
output18=w(98:100);

t = 0:0.2/500:0.2-0.2/500;
f = sin(2*pi*10*t+pi/6);
f(1)
%pause;
output19=f(1);

% Simple Plotting:
plot(t,f);
xlabel('t'); ylabel('f(t)')
%pause; clf;
output20=f;
    
plot(real(w),imag(w),'o');
xlabel('Re(w)'); ylabel('Im(w)');
axis equal
%pause; clf;
output21=w;
    
% Element-by-Element Operations:
g = exp(-10*t);
h = f.*g;
plot(t,f,'-k',t,h,':k');
xlabel('t'); ylabel('Amplitude');
legend('f(t)','h(t)');
%pause; clf;
output22=f;
output23=h;
    
% Matrix Operations:
r = [1 0 0]
%pause;
output24=r;

A = [2 3;4 5;0 6]
%pause;
output25=A;

c = r'
%pause;
output26=c;

B = [c A]
%pause;
output27=B;

B(1,2)
%pause;
output28=B(1,2);

B(1:2,2:3)
%pause;
output29=B(1:2,2:3);

B(2,:)
%pause;
output30=B(2,:);
    
A = [1 -2 3;-sqrt(3) 1 -sqrt(5);3 -sqrt(7) 1];
y = [1;pi;exp(1)];
x = inv(A)*y
%pause;
output31=x;

x = A\y
%pause;
output32=x;

x1 = det([y,A(:,2:3)])/det(A)
%pause;
output33=x1;
    
alpha = (0:10);
t = (0:0.001:0.2)';
T = t*ones(1,11);
H = exp(-T*diag(alpha)).*sin(2*pi*10*T+pi/6);
plot(t,H); xlabel('t'); ylabel('h(t)');
%pause; clf;
output34=H;

% Partial Fraction Expansions
[R,P,K] = residue([1 0 0 0 0 pi],[1 -sqrt(8) 0 sqrt(32) -4])
output35= residue([1 0 0 0 0 pi],[1 -sqrt(8) 0 sqrt(32) -4])

%echo off
