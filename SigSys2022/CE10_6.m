A = [1 0;1 -1]; B = [1; 0]; C = [1 -2];
        [V, Lambda] = eig(A); P=inv(V);
        disp('Part (a):'), Bhat = P*B, Chat = C*inv(P)

output1=Bhat;
output2=Chat;

        A = [-1 0;-2 1]; B = [1; 1]; C = [0 1];
        [V, Lambda] = eig(A); P=inv(V);
        disp('Part (b):'), Bhat = P*B, Chat = C*inv(P),
output3=Bhat;
output4=Chat;

%Correct values Bhat and Chat in both cases, but the columns are reversed