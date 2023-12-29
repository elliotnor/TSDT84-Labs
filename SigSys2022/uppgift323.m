figure(323);
f=S2(KlabL+2)*(0:(KlabL/2-1));
f = [f, flip(-1*f(2:end-1))];
b=find(f<=400 & f>=-400); plot(f(b),abs(S2(b)),'b')
xlabel('Frekvens [Hz]'); title('Amplitudspektrum |S_2(f)|'); grid, ohfig