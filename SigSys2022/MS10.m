% MATLAB Session 10: Toolboxes and State-Space Analysis
clear; echo on

%  z-Transform Solutions to Discrete-Time State-Space Systems:
A = [0 1;-1/6 5/6]; B = [0; 1]; C = [-1 5]; D = 0;
q_0 = [2;3];
%pause

z = sym('z');
whos
%pause
output1=z;

X = ztrans(sym('1'))
%pause
output2=X;

Q = inv(eye(2)-z^(-1)*A)*q_0 + inv(z*eye(2)-A)*B*X
%pause 
output3=Q;

Q = simplify(Q)
%pause
output4=Q;

Y = simplify(C*Q)
%pause
output5=Y;

y = iztrans(Y)
%pause
output6=Y;

y_0 = iztrans(simplify(C*inv(eye(2)-z^(-1)*A)*q_0))
%pause
output7=y_0;

y-y_0
iztrans(simplify(C*inv(z*eye(2)-A)*B*X))
%pause
output8=iztrans(simplify(C*inv(z*eye(2)-A)*B*X))


n = [0:25]; stem(n,subs(y,n),'k'); xlabel('n'); ylabel('y[n]');
%pause; clf;
output9=subs(y,n);

% Transfer Functions from State-Space Representations
H = simplify(C*inv(z*eye(2)-A)*B+D)
%pause
output10=H;

[num,den] = ss2tf(A,B,C,D)
%pause
output11=[num,den];


syms gamma; char_poly = subs(det(z*eye(2)-A),z,gamma)
%pause
output12=char_poly;

roots(sym2poly(char_poly))
%pause
output13=roots(sym2poly(char_poly));

h = iztrans(H)
%pause
output14=h;

iztrans(z^(-2)*X)
%pause
output15=iztrans(z^(-2)*X);

iztrans(H*X)
%pause
output16=iztrans(H*X);

% Controllability and Observability of Discrete-Time Systems:
A = [0 1;-1/6 -5/6]; B = [0; 1]; C = [-1/6 -1/3]; D = 1;
[V,Lambda] = eig(A)
%pause
output17=[V,Lambda];

P = inv(V);
Ahat = P*A*inv(P), Bhat = P*B, Chat = C*inv(P)
%pause 
output18=Ahat;

A = [0 -1/6;1 -5/6]; B = [-1/6; -1/3]; C = [0 1]; D = 1;
[V,Lambda] = eig(A)
%pause
output19=[V,Lambda];

P = inv(V);
Ahat = P*A*inv(P), Bhat = P*B, Chat = C*inv(P)
%pause 
output20=Ahat;

% Matrix Exponentiation and the Matrix Exponential:
A = [0 1;-1/6 5/6]; n = 3; A^n
%pause
output21=A^n;

A*A*A
%pause
output22=A*A*A;

syms z n; An = simplify(iztrans(inv(eye(2)-z^(-1)*A)))
%pause
output23=An;

subs(An,n,3)
%pause
output24=subs(An,n,3);

syms t; A = [-12 2/3;-36 -1]; eAt = simplify(expm(A*t))
%pause
output25=eAt;

syms s; simplify(ilaplace(inv(s*eye(2)-A)))
%pause
output26=simplify(ilaplace(inv(s*eye(2)-A)));

subs(eAt,t,3)
%pause
output27=subs(eAt,t,3)

expm(A*3)
output28=expm(A*3);

echo off
