A = [0 1;-1/6 5/6]; B = [0; 1]; C = [-1 5]; D = 0;
        N = 25; x = ones(1,N+1); n = (0:N); 
        [num,den] = ss2tf(A,B,C,D); 
        y = filter(num,den,x);
        clf; stem(n,y,'k'); xlabel('n'); ylabel('y[n] (ZSR)');
        axis([-.5 25.5 -0.5 12.5]);
        % Similar to CE10(7), an equivalent method is:
        % sys = ss(A,B,C,D,-1); y = lsim(sys,x,n);
output=y;