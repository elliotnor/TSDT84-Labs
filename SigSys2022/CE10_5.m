A = [0 1;-2 -3]; B = [1; 2];
        [V, Lambda] = eig(A);
        P = inv(V), Lambda, Bhat = P*B
output1=P;
output2=Lambda;
output3=Bhat;