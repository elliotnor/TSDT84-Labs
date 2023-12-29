H = tf(1,1); K = 7; G = tf([0 0 K],conv([0 1 0],[0 1 8]));
        TFa = feedback(G,H);
        H = tf(1,1); K = 16; G = tf([0 0 K],conv([0 1 0],[0 1 8]));
        TFb = feedback(G,H);
        H = tf(1,1); K = 80; G = tf([0 0 K],conv([0 1 0],[0 1 8]));
        TFc = feedback(G,H);
        figure(1); clf; step(TFa,'k-',TFb,'k--',TFc,'k-.'); 
        legend('(a) K = 7','(b) K = 16','(c) K = 80');
        % Unit ramp response for K = 80:
        TFd = series(TFc,tf([0 1],[1 0]));
        figure(2); clf; step(TFd,'k-'); legend('(d) K = 80'); 
        title('Unit Ramp Response')
output1=TFa;
output2=TFb;
output3=TFc;
output4=TFd;
