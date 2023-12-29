r = roots([1 4 3]);
output1=r;
        disp(['Case (k=3): roots = [',num2str(r.'),']']);
        r = roots([1 4 4]);
output2=r;
        disp(['Case (k=4): roots = [',num2str(r.'),']']);
        r = roots([1 4 40]);
        disp(['Case (k=40): roots = [',num2str(r.',' %0.5g'),']']);
output3=r;
