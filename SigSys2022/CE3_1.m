n = (0:5);
        x_a = (-0.5).^n; x_b = 2.^(-n); x_c = (-2).^n;
        subplot(3,1,1); stem(n,x_a,'k'); ylabel('x_a[n]')
        subplot(3,1,2); stem(n,x_b,'k'); ylabel('x_b[n]')
        subplot(3,1,3); stem(n,x_c,'k'); ylabel('x_c[n]'); xlabel('n');
output1=x_a;
output2=x_b;
output3=x_c;
