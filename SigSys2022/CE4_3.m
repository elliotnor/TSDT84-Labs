H = tf(1,1); K = 7; G = tf([0 0 K],[1 8 0]);
        disp(['(a) K = ',num2str(K)]); TFa = feedback(G,H)
        H = tf(1,1); K = 16; G = tf([0 0 K],[1 8 0]);
        disp(['(b) K = ',num2str(K)]); TFb = feedback(G,H)
        H = tf(1,1); K = 80; G = tf([0 0 K],[1 8 0]);
        disp(['(c) K = ',num2str(K)]); TFc = feedback(G,H)
output1=TFa;
output2=TFb;
output3=TFc;