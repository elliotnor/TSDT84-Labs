figure(324);
s3 = in('cos(2*pi*200*t)*pulse(t,0,1/40)', 't');
S3 = foutr(s3);
f = S3(KlabL+2)*(0:(KlabL/2-1));
f = [f, flip(-1*f(2:end-1))];
b=find(f<=400 & f>=-400); plot(f(b),abs(S3(b)))
xlabel('Frekvens [Hz]'); title('Amplitudspektrum |S_3(f)|'); grid, ohfig