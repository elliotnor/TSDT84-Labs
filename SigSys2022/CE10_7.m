A = [0 1;-1/6 5/6]; B = [0; 1]; C = [-1 5]; D = 0;
        sys = ss(A,B,C,D,0); % Discrete-time state space model
        N = 25; x = ones(1,N+1); n = (0:N); q0 = [2;3];
        [y,q] = lsim(sys,x,n,q0); % Simulate output and state vector
        clf; stem(n,y,'k'); xlabel('n'); ylabel('y[n]'); axis([-.5 25.5 11.5 13.5]);

output=y;