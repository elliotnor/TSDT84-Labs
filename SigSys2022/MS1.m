% MATLAB Session 1: Working with Functions
echo on

% Inline Functions:
f = inline('exp(-t).*cos(2*pi*t)','t')
pause;

t = 0;
f(t)
pause;

f(0)
pause;

t = (-2:2);
f(t)
pause;

plot(t,f(t));
xlabel('t'); ylabel('f(t)'); grid;
pause; 
clf;

t = (-2:0.01:2);
plot(t,f(t));
xlabel('t'); ylabel('f(t)'); grid;
pause; 
clf;


% Relational Operators and the Unit Step Function:
u = inline('(t>=0)','t')
pause;

t = (-2:2);
plot(t,u(t));
xlabel('t'); ylabel('u(t)');
pause; 
clf;

t = (-2:0.01:2);
plot(t,u(t));
xlabel('t'); ylabel('u(t)');
axis([-2 2 -0.1 1.1]);
pause; 
clf;

p = inline('(t>=0)&(t<1)','t');
t = (-1:0.01:2);
plot(t,p(t));
xlabel('t'); ylabel('p(t) = u(t)-u(t-1)');
axis([-1 2 -.1 1.1]);
pause; 
clf;


% Visualizing Operations on the Independent Variable:
g = inline('exp(-t).*cos(2*pi*t).*(t>=0)','t')
pause;

t = (-2:0.01:2);
plot(t,g(2*t+1)); xlabel('t'); ylabel('g(2t+1)'); grid;
pause; 
clf;

plot(t,g(-t+1)); xlabel('t'); ylabel('g(-t+1)'); grid;
pause; 
clf;

plot(t,g(2*t+1)+g(-t+1)); xlabel('t'); ylabel('h(t)'); grid;
pause; 
clf;


% Numerical Integration and Estimating Signal Energy:
x = inline('exp(-t).*((t>=0)&(t<1))','t');
t = (0:0.01:1);
E_x = sum(x(t).*x(t)*0.01)
pause;


x_squared = inline('exp(-2*t).*((t>=0)&(t<1))','t');
E_x = quad(x_squared,0,1)
pause;

g_squared = inline('exp(-2*t).*(cos(2*pi*t).^2).*(t>=0)','t');
t = (0:0.001:100);
E_g = sum(g_squared(t)*0.001)
pause;

E_g = quad(g_squared,0,100)

echo off
