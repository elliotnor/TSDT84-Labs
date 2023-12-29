if Visa_h1
    h1=in('us(n-1)','n');
    figure(511)
    signal(h1,20)
    title('h_1[n]')
    xlabel('n')
    axis([-5 20 0 1.1])
    ohfig
end

if Visa_h2
    h2=in('-19/6*pulse(n,0,1) + (1.5*2^n + 5/3*3^n)*us(n)','n');
    figure(512)
    signal(h2,20)
    title('h_2[n]')
    xlabel('n')
    xlim([-5 20])
    ohfig
end

if Visa_h3
    h3=in('2*pulse(n,0,1) - 2*pulse(n,1,2)','n');
    figure(513)
    signal(h3,20)
    title('h_3[n]')
    xlabel('n')
    axis([-5 20 -2.1 2.1])
    ohfig
end

