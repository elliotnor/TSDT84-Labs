num = [2 10]; den = [1 8 19 12];
        [A,B,C,D] = tf2ss(num,den) % Transfer function to state space
        [num,den] = ss2tf(A,B,C,D); % State space to transfer function
        tf(num,den)
output=tf(num,den);