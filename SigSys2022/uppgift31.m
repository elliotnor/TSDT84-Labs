pm1=tau;
p = in('pulse(t,0,pm1)', 't');
if Fyrkantpuls
    figure(311)
    signal(p); title('Fyrkantpuls p(t)')
    xlabel('Tid [s]'), xlim([-1 11]), ohfig 
end
if Spektrum
    figure(312)
    spectmod(foutr(p),'A',1.4); title('Amplitudspektrum |P(f)|')
    xlabel('Frekvens [Hz]'), ylim([0 10]); yticks(0:2:10), ohfig
end